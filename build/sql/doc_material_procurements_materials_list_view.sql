-- View: doc_material_procurements_materials_list_view

DROP VIEW doc_material_procurements_materials_list_view;

CREATE OR REPLACE VIEW doc_material_procurements_materials_list_view AS 
 SELECT 
	doc_head.id,
	doc_head.date_time As date_time,
	date8_time8_descr(doc_head.date_time) AS date_time_descr,
	doc_head.number,

	doc_head.store_id,
	s.name AS store_descr,

	doc_head.user_id,
	u.name AS user_descr,
	
	doc_head.supplier_id,
	sup.name AS supplier_descr,
	
	doc_lines.material_id,
	m.name AS material_descr,

	mg.id AS material_group_id,
	mg.name AS material_group_descr,
	
	format_quant(doc_lines.quant) AS quant,
	doc_lines.price AS price,
	format_money(doc_lines.price) AS price_descr,
	doc_lines.total AS total,
	format_money(doc_lines.total) AS total_descr
   FROM doc_material_procurements_t_materials doc_lines
   LEFT JOIN doc_material_procurements doc_head ON doc_head.id = doc_lines.doc_id
   LEFT JOIN stores s ON s.id = doc_head.store_id
   LEFT JOIN materials m ON m.id = doc_lines.material_id
   LEFT JOIN material_groups mg ON mg.id = m.material_group_id
   LEFT JOIN suppliers sup ON sup.id = doc_head.supplier_id
   LEFT JOIN users u ON u.id = doc_head.user_id
  ORDER BY doc_head.date_time,doc_lines.line_number;

ALTER TABLE doc_material_procurements_materials_list_view
  OWNER TO bellagio;

