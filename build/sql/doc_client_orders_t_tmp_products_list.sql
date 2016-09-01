-- View: doc_client_orders_t_tmp_products_list

--DROP VIEW doc_client_orders_t_tmp_products_list;

CREATE OR REPLACE VIEW doc_client_orders_t_tmp_products_list AS 
	SELECT 
		doc_lines.*,
		p.name AS product_descr,
		(COALESCE(rest.quant,0)>0) AS quant_rest
	FROM doc_client_orders_t_tmp_products doc_lines
	LEFT JOIN products p ON p.id = doc_lines.product_id
	LEFT JOIN (
		SELECT
			b.product_id,
			SUM(b.quant) AS quant
		FROM rg_products_balance('{}','{}','{}') AS b
		GROUP BY b.product_id
	) AS rest ON rest.product_id=doc_lines.product_id
	ORDER BY doc_lines.login_id, doc_lines.line_number;

ALTER TABLE doc_client_orders_t_tmp_products_list
  OWNER TO bellagio;

