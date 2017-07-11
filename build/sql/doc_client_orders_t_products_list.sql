-- View: doc_client_orders_t_products_list

--DROP VIEW doc_client_orders_t_products_list;

CREATE OR REPLACE VIEW doc_client_orders_t_products_list AS 
	SELECT 
		doc_lines.*,
		p.name AS product_descr
	FROM doc_client_orders_t_products doc_lines
	LEFT JOIN products p ON p.id = doc_lines.product_id
	ORDER BY doc_lines.line_number;

ALTER TABLE doc_client_orders_t_products_list
  OWNER TO bellagio;

