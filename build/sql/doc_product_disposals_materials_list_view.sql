-- View: doc_product_disposals_materials_list_view

--DROP VIEW doc_product_disposals_materials_list_view;

CREATE OR REPLACE VIEW doc_product_disposals_materials_list_view AS 
 SELECT 
	doc_head.id,
	doc_head.date_time As date_time,
	date8_time8_descr(doc_head.date_time) AS date_time_descr,
	doc_head.number,

	doc_head.store_id,
	s.name AS store_descr,

	doc_head.user_id,
	u.name AS user_descr,
	
	doc_head.explanation,
	
	doc_p.product_id,
	p.name AS product_descr,

	doc_lines.material_id,
	m.name AS material_descr,
	
	doc_lines.quant AS quant
   FROM ra_materials doc_lines
   LEFT JOIN doc_product_disposals doc_head ON doc_head.id = doc_lines.doc_id
   LEFT JOIN doc_productions doc_p ON doc_p.id = doc_head.doc_production_id
   LEFT JOIN stores s ON s.id = doc_head.store_id
   LEFT JOIN products p ON p.id = doc_p.product_id
   LEFT JOIN materials m ON m.id = doc_lines.material_id
   LEFT JOIN users u ON u.id = doc_head.user_id
   WHERE doc_lines.doc_type='product_disposal'::doc_types
  ORDER BY doc_head.date_time,m.name;

ALTER TABLE doc_product_disposals_materials_list_view
  OWNER TO bellagio;

