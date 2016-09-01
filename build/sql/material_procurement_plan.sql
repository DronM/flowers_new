--SELECT * FROM material_procurement_plan('2013-12-13',ARRAY[1,1,1,1,1.2,1,1])
/* Function: material_procurement_plan(
	IN in_date_time timestamp without time zone,
	IN in_day_turnover_ar numeric[],
	in_stock_in_day_count int
)
*/
/*
DROP FUNCTION material_procurement_plan(
	IN in_day_count int,
	IN in_day_turnover_ar numeric[],
	IN in_stock_in_day_count int,
	IN in_store_id int
);
*/
CREATE OR REPLACE FUNCTION material_procurement_plan(
	IN in_day_count int,
	IN in_day_turnover_ar numeric[],
	IN in_stock_in_day_count int,
	IN in_store_id int
	)
  RETURNS TABLE(
	material_descr text,
	quant_norm numeric,
	quant_balance_begin numeric,
	quant_on_products numeric,
	quant_balance_end numeric,
	quant_procur numeric[],
	quant_flow numeric[],
	quant_order numeric[],
	quant_balance numeric[],
	quant_need numeric[]
  ) AS
$BODY$
DECLARE
	v_query text;
	v_query_part_procur text;
	v_query_part_flow text;
	v_query_part_order text;
	v_query_part_need text;
	v_query_part_bal text;
	v_query_part text;
	
	--Monday of current week
	v_date_time_start timestamp without time zone;
	v_date_start date;
	v_date_time_end timestamp without time zone;
	i int;
	k int;
	v_date date;
