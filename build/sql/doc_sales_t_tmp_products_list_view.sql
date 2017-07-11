-- View: doc_sales_t_tmp_products_list_view

--DROP VIEW doc_sales_t_tmp_products_list_view;

CREATE OR REPLACE VIEW doc_sales_t_tmp_products_list_view AS 
SELECT
	doc.view_id,
	doc.line_number,
	doc.login_id,
	doc_prod.product_id,
	p.name AS product_descr,
	doc.quant AS quant,
	doc.price,
	doc.total,
	doc.doc_production_id,
	doc.disc_percent,
	doc.price_no_disc,
	doc.total_no_disc,
	doc_prod.number AS doc_production_number,
	doc_prod.date_time AS doc_production_date_time
	
FROM doc_sales_t_tmp_products doc
LEFT JOIN doc_productions doc_prod ON doc_prod.id = doc.doc_production_id
LEFT JOIN products p ON p.id = doc_prod.product_id
ORDER BY doc.line_number;

ALTER TABLE doc_sales_t_tmp_products_list_view
  OWNER TO bellagio;
