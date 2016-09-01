-- View: doc_client_orders_t_tmp_materials_list

DROP VIEW doc_client_orders_t_tmp_materials_list;

CREATE OR REPLACE VIEW doc_client_orders_t_tmp_materials_list AS 
	SELECT 
		doc_lines.*,
		m.name AS material_descr,
		rest.quant AS quant_rest
	FROM doc_client_orders_t_tmp_materials doc_lines
	LEFT JOIN materials m ON m.id = doc_lines.material_id
	LEFT JOIN (
		SELECT
			b.material_id,
			SUM(b.quant) AS quant
		FROM rg_materials_balance('{}','{}','{}','{}') AS b
		GROUP BY b.material_id
	) AS rest ON rest.material_id=doc_lines.material_id
	
	ORDER BY doc_lines.login_id, doc_lines.line_number;

ALTER TABLE doc_client_orders_t_tmp_materials_list
  OWNER TO bellagio;