BEGIN
	i = EXTRACT(DOW FROM CURRENT_DATE);
	IF (i=0) THEN
		i = 6;
	ELSIF (i=1) THEN
		i = 0;
	ELSE
		i = i-1;
	END IF;
	v_date_time_start = (CURRENT_DATE-(i||' days')::interval)+'00:00:00.000'::interval;
	v_date_time_end = (v_date_time_start::date+((in_day_count-1)||' days')::interval)+'23:59:59.999'::interval;
	v_date_start = v_date_time_start::date;
	
	v_query = '
	WITH
	mat_bal_from_specif AS (
		SELECT
			sp.material_id,
			COALESCE(SUM(b.quant),0) AS quant
		FROM rg_products_balance('''|| v_date_time_start ||''',
			ARRAY['||in_store_id||'],
			ARRAY(
				SELECT DISTINCT sp.product_id FROM specifications AS sp
				LEFT JOIN products AS p ON p.id=sp.product_id
				WHERE p.for_sale
				),
			''{}'') AS b
		LEFT JOIN specifications AS sp ON sp.product_id=b.product_id
		GROUP BY sp.material_id
	),
	mat_list AS (
	/*
		material list consists of
			1) all materials from specifications of products which have balance
			2) all materials from specifications of products for sale
		
	*/
		SELECT material_id FROM mat_bal_from_specif
		UNION
		SELECT DISTINCT material_id
		FROM specifications AS sp
		LEFT JOIN products AS p ON p.id=sp.product_id
		WHERE p.for_sale
	),
	mat_procur AS (
		SELECT
			t.material_id,
			t.date_time::date AS date,
			COALESCE(SUM(t.quant),0) AS quant
		FROM ra_materials AS t
		WHERE t.material_id IN (SELECT material_id FROM mat_list)
		AND (t.date_time BETWEEN '''||v_date_time_start||''' AND '''||v_date_time_end||''')
		AND t.deb
		GROUP BY t.material_id,t.date_time
		ORDER BY t.material_id,t.date_time
		 ),
		 
	mat_flow AS (
		SELECT
			t.material_id,
			t.date_time::date AS date,
			COALESCE(SUM(t.quant),0) AS quant
		FROM ra_materials AS t
		WHERE t.material_id IN (SELECT material_id FROM mat_list)
		AND (t.date_time BETWEEN '''||v_date_time_start||''' AND '''||v_date_time_end||''')
		AND NOT t.deb
		GROUP BY t.material_id,t.date_time
		ORDER BY t.material_id,t.date_time
		 ),
	mat_order AS (
		SELECT
			t.material_id,
			h.date_time::date AS date,
			COALESCE(SUM(t.quant)) AS quant
		FROM doc_material_orders_t_materials AS t
		LEFT JOIN doc_material_orders AS h ON h.id=t.doc_id
		WHERE t.material_id IN (SELECT material_id FROM mat_list)
		AND (h.date_time BETWEEN '''||v_date_time_start||''' AND '''||v_date_time_end||''')
		GROUP BY t.material_id,h.date_time
		ORDER BY t.material_id,h.date_time
		 )     


	SELECT
		/* ***************** BALANCE *******************/
		m.name::text AS material_descr,
		COALESCE(sp.quant,0)*'||in_stock_in_day_count||' AS quant_norm,
		COALESCE(bal.quant,0) AS quant_balance_begin,
		COALESCE(mat_bal_from_specif.quant,0) AS quant_on_products,
		COALESCE(bal.quant,0) + COALESCE(mat_bal_from_specif.quant,0) -
			(COALESCE(sp.quant,0)*'||in_stock_in_day_count||') AS quant_balance_end,
		/* **************************************** */
		';
		
	--days
	v_query_part_procur = '';
	v_query_part_flow = '';
	v_query_part_order = '';
	
	FOR i IN 1..in_day_count LOOP
		IF (i>1) THEN
			v_query_part_procur =  v_query_part_procur ||',';
			v_query_part_flow =  v_query_part_flow ||',';
			v_query_part_order =  v_query_part_order ||',';
		END IF;
		
		v_date = v_date_start + ((i-1)||' days')::interval;
		k = EXTRACT(DOW FROM v_date);
		IF (k=0) THEN
			k = 7;
		END IF;
		
		v_query_part_procur = v_query_part_procur||'
		CASE
			WHEN '''||v_date||'''::date < CURRENT_DATE THEN
				--fact
				(SELECT
				COALESCE(SUM(ROUND(mat_procur.quant)),0) AS quant
				FROM mat_procur
				WHERE mat_procur.material_id=m.id
				AND mat_procur.date='''||v_date||''')
			ELSE 0::numeric		
		END';

		v_query_part_order = v_query_part_order ||'
		CASE
			WHEN '''||v_date||'''::date >= CURRENT_DATE THEN
				(SELECT
				COALESCE(SUM(ROUND(mat_order.quant)),0) AS quant
				FROM mat_order
				WHERE mat_order.material_id=m.id
				AND mat_order.date='''||v_date||''')				
			ELSE 0::numeric		
		END';
		
		v_query_part_flow = v_query_part_flow||'
		CASE
			WHEN '''||v_date||'''::date < CURRENT_DATE THEN
				--fact
				(SELECT
				COALESCE(SUM(ROUND(mat_flow.quant)),0) AS quant
				FROM mat_flow
				WHERE mat_flow.material_id=m.id
				AND mat_flow.date='''||v_date||''')				
			ELSE
				COALESCE(ROUND(sp.quant*'||in_day_turnover_ar[k]||'),0)
		END';
	END LOOP;
	
	v_query = v_query ||'
	--procurement
	ARRAY['||v_query_part_procur||'] AS quant_procur,
	
	--flow
	ARRAY['||v_query_part_flow||'] AS quant_flow,		
	
	--order
	ARRAY['||v_query_part_order||'] AS quant_order		
	
	FROM mat_list
	LEFT JOIN materials AS m ON m.id=mat_list.material_id
	LEFT JOIN (
		SELECT
			s.material_id,
			COALESCE(SUM(s.material_quant*s.product_quant),0) AS quant
		FROM specifications AS s
		GROUP BY s.material_id
	) AS sp ON sp.material_id=mat_list.material_id
	
	--balance on begining
	LEFT JOIN 
	   (
		SELECT
			material_id,
			COALESCE(SUM(quant),0) AS quant
		FROM rg_materials_balance(
			'''||v_date_time_start||''',
			ARRAY['||in_store_id||'],
			''{}'',
			ARRAY(SELECT material_id FROM mat_list),
			''{}''
		)
		GROUP BY material_id
	   ) AS bal ON bal.material_id=mat_list.material_id

	LEFT JOIN mat_bal_from_specif ON mat_bal_from_specif.material_id=mat_list.material_id	   
	';
	v_query = v_query || 'ORDER BY m.name';
	
	--day balances
	v_query_part_bal = '';
	v_query_part_need = '';
	FOR i IN 1..in_day_count LOOP
		v_query_part = '
		(
		(ROUND(sub.quant_balance_end)+(sub.quant_procur[1]+sub.quant_order[1])-sub.quant_flow['||k||'])
		';				
	
		FOR k IN 2..i LOOP
			v_query_part = v_query_part ||'
			+((sub.quant_procur['||k||']+sub.quant_order['||k||'])-sub.quant_flow['||k||'])
			';
		END LOOP;
		v_query_part = v_query_part ||'
		)';	

		IF i>1 THEN
			v_query_part_bal =  v_query_part_bal ||',';
			v_query_part_need =  v_query_part_need ||',';
		END IF;		
		v_query_part_bal = v_query_part_bal || v_query_part;
		v_query_part_need = v_query_part_need ||'
		CASE
			WHEN '||v_query_part||'>0 THEN 0
			ELSE '||v_query_part||'*-1
		END
		';
	END LOOP;
	v_query = '
	SELECT
		sub.material_descr,
		ROUND(sub.quant_norm),
		ROUND(sub.quant_balance_begin),
		ROUND(sub.quant_on_products),
		ROUND(sub.quant_balance_end),
		sub.quant_procur,
		sub.quant_flow,
		sub.quant_order,		
		ARRAY['||v_query_part_bal||'] AS quant_balance,
		ARRAY['||v_query_part_need||'] AS quant_need
	FROM ('||v_query||') AS sub
	';	
	--RAISE EXCEPTION '%',v_query;
	RETURN QUERY EXECUTE v_query;
END;			
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100 ROWS 1000;
ALTER FUNCTION material_procurement_plan(
	IN in_day_count int,
	IN in_day_turnover_ar numeric[],
	IN in_stock_in_day_count int,
	IN in_store_id int
) OWNER TO bellagio;
