--Function rep_sale_for_acc(in_date_from timestamp,in_date_to timestamp,in_store_id integer)

-- DROP FUNCTION rep_sale_for_acc(in_date_from timestamp,in_date_to timestamp,in_store_id integer);

CREATE OR REPLACE FUNCTION rep_sale_for_acc(in_date_from timestamp,in_date_to timestamp,in_store_id integer)
RETURNS table(
	store_id int,
	store_descr text,
	material_id int,
	material_descr text,	
	quant_sale numeric,
	cost_sale numeric,
	quant_disp numeric,
	cost_disp numeric	
	) AS
$BODY$
	SELECT
		sub.store_id,
		st.name::text AS store_descr,
		sub.material_id,
		m.name::text AS material_descr,
		SUM(sub.quant_sale),
		SUM(sub.cost_sale),
		SUM(sub.quant_disp),
		SUM(sub.cost_disp)		
	FROM(
		--продажи материалов
		(
		SELECT
			ra.store_id,			
			ra.material_id,			
			SUM(ra.quant) AS quant_sale,
			SUM(ra.cost) AS cost_sale,
			0 AS quant_disp,
			0 AS cost_disp
		FROM ra_materials AS ra
		WHERE ra.date_time BETWEEN $1 AND $2
			AND ($3 IS NULL OR $3=0 OR ($3>0 AND $3=ra.store_id))
			AND ra.doc_type='sale'::doc_types
		GROUP BY 
			ra.store_id,
			ra.material_id
		)
		
		UNION ALL
		
		--продажи букетов
		(
		SELECT
			ra_m.store_id,
			ra_m.material_id,
			SUM(ra_m.quant) AS quant_sale,
			SUM(ra_m.cost) AS cost_sale,
			0 AS quant_disp,
			0 AS cost_disp		
		FROM ra_products AS ra_p
		LEFT JOIN ra_materials ra_m ON
			ra_m.doc_type='production'
			AND ra_m.doc_id=ra_p.doc_production_id
		WHERE ra_m.date_time BETWEEN $1 AND $2
			AND ($3 IS NULL OR $3=0 OR ($3>0 AND $3=ra_m.store_id))
		GROUP BY 
			ra_m.store_id,
			ra_m.material_id
		)
		
		UNION ALL
		
		--списание материалов
		(
		SELECT
			ra.store_id,
			ra.material_id,
			0 AS quant_sale,
			0 AS cost_sale,
			SUM(ra.quant) AS quant_disp,
			SUM(ra.cost) AS cost_disp
		FROM ra_materials AS ra
		WHERE ra.date_time BETWEEN $1 AND $2
			AND ($3 IS NULL OR $3=0 OR ($3>0 AND $3=ra.store_id))
			AND ra.doc_type='material_disposal'::doc_types
		GROUP BY 
			ra.store_id,
			ra.material_id
		)
	) AS sub
	LEFT JOIN stores st ON st.id=sub.store_id
	LEFT JOIN materials m ON m.id=sub.material_id
	GROUP BY 
		sub.store_id,
		st.name,
		sub.material_id,
		m.name	
	ORDER BY 
		st.name,
		m.name			
	;
$BODY$  
LANGUAGE sql VOLATILE COST 100;
	
ALTER FUNCTION rep_sale_for_acc(timestamp,timestamp,integer)
OWNER TO bellagio;
