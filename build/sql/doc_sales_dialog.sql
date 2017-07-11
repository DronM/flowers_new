-- View: doc_sales_dialog

DROP VIEW doc_sales_dialog;

CREATE OR REPLACE VIEW doc_sales_dialog AS 
	 SELECT
		doc.id,
		doc.number,
		doc.date_time, 
		date8_time8_descr(doc.date_time) AS date_time_descr, doc.processed, 
		
		doc.store_id,
		st.name AS store_descr,
		
		doc.user_id,
		u.name AS user_descr, 
				
		doc.payment_type_for_sale_id, 
		pts.name AS payment_type_for_sale_descr,
		
		doc.client_id,
		cl.name AS client_descr,
		to_json(clients_ref(cl)) AS client_ref,
		
		doc.doc_client_order_id,
		doc_descr('doc_client_order'::doc_types, clo.number::text, clo.date_time)
			AS doc_client_order_descr,
		
		doc.total
		
	   FROM doc_sales doc
	   LEFT JOIN users u ON u.id = doc.user_id
	   LEFT JOIN stores st ON st.id = doc.store_id
	   LEFT JOIN payment_types_for_sale pts ON pts.id = doc.payment_type_for_sale_id
	   LEFT JOIN clients cl ON cl.id = doc.client_id
	   LEFT JOIN doc_client_orders clo ON clo.id = doc.doc_client_order_id
	;
ALTER TABLE doc_sales_dialog OWNER TO bellagio;

