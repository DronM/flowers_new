-- View: doc_material_disposals_materials_list_view

DROP VIEW doc_material_disposals_materials_list_view;

CREATE OR REPLACE VIEW doc_material_disposals_materials_list_view AS 
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

	mg.id AS material_group_id,
	mg.name AS material_group_descr,
	
	doc_lines.material_id,
	m.name AS material_descr,
	
	format_quant(doc_lines.quant) AS quant,
	
	ra.cost AS cost,
	format_money(ra.cost) AS cost_descr
	
   FROM doc_material_disposals_t_materials doc_lines
   LEFT JOIN doc_material_disposals doc_head ON doc_head.id = doc_lines.doc_id
   LEFT JOIN stores s ON s.id = doc_head.store_id
   LEFT JOIN materials m ON m.id = doc_lines.material_id
   LEFT JOIN material_groups mg ON m.material_group_id = mg.id
   LEFT JOIN users u ON u.id = doc_head.user_id
   LEFT JOIN ra_materials ra
	ON ra.doc_id = doc_head.id
	AND ra.doc_type='material_disposal'
	AND ra.material_id=doc_lines.material_id
  ORDER BY doc_head.date_time,doc_lines.line_number;

ALTER TABLE doc_material_disposals_materials_list_view
  OWNER TO bellagio;

