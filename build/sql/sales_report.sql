-- View: doc_sales_list_view

DROP VIEW sales_report;

CREATE OR REPLACE VIEW sales_report AS 
SELECT
	date8_time5_descr(doc.date_time) AS doc_date_descr,
	doc.number AS doc_number,
	st.name AS store_descr,
	cachier.name AS cachier,
	florist.name AS florist,
	CASE
		WHEN pr.id IS NOT NULL THEN
			pr.name::text
		ELSE
			mat.name::text			
	END AS item_descr,
	CASE
		WHEN pr.id IS NOT NULL THEN
			t_prod.quant
		ELSE
			t_mat.quant
	END AS item_quant,
	CASE
		WHEN pr.id IS NOT NULL THEN
			t_prod.quant
		ELSE
			t_mat.quant
	END AS item_quant	
	
    
FROM doc_sales AS doc
LEFT JOIN doc_sales_t_products t_prod ON t_prod.doc_id = doc.id
LEFT JOIN doc_sales_t_materials t_mat ON t_mat.doc_id = doc.id
LEFT JOIN users cachier ON cachier.id = doc.user_id
LEFT JOIN doc_productions doc_prod ON doc_prod.id = t_prod.doc_production_id
LEFT JOIN users florist ON florist.id = doc_prod.user_id
LEFT JOIN stores st ON st.id = doc.store_id
LEFT JOIN products pr ON pr.id = t_prod.product_id
LEFT JOIN materials mat ON mat.id = t_mat.material_id
LEFT JOIN (
	SELECT
		rg.material_id, rg.quant,rg.cost
	FROM rg_material_costs as rg
	GROUP BY t.doc_id
) rg_mat ON rg_mat.material_id = t_mat.material_id AND rg_mat.date_time=reg_current_balance_time() AND AND rg_mat.store_id=doc_prod.store_id
;

ALTER TABLE sales_report OWNER TO bellagio;

