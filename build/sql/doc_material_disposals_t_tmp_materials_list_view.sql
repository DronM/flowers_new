-- View: doc_material_disposals_t_tmp_materials_list_view

--DROP VIEW doc_material_disposals_t_tmp_materials_list_view;

CREATE OR REPLACE VIEW doc_material_disposals_t_tmp_materials_list_view AS 
	SELECT
		doc.view_id,
		doc.line_number,
		doc.material_id,
		m.name AS material_descr,
		doc.quant AS quant
	FROM doc_material_disposals_t_tmp_materials doc
	LEFT JOIN materials m ON m.id = doc.material_id
	ORDER BY doc.line_number;

ALTER TABLE doc_material_disposals_t_tmp_materials_list_view OWNER TO bellagio;

