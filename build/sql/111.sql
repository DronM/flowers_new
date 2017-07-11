CREATE OR REPLACE FUNCTION rg_products_balance(IN in_date_time timestamp without time zone, IN in_store_id_ar integer[], IN in_product_id_ar integer[], IN in_doc_production_id_ar integer[])
  RETURNS TABLE(store_id integer, product_id integer, doc_production_id integer, quant numeric, cost numeric) AS
$BODY$
	WITH
	cur_per AS (SELECT rg_period('product'::reg_types, in_date_time) AS v ),
	
	act_forward AS (
		SELECT
			rg_period_balance('product'::reg_types,in_date_time) - in_date_time >
			(SELECT t.v FROM cur_per t) - in_date_time
			AS v
	),
	
	act_sg AS (SELECT CASE WHEN t.v THEN 1 ELSE -1 END AS v FROM act_forward t)
	
	SELECT 
	
	sub.store_id,
	sub.product_id,
	sub.doc_production_id
	,SUM(sub.quant) AS quant
	,SUM(sub.cost) AS cost				
	FROM(
		(
		SELECT
		
			b.store_id,
			b.product_id,
			b.doc_production_id
			,b.quant
			,b.cost				
		FROM rg_products AS b
		WHERE 
		(
			--date bigger than last calc period
			(in_date_time > rg_period_balance('product'::reg_types,rg_calc_period('product'::reg_types)) AND b.date_time = (SELECT rg_current_balance_time()))
			
			OR
			(
			--forward from previous period
			( (SELECT t.v FROM act_forward t) AND b.date_time = (SELECT t.v FROM cur_per t)-rg_calc_interval('product'::reg_types)
			)
			
			--backward from current
			OR			
			( NOT (SELECT t.v FROM act_forward t) AND b.date_time = (SELECT t.v FROM cur_per t)
			)
			
			)
			
		)	
		
		AND ((in_store_id_ar IS NULL OR ARRAY_LENGTH(in_store_id_ar,1) IS NULL) OR (b.store_id=ANY(in_store_id_ar)))
		
		AND ((in_product_id_ar IS NULL OR ARRAY_LENGTH(in_product_id_ar,1) IS NULL) OR (b.product_id=ANY(in_product_id_ar)))
		
		AND ((in_doc_production_id_ar IS NULL OR ARRAY_LENGTH(in_doc_production_id_ar,1) IS NULL) OR (b.doc_production_id=ANY(in_doc_production_id_ar)))
		
		)
		
		UNION ALL
		
		(SELECT
		
		act.store_id,
		act.product_id,
		act.doc_production_id
		
		,CASE act.deb
			WHEN TRUE THEN act.quant * (SELECT t.v FROM act_sg t)
			ELSE -act.quant * (SELECT t.v FROM act_sg t)
		END AS quant
		
		,CASE act.deb
			WHEN TRUE THEN act.cost * (SELECT t.v FROM act_sg t)
			ELSE -act.cost * (SELECT t.v FROM act_sg t)
		END AS cost
		FROM ra_products AS act
		WHERE
		 
		(
			--forward from previous period
			( (SELECT t.v FROM act_forward t)
					AND act.date_time >= (SELECT t.v FROM cur_per t)
					AND
					act.date_time <= 
						(SELECT l.date_time FROM doc_log l
						WHERE date_trunc('second',l.date_time)<=date_trunc('second',in_date_time)
						ORDER BY l.date_time DESC LIMIT 1
						)
			)
			
			--backward from current			
			OR
			( NOT (SELECT t.v FROM act_forward t) AND
					act.date_time >= 
						(SELECT l.date_time FROM doc_log l
						WHERE date_trunc('second',l.date_time)>=date_trunc('second',in_date_time)
						ORDER BY l.date_time ASC LIMIT 1
						)			
					AND act.date_time <= (SELECT t.v FROM cur_per t)
			)
			
		)
		
		AND (( in_store_id_ar IS NULL OR ARRAY_LENGTH(in_store_id_ar,1) IS NULL) OR (act.store_id=ANY(in_store_id_ar)))
		
		AND ( (in_product_id_ar IS NULL OR ARRAY_LENGTH(in_product_id_ar,1) IS NULL) OR (act.product_id=ANY(in_product_id_ar)))
		
		AND ( (in_doc_production_id_ar IS NULL OR ARRAY_LENGTH(in_doc_production_id_ar,1) IS NULL) OR (act.doc_production_id=ANY(in_doc_production_id_ar)))
		
		--Where product_id=374
		)
		
	) AS sub
	
	GROUP BY
		
		sub.store_id,
		sub.product_id,
		sub.doc_production_id
	HAVING
		
		SUM(sub.quant)<>0
		OR
		SUM(sub.cost)<>0
						
	ORDER BY
		
		sub.store_id,
		sub.product_id,
		sub.doc_production_id
	;
--END;
$BODY$
  LANGUAGE sql VOLATILE CALLED ON NULL INPUT
  COST 100
  ROWS 1000;
ALTER FUNCTION rg_products_balance(IN in_date_time timestamp without time zone, IN in_store_id_ar integer[], IN in_product_id_ar integer[], IN in_doc_production_id_ar integer[])
  OWNER TO bellagio;

