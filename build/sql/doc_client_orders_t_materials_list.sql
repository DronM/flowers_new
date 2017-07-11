-- View: doc_client_orders_t_materials_list

--DROP VIEW doc_client_orders_t_materials_list;

CREATE OR REPLACE VIEW doc_client_orders_t_materials_list AS 
	SELECT 
		doc_lines.*,
		m.name AS material_descr
	FROM doc_client_orders_t_materials doc_lines
	LEFT JOIN materials m ON m.id = doc_lines.material_id
	
	ORDER BY doc_lines.line_number;

ALTER TABLE doc_client_orders_t_materials_list
  OWNER TO bellagio;

