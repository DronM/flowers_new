-- View: doc_material_procurements_materials_list_view

DROP VIEW doc_sales_materials_list_view;

CREATE OR REPLACE VIEW doc_sales_materials_list_view AS 
	SELECT
		sub.id,
		sub.date_time,
		date8_time8_descr(sub.date_time) AS date_time_descr,
		sub.number,

		sub.store_id,
		s.name AS store_descr,

		sub.user_id,
		u.name AS user_descr,

		sub.payment_type_for_sale_id,
		pt.name AS payment_type_for_sale_descr,

		sub.material_id,
		m.name::text AS material_descr,
		
		COALESCE(
		CASE
			WHEN sub.quant>0 THEN ROUND(sub.total/sub.quant,2)
			ELSE 0
		END
		,2) AS price,
		
		COALESCE(sub.total,2) AS total,
		COALESCE(sub.quant,2) AS quant,
		COALESCE(sub.cost,2) AS cost,
		sub.total-sub.cost AS income,
		COALESCE(
			CASE
				WHEN sub.cost>0 THEN
					ROUND(sub.total/sub.cost*100-100,2)
				ELSE 0
			END
		,2) AS income_percent
		
	FROM
	(
		--продажа материалов
		(
		SELECT
			d.id,
			d.date_time,
			d.number,
			d.store_id,
			d.user_id,
			d.payment_type_for_sale_id,			
			ra_m.material_id,
			dtm.total AS total,
			SUM(ra_m.quant) AS quant,
			SUM(ra_m.cost) AS cost
		FROM ra_materials ra_m
		LEFT JOIN doc_sales AS d ON d.id=ra_m.doc_id
		LEFT JOIN doc_sales_t_materials AS dtm ON
			dtm.doc_id=ra_m.doc_id
			AND dtm.material_id=ra_m.material_id
		GROUP BY
			d.id,
			d.date_time,
			d.number,
			d.store_id,
			d.user_id,
			d.payment_type_for_sale_id,
			ra_m.material_id,
			dtm.total
		)

		UNION ALL	

		--продажа букетов по материалам
		(
		SELECT
			d.id,
			d.date_time,
			d.number,
			d.store_id,
			d.user_id,
			d.payment_type_for_sale_id,			
			ra_m.material_id AS material_id,
			
			CASE
				WHEN ra_p.cost>0 THEN
					round(dtp.total/ra_p.cost*SUM(ra_m.cost),2)
				ELSE 0
			END	AS total,
			
			SUM(ra_m.quant) AS quant,
			SUM(ra_m.cost) AS cost
		FROM ra_products ra_p
		LEFT JOIN doc_sales AS d ON
			d.id=ra_p.doc_id		
		LEFT JOIN doc_productions AS dpr ON
			dpr.id=ra_p.doc_production_id
		LEFT JOIN ra_materials AS ra_m ON
			ra_m.doc_id=ra_p.doc_production_id
			AND ra_m.doc_type='production'			
		LEFT JOIN doc_sales_t_products AS dtp ON
			dtp.doc_id=ra_p.doc_id
			AND dtp.product_id=ra_p.product_id
			AND dtp.doc_production_id=ra_p.doc_production_id
		WHERE ra_p.doc_type='sale'
		GROUP BY
			d.id,
			d.date_time,
			d.number,
			d.store_id,
			d.user_id,
			d.payment_type_for_sale_id,			
			ra_m.material_id,
			dtp.total,
			ra_p.cost
		)

	) AS sub
	LEFT JOIN stores s ON s.id = sub.store_id
	LEFT JOIN users u ON u.id = sub.user_id
	LEFT JOIN materials m ON m.id = sub.material_id
	LEFT JOIN payment_types_for_sale AS pt
		ON pt.id= sub.payment_type_for_sale_id	
	ORDER BY
		sub.date_time,
		sub.number
	;
ALTER TABLE doc_sales_materials_list_view
  OWNER TO bellagio;

