-- View: doc_material_procurements_materials_list_view

--DROP VIEW doc_sales_products_list_view;

CREATE OR REPLACE VIEW doc_sales_products_list_view AS 
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

		sub.item_descr,
		
		sub.doc_production_number,
		
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
			m.name::text AS item_descr,
			NULL AS doc_production_number,			
			dtm.total AS total,
			SUM(ra_m.quant) AS quant,
			SUM(ra_m.cost) AS cost
		FROM ra_materials ra_m
		LEFT JOIN doc_sales AS d ON d.id=ra_m.doc_id
		LEFT JOIN materials AS m ON m.id=ra_m.material_id
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
			dtm.total,
			m.name	
		)

		UNION ALL	

		--продажа букетов
		(
		SELECT
			d.id,
			d.date_time,
			d.number,
			d.store_id,
			d.user_id,
			d.payment_type_for_sale_id,			
			p.name::text AS item_descr,
			dpr.number AS doc_production_number,
			SUM(dtp.total) AS total,
			SUM(ra_p.quant) As quant,
			SUM(ra_p.cost) AS cost
		FROM ra_products ra_p
		LEFT JOIN doc_sales AS d ON d.id=ra_p.doc_id
		LEFT JOIN products AS p ON p.id=ra_p.product_id
		LEFT JOIN doc_sales_t_products AS dtp ON
			dtp.doc_id=ra_p.doc_id
			AND dtp.product_id=ra_p.product_id
			AND dtp.doc_production_id=ra_p.doc_production_id
		LEFT JOIN doc_productions AS dpr ON dpr.id=ra_p.doc_production_id
		WHERE ra_p.doc_type='sale'
		GROUP BY
			d.id,
			d.date_time,
			d.number,
			d.store_id,
			d.user_id,
			d.payment_type_for_sale_id,
			p.name,
			dpr.number			
		)

	) AS sub
	LEFT JOIN stores s ON s.id = sub.store_id
	LEFT JOIN users u ON u.id = sub.user_id
	LEFT JOIN payment_types_for_sale AS pt
		ON pt.id= sub.payment_type_for_sale_id
	ORDER BY
		sub.date_time,
		sub.number
;
ALTER TABLE doc_sales_products_list_view
  OWNER TO bellagio;

