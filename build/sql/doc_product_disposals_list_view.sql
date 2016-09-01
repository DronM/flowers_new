-- View: doc_product_disposals_list_view

-- DROP VIEW doc_product_disposals_list_view;

CREATE OR REPLACE VIEW doc_product_disposals_list_view AS 
	SELECT
		doc_p.id,
		doc_p.number,
		doc_p.date_time,
		date8_time8_descr(doc_p.date_time) AS date_time_descr,
		doc_p.processed,
		doc_p.store_id,
		st.name AS store_descr,
		doc_p.user_id,
		u.name AS user_descr,
		doc_prod.product_id,
		p.name AS product_descr,
		doc_p.explanation,
		doc_descr('production'::doc_types, doc_prod.number::text, doc_prod.date_time) AS doc_production_descr,
		doc_p.id AS doc_production_id
	FROM doc_product_disposals doc_p
	LEFT JOIN doc_productions doc_prod ON doc_prod.id = doc_p.doc_production_id
	LEFT JOIN products p ON p.id = doc_prod.product_id
	LEFT JOIN users u ON u.id = doc_p.user_id
	LEFT JOIN stores st ON st.id = doc_p.store_id
	ORDER BY doc_p.date_time;

ALTER TABLE doc_product_disposals_list_view
  OWNER TO bellagio;