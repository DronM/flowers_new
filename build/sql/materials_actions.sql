-- Function: material_actions(timestamp, timestamp,integer,integer)
--SELECT * FROM material_actions('2014-11-01','2014-11-15',1,10)
DROP FUNCTION materials_actions(timestamp, timestamp,integer,integer);

CREATE OR REPLACE FUNCTION materials_actions(
	in_date_time_from timestamp,
	in_date_time_to timestamp,
	in_store_id integer,
	in_material_group_id integer
	)
  RETURNS TABLE(
	material_id integer,
	material_descr text,
	--остаток на начало
	beg_mat_quant numeric,
	beg_mat_cost numeric,
	beg_prod_quant numeric,
	beg_prod_cost numeric,
	--Поступление
	procur_quant numeric,
	procur_cost numeric,
	--Комплектация
	production_quant numeric,
	production_cost numeric,
	--Разукомплектация
	prod_disp_quant numeric,
	prod_disp_cost numeric,
	--Списание материалов
	mat_disp_quant numeric,
	mat_disp_cost numeric,
	--Продажа материалов
	mat_sale_quant numeric,
	mat_sale_cost numeric,
	mat_sale_total numeric,
	--Продажа букетов
	prod_sale_quant numeric,
	prod_sale_cost numeric,
	prod_sale_total numeric,
	--остаток на конец
	end_mat_quant numeric,
	end_mat_cost numeric,
	end_prod_quant numeric,
	end_prod_cost numeric	
  ) AS
