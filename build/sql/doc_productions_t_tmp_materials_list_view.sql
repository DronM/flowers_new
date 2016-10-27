-- View: doc_productions_t_tmp_materials_list_view

--DROP VIEW doc_productions_t_tmp_materials_list_view;

CREATE OR REPLACE VIEW doc_productions_t_tmp_materials_list_view AS 
	SELECT doc_p_m.line_number,
	    doc_p_m.tmp_doc_id,
	    doc_p_m.material_id,
	    m.name AS material_descr,
	    doc_p_m.quant,
	    doc_p_m.quant_norm,
	    doc_p_m.quant_waste
	FROM doc_productions_t_tmp_materials doc_p_m
	LEFT JOIN materials m ON m.id = doc_p_m.material_id
	ORDER BY doc_p_m.line_number;

ALTER TABLE doc_productions_t_tmp_materials_list_view
  OWNER TO bellagio;

