-- Function: material_list_with_balance(integer, integer, timestamp without time zone)

-- DROP FUNCTION material_list_with_balance(integer, integer, timestamp without time zone);

CREATE OR REPLACE FUNCTION material_list_with_balance(IN in_store_id integer, IN in_group_id integer, IN in_date_time timestamp without time zone)
  RETURNS TABLE(id integer, name text, material_group_id integer, material_group_descr text, price text, main_quant text, main_total text, main_quant_descr text, procur_avg_time_descr text) AS
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
			format_money(m.price) AS price,
			
			b_main.quant AS main_quant,
			m.price*b_main.quant AS main_total,			
			CASE 
				WHEN b_main.quant IS NULL OR b_main.quant=0 THEN ''
				ELSE round(b_main.quant)::text
			END AS main_quant_descr,
			/*
			format_money(
				(SELECT
					CASE 
						WHEN rg_material_costs.cost=0 THEN 0
						ELSE rg_material_costs.cost/rg_material_costs.quant
					END
				FROM rg_material_costs WHERE store_id=in_store_id AND rg_material_costs.material_id=m.id AND rg_material_costs.date_time=reg_current_balance_time())
				)  AS cost,
				
				(SELECT
					CASE 
						WHEN rg_material_costs.cost=0 THEN 0
						ELSE rg_material_costs.cost/rg_material_costs.quant
					END
				FROM rg_material_costs
				WHERE store_id=in_store_id AND rg_material_costs.material_id=m.id
				AND rg_material_costs.date_time=reg_current_balance_time())*b_main.quant
				AS cost_main_total,
			*/	
				
			--after procurement average time
			(SELECT interval_descr(AVG(procur_interval)) FROM b_main_detail WHERE b_main_detail.material_id=m.id) AS procur_avg_time_descr,
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
			data.id, data.name,
			data.material_group_id,data.material_group_descr,
			data.price,
			format_quant(data.main_quant),
			format_money(data.main_total),
			data.main_quant_descr,
			data.procur_avg_time_descr
		FROM data
		UNION ALL
		SELECT
			NULL AS id, NULL AS name, NULL AS material_group_id, NULL AS material_group_descr, NULL AS price,
			NULL AS main_quant,
			--format_money(SUM(agg.main_total)) AS main_total,
			round(SUM(agg.main_total),2)::text AS main_total,
			NULL AS main_quant_descr,
			interval_descr(AVG(agg.procur_avg_time)) AS procur_avg_time_descr
		FROM data AS agg;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION material_list_with_balance(integer, integer, timestamp without time zone)
  OWNER TO bellagio;