$BODY$
	WITH
		mat_list AS (
		SELECT
			m.id,
			m.name
		FROM materials m
		WHERE ($4 IS NULL OR $4=0)
			OR $4=m.material_group_id
		)
	SELECT
		m.id AS material_id,
		m.name::text AS material_descr,
		coalesce(sum(sub.beg_mat_quant),0) AS beg_mat_quant,
		coalesce(sum(sub.beg_mat_cost),0) AS beg_mat_cost,
		coalesce(sum(sub.beg_prod_quant),0) AS beg_prod_quant,
		coalesce(sum(sub.beg_prod_cost),0) AS beg_prod_cost,
		--Поступление
		coalesce(sum(sub.procur_quant),0) AS procur_quant,
		coalesce(sum(sub.procur_cost),0) AS procur_cost,
		--Комплектация
		coalesce(sum(sub.production_quant),0) AS production_quant,
		coalesce(sum(sub.production_cost),0) AS production_cost,
		--Разукомплектация
		coalesce(sum(sub.prod_disp_quant),0) AS prod_disp_quant,
		coalesce(sum(sub.prod_disp_cost),0) AS prod_disp_cost,
		--Списание материалов
		coalesce(sum(sub.mat_disp_quant),0) AS mat_disp_quant,
		coalesce(sum(sub.mat_disp_cost),0) AS mat_disp_cost,
		--Продажа материалов
		coalesce(sum(sub.mat_sale_quant),0) AS mat_sale_quant,
		coalesce(sum(sub.mat_sale_cost),0) AS mat_sale_cost,
		coalesce(sum(sub.mat_sale_total),0) AS mat_sale_total,
		--Продажа букетов
		coalesce(sum(sub.prod_sale_quant),0) AS prod_sale_quant,
		coalesce(sum(sub.prod_sale_cost),0) AS prod_sale_cost,
		coalesce(sum(sub.prod_sale_total),0) AS prod_sale_total,
		--остаток на конец
		coalesce(sum(sub.end_mat_quant),0) AS end_mat_quant,		
		coalesce(sum(sub.end_mat_cost),0) AS end_mat_cost,		
		coalesce(sum(sub.end_prod_quant),0) AS end_prod_quant,
		coalesce(sum(sub.end_prod_cost),0) AS end_prod_price
		
	FROM (
		--остатки материалов на начало
		(SELECT
			b.material_id,
			sum(b.quant) AS beg_mat_quant,
			sum(b.cost) AS beg_mat_cost,
			0::numeric AS beg_prod_quant,
			0::numeric AS beg_prod_cost,
			0::numeric AS procur_quant,
			0::numeric AS procur_cost,
			0::numeric AS production_quant,
			0::numeric AS production_cost,
			0::numeric AS prod_disp_quant,
			0::numeric AS prod_disp_cost,
			0::numeric AS mat_disp_quant,
			0::numeric AS mat_disp_cost,
			0::numeric AS mat_sale_quant,
			0::numeric AS mat_sale_cost,
			0::numeric AS mat_sale_total,
			0::numeric AS prod_sale_quant,
			0::numeric AS prod_sale_cost,
			0::numeric AS prod_sale_total,
			0::numeric AS end_mat_quant,
			0::numeric AS end_mat_cost,
			0::numeric AS end_prod_quant,
			0::numeric AS end_prod_cost	
			
		FROM rg_materials_balance(
			$1,ARRAY[$3],ARRAY((SELECT m.id FROM mat_list m))) AS b
		GROUP BY b.material_id
		)
		--остатки материалов на начало в букетах
		UNION
		(
		SELECT
			ram.material_id,
			0::numeric AS beg_mat_quant,
			0::numeric AS beg_mat_cost,
			sum(ram.quant) AS beg_prod_quant,
			sum(ram.cost) As beg_prod_cost,
			0::numeric AS procur_quant,
			0::numeric AS procur_cost,
			0::numeric AS production_quant,
			0::numeric AS production_cost,
			0::numeric AS prod_disp_quant,
			0::numeric AS prod_disp_cost,
			0::numeric AS mat_disp_quant,
			0::numeric AS mat_disp_cost,
			0::numeric AS mat_sale_quant,
			0::numeric AS mat_sale_cost,
			0::numeric AS mat_sale_total,
			0::numeric AS prod_sale_quant,
			0::numeric AS prod_sale_cost,
			0::numeric AS prod_sale_total,
			0::numeric AS end_mat_quant,
			0::numeric AS end_mat_cost,
			0::numeric AS end_prod_quant,
			0::numeric AS end_prod_cost	
			
		FROM rg_products_balance(
			$1,ARRAY[$3],'{}','{}') AS b
		LEFT JOIN ra_materials AS ram ON ram.doc_id=b.doc_production_id AND ram.doc_type='production'
		WHERE ram.material_id IN (SELECT mat_list.id FROM mat_list)
		GROUP BY ram.material_id
		)
		--Поступление
		UNION
		(
		SELECT
			ram.material_id,
			0::numeric AS beg_mat_quant,
			0::numeric AS beg_mat_cost,
			0::numeric AS beg_prod_quant,
			0::numeric AS beg_prod_cost,
			sum(ram.quant) AS procur_quant,
			sum(ram.cost) procur_cost,
			0::numeric AS production_quant,
			0::numeric AS production_cost,
			0::numeric AS prod_disp_quant,
			0::numeric AS prod_disp_cost,
			0::numeric AS mat_disp_quant,
			0::numeric AS mat_disp_cost,
			0::numeric AS mat_sale_quant,
			0::numeric AS mat_sale_cost,
			0::numeric AS mat_sale_total,
			0::numeric AS prod_sale_quant,
			0::numeric AS prod_sale_cost,
			0::numeric AS prod_sale_total,
			0::numeric AS end_mat_quant,
			0::numeric AS end_mat_cost,
			0::numeric AS end_prod_quant,
			0::numeric AS end_prod_cost	
			
		FROM ra_materials AS ram
		WHERE ram.date_time BETWEEN $1 AND $2
			AND ram.doc_type='material_procurement'
			AND ram.material_id IN (SELECT mat_list.id FROM mat_list)
		GROUP BY ram.material_id
		)
		--Комплектация
		UNION
		(
		SELECT
			ram.material_id,
			0::numeric AS beg_mat_quant,
			0::numeric AS beg_mat_cost,
			0::numeric AS beg_prod_quant,
			0::numeric AS beg_prod_cost,
			0::numeric AS procur_quant,
			0::numeric AS procur_cost,
			sum(ram.quant) production_quant,
			sum(ram.cost) production_cost,
			0::numeric AS prod_disp_quant,
			0::numeric AS prod_disp_cost,
			0::numeric AS mat_disp_quant,
			0::numeric AS mat_disp_cost,
			0::numeric AS mat_sale_quant,
			0::numeric AS mat_sale_cost,
			0::numeric AS mat_sale_total,
			0::numeric AS prod_sale_quant,
			0::numeric AS prod_sale_cost,
			0::numeric AS prod_sale_total,
			0::numeric AS end_mat_quant,
			0::numeric AS end_mat_cost,
			0::numeric AS end_prod_quant,
			0::numeric AS end_prod_cost	
			
		FROM ra_materials AS ram
		WHERE ram.date_time BETWEEN $1 AND $2
			AND ram.doc_type='production'
			AND ram.material_id IN (SELECT mat_list.id FROM mat_list)
		GROUP BY ram.material_id
		)
		--Разукомплектация
		UNION
		(
		SELECT
			ram.material_id,
			0::numeric AS beg_mat_quant,
			0::numeric AS beg_mat_cost,
			0::numeric AS beg_prod_quant,
			0::numeric AS beg_prod_cost,
			0::numeric AS procur_quant,
			0::numeric AS procur_cost,
			0::numeric AS production_quant,
			0::numeric AS production_cost,
			sum(ram.quant) prod_disp_quant,
			sum(ram.cost) prod_disp_cost,
			0::numeric AS mat_disp_quant,
			0::numeric AS mat_disp_cost,
			0::numeric AS mat_sale_quant,
			0::numeric AS mat_sale_cost,
			0::numeric AS mat_sale_total,
			0::numeric AS prod_sale_quant,
			0::numeric AS prod_sale_cost,
			0::numeric AS prod_sale_total,
			0::numeric AS end_mat_quant,
			0::numeric AS end_mat_cost,
			0::numeric AS end_prod_quant,
			0::numeric AS end_prod_cost	
			
		FROM ra_materials AS ram
		WHERE ram.date_time BETWEEN $1 AND $2
			AND ram.doc_type='product_disposal'
			AND ram.material_id IN (SELECT mat_list.id FROM mat_list)
		GROUP BY ram.material_id
		)
		--Списание материалов
		UNION
		(
		SELECT
			ram.material_id,
			0::numeric AS beg_mat_quant,
			0::numeric AS beg_mat_cost,
			0::numeric AS beg_prod_quant,
			0::numeric AS beg_prod_cost,
			0::numeric AS procur_quant,
			0::numeric AS procur_cost,
			0::numeric AS production_quant,
			0::numeric AS production_cost,
			0::numeric AS prod_disp_quant,
			0::numeric AS prod_disp_cost,
			sum(ram.quant) mat_disp_quant,
			sum(ram.cost) mat_disp_cost,
			0::numeric AS mat_sale_quant,
			0::numeric AS mat_sale_cost,
			0::numeric AS mat_sale_total,
			0::numeric AS prod_sale_quant,
			0::numeric AS prod_sale_cost,
			0::numeric AS prod_sale_total,
			0::numeric AS end_mat_quant,
			0::numeric AS end_mat_cost,
			0::numeric AS end_prod_quant,
			0::numeric AS end_prod_cost	
			
		FROM ra_materials AS ram
		WHERE ram.date_time BETWEEN $1 AND $2
			AND ram.doc_type='material_disposal'
			AND ram.material_id IN (SELECT mat_list.id FROM mat_list)
		GROUP BY ram.material_id
		)
		--Продажи в букетах
		UNION		
		(SELECT
			sub_sales.material_id,
			0::numeric AS beg_mat_quant,
			0::numeric AS beg_mat_cost,
			0::numeric AS beg_prod_quant,
			0::numeric AS beg_prod_cost,
			0::numeric AS procur_quant,
			0::numeric AS procur_cost,
			0::numeric AS production_quant,
			0::numeric AS production_cost,
			0::numeric AS prod_disp_quant,
			0::numeric AS prod_disp_cost,
			0::numeric AS mat_disp_quant,
			0::numeric AS mat_disp_cost,
			0::numeric AS mat_sale_quant,
			0::numeric AS mat_sale_cost,
			0::numeric AS mat_sale_total,
			sum(sub_sales.prod_sale_quant) AS prod_sale_quant,
			sum(sub_sales.prod_sale_cost) AS prod_sale_cost,
			sum(sub_sales.prod_sale_total) AS prod_sale_total,
			
			0::numeric AS end_mat_quant,
			0::numeric AS end_mat_cost,
			0::numeric AS end_prod_quant,
			0::numeric AS end_prod_cost	
			
		FROM
			(
			SELECT
				ra_m.material_id,
				sum(ra_m.quant) AS prod_sale_quant,
				sum(ra_m.cost) AS prod_sale_cost,
				ROUND(
					(SELECT SUM(t.cost)
					FROM ra_materials AS t
					WHERE t.doc_id=d_tp.doc_production_id
					AND t.doc_type='production'
					AND t.material_id=ra_m.material_id)					
					/
					--вся себестоимость комплектации
					(SELECT SUM(t.cost)
					FROM ra_materials AS t
					WHERE t.doc_id=d_tp.doc_production_id
					AND t.doc_type='production') *
					AVG(d_tp.total)
				,2) AS prod_sale_total
			FROM doc_sales_t_products d_tp
			LEFT JOIN doc_sales d ON d.id=d_tp.doc_id
			LEFT JOIN ra_materials ra_m ON
				ra_m.doc_type='production'
				AND ra_m.doc_id=d_tp.doc_production_id
			WHERE d.date_time BETWEEN $1 AND $2
				AND ra_m.material_id IN (SELECT mat_list.id FROM mat_list)
			GROUP BY
				ra_m.material_id,
				d_tp.doc_production_id
			) AS sub_sales
			GROUP BY sub_sales.material_id
		) 
		--Продажи материалов
		UNION
		(
		SELECT
			ms.material_id,
			0::numeric AS beg_mat_quant,
			0::numeric AS beg_mat_cost,
			0::numeric AS beg_prod_quant,
			0::numeric AS beg_prod_cost,
			0::numeric AS procur_quant,
			0::numeric AS procur_cost,
			0::numeric AS production_quant,
			0::numeric AS production_cost,
			0::numeric AS prod_disp_quant,
			0::numeric AS prod_disp_cost,
			0::numeric AS mat_disp_quant,
			0::numeric AS mat_disp_cost,
			
			sum(ms.quant) AS mat_sale_quant,
			CASE 
				WHEN sum(ram.quant)=0 THEN 0
				ELSE sum(ram.cost)
					--round(sum(ram.cost)/sum(ram.quant)*sum(ms.quant),2)
			END
			AS mat_sale_cost,
			sum(ms.total) AS mat_sale_total,
			
			0::numeric AS prod_sale_quant,
			0::numeric AS prod_sale_cost,
			0::numeric AS prod_sale_total,
			0::numeric AS end_mat_quant,
			0::numeric AS end_mat_cost,
			0::numeric AS end_prod_quant,
			0::numeric AS end_prod_cost	
			
		FROM doc_sales_t_materials AS ms
		LEFT JOIN doc_sales AS d ON d.id=ms.doc_id
		LEFT JOIN (
			SELECT
				t.doc_id,
				t.material_id,
				SUM(t.quant) AS quant,
				SUM(t.cost) AS cost
			FROM ra_materials AS t
			WHERE t.date_time BETWEEN $1 AND $2
				AND t.doc_type='sale'
				AND t.material_id IN (SELECT mat_list.id FROM mat_list)
			GROUP BY t.doc_id,t.material_id
			) AS ram
			ON ram.doc_id=ms.doc_id
			AND ram.material_id=ms.material_id
		WHERE d.date_time BETWEEN $1 AND $2
			AND ms.material_id IN (SELECT mat_list.id FROM mat_list)
		GROUP BY ms.material_id
		)
		--остатки материалов на конец
		UNION
		(SELECT
			b.material_id,
			0::numeric AS beg_mat_quant,
			0::numeric AS beg_mat_cost,
			0::numeric AS beg_prod_quant,
			0::numeric AS beg_prod_cost,
			0::numeric AS procur_quant,
			0::numeric AS procur_cost,
			0::numeric AS production_quant,
			0::numeric AS production_cost,
			0::numeric AS prod_disp_quant,
			0::numeric AS prod_disp_cost,
			0::numeric AS mat_disp_quant,
			0::numeric AS mat_disp_cost,
			0::numeric AS mat_sale_quant,
			0::numeric AS mat_sale_cost,
			0::numeric AS mat_sale_total,
			0::numeric AS prod_sale_quant,
			0::numeric AS prod_sale_cost,
			0::numeric AS prod_sale_total,
			sum(b.quant) end_mat_quant,
			sum(b.cost) end_mat_cost,
			0::numeric AS end_prod_quant,
			0::numeric AS end_prod_cost	
			
		FROM rg_materials_balance(
			$2+'1 second'::interval,ARRAY[$3],ARRAY((SELECT m.id FROM mat_list m))) AS b
		GROUP BY b.material_id
		)
		--остатки материалов на конец в букетах
		UNION
		(
		SELECT
			ram.material_id,
			0::numeric AS beg_mat_quant,
			0::numeric AS beg_mat_cost,
			0::numeric AS beg_prod_quant,
			0::numeric As beg_prod_cost,
			0::numeric AS procur_quant,
			0::numeric AS procur_cost,
			0::numeric AS production_quant,
			0::numeric AS production_cost,
			0::numeric AS prod_disp_quant,
			0::numeric AS prod_disp_cost,
			0::numeric AS mat_disp_quant,
			0::numeric AS mat_disp_cost,
			0::numeric AS mat_sale_quant,
			0::numeric AS mat_sale_cost,
			0::numeric AS mat_sale_total,
			0::numeric AS prod_sale_quant,
			0::numeric AS prod_sale_cost,
			0::numeric AS prod_sale_total,
			0::numeric AS end_mat_quant,
			0::numeric AS end_mat_cost,
			sum(ram.quant) AS end_prod_quant,
			sum(ram.cost) end_prod_cost	
			
		FROM rg_products_balance(
			$2+'1 second'::interval,ARRAY[$3],'{}','{}') AS b
		LEFT JOIN ra_materials AS ram ON ram.doc_id=b.doc_production_id AND ram.doc_type='production'
		WHERE ram.material_id IN (SELECT mat_list.id FROM mat_list)
		GROUP BY ram.material_id
		)
		
	) AS sub
	LEFT JOIN mat_list m ON sub.material_id=m.id
	GROUP BY m.id,material_descr
	ORDER BY material_descr
$BODY$
  LANGUAGE sql VOLATILE
  CALLED ON NULL INPUT
  COST 100;
ALTER FUNCTION materials_actions(timestamp, timestamp,integer,integer)
  OWNER TO bellagio;
