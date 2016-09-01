-- View: doc_sales_t_products_list_view

-- DROP VIEW doc_sales_t_products_list_view;

CREATE OR REPLACE VIEW doc_sales_t_products_list_view AS 
 SELECT doc.doc_id,
    doc.line_number,
    doc.product_id,
    (p.name::text || ', код:'::text) || doc_prod.number AS product_descr,
    doc.quant,
    doc.price,
    doc.total,
    doc.doc_production_id,
	doc.disc_percent,
    doc.price_no_disc,
    doc.total_no_disc
	
   FROM doc_sales_t_products doc
     LEFT JOIN products p ON p.id = doc.product_id
     LEFT JOIN doc_productions doc_prod ON doc_prod.id = doc.doc_production_id
  ORDER BY doc.line_number;

ALTER TABLE doc_sales_t_products_list_view
  OWNER TO bellagio;
