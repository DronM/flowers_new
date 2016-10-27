-- Function: material_list_with_balance(integer, integer, timestamp without time zone)

DROP FUNCTION material_list_with_balance(integer, integer, timestamp without time zone);

CREATE OR REPLACE FUNCTION material_list_with_balance(IN in_store_id integer, IN in_group_id integer, IN in_date_time timestamp without time zone)
  RETURNS TABLE(
  	id integer,
  	name text,
  	material_group_id integer,
  	material_group_descr text,
  	price numeric,
  	main_quant numeric,
  	main_total numeric,
  	procur_avg_time interval
  	) AS
$BODY$
		WITH data AS
		(
		WITH b_main_detail AS
			(SELECT
				rg_main.material_id,
				rg_main.quant AS quant,
				now()-doc.date_time AS procur_interval
			FROM rg_materials_balance(
				$3,
				ARRAY[$1],
				ARRAY['main'::stock_types],'{}','{}'
			) AS rg_main
			LEFT JOIN doc_material_procurements AS doc ON doc.id=rg_main.doc_procurement_id
			)
		SELECT 
			m.id AS id,
			m.name::text AS name,
			mg.id AS material_group_id,
			mg.name::text AS material_group_descr,
			m.price AS price,
			
			b_main.quant AS main_quant,
			m.price*b_main.quant AS main_total,			
			
				
			--after procurement average time
			(SELECT AVG(procur_interval) FROM b_main_detail WHERE b_main_detail.material_id=m.id) AS procur_avg_time
		FROM materials AS m
		LEFT JOIN 
			(SELECT b_main_detail.material_id,SUM(b_main_detail.quant) AS quant			
			FROM b_main_detail
			GROUP BY b_main_detail.material_id
			) AS b_main
		ON b_main.material_id=m.id

		LEFT JOIN material_groups As mg ON mg.id=m.material_group_id
		
		WHERE 
		--m.for_sale=TRUE
		b_main.quant<>0 AND
		($2=0 OR (($2>0) AND (m.material_group_id=$2)))
		ORDER BY m.name
		)
		
		SELECT 
			data.id,
			data.name,
			data.material_group_id,
			data.material_group_descr,
			data.price,
			data.main_quant,
			data.main_total,
			data.procur_avg_time
		FROM data
		
		UNION ALL
		
		SELECT
			NULL AS id,
			NULL AS name,
			NULL AS material_group_id,
			NULL AS material_group_descr,
			NULL AS price,
			NULL AS main_quant,
			round(SUM(agg.main_total),2) AS main_total,
			AVG(agg.procur_avg_time) AS procur_avg_time
		FROM data AS agg;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION material_list_with_balance(integer, integer, timestamp without time zone)
  OWNER TO bellagio;
