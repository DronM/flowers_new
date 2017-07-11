-- View: doc_sales_list_view

DROP VIEW doc_sales_list_view;

CREATE OR REPLACE VIEW doc_sales_list_view AS 
	SELECT doc.id,
		doc.number,
		doc.date_time,
		doc.processed,
		doc.store_id,
		st.name AS store_descr,
		doc.user_id,
		u.name AS user_descr,
		
		/*
		doc.payment_type,
		get_payment_types_descr(doc.payment_type) AS payment_type_descr,
		
		doc.payment_type_for_sale_id,
		pts.name AS payment_type_for_sale_descr,
		*/
		(
		SELECT 
			string_agg(pt.name,',')
		FROM doc_sales_payment_types AS spt
		LEFT JOIN payment_types_for_sale pt ON pt.id = spt.payment_type_for_sale_id
		WHERE spt.doc_id=doc.id
		GROUP BY spt.doc_id
		) AS payment_type_for_sale_descr,
		
		doc.client_id,
		cl.name AS client_descr,
		clients_ref(cl) AS client_ref,
		
		CASE
		    WHEN doc.doc_client_order_id > 0 AND clo.delivery_type = 'courier'::delivery_types THEN true
		    ELSE false
		END AS delivery,
		
		doc.total,
		COALESCE(ra.cost, 0::numeric) + COALESCE(ra_p.cost, 0::numeric) AS cost,
		COALESCE(doc.total, 0::numeric) - COALESCE(ra.cost, 0::numeric) AS income,
		CASE
		    WHEN (COALESCE(ra.cost, 0::numeric) + COALESCE(ra_p.cost, 0::numeric)) > 0::numeric THEN round(doc.total / (COALESCE(ra.cost, 0::numeric) + COALESCE(ra_p.cost, 0::numeric)) * 100::numeric - 100::numeric, 2)
		    ELSE 0::numeric
		END AS income_percent
	FROM doc_sales doc
	LEFT JOIN users u ON u.id = doc.user_id
	LEFT JOIN stores st ON st.id = doc.store_id	
	LEFT JOIN clients cl ON cl.id = doc.client_id
	LEFT JOIN doc_client_orders clo ON clo.id = doc.doc_client_order_id
	     
	LEFT JOIN ( SELECT ra_1.doc_id,
	    		sum(ra_1.cost) AS cost
		FROM ra_materials ra_1
		WHERE ra_1.doc_type = 'sale'::doc_types
		GROUP BY ra_1.doc_id
	  ) ra ON ra.doc_id = doc.id
	  
	LEFT JOIN ( SELECT ra_p_1.doc_id,
		sum(ra_p_1.cost) AS cost
		FROM ra_products ra_p_1
		WHERE ra_p_1.doc_type = 'sale'::doc_types
		GROUP BY ra_p_1.doc_id
	) ra_p ON ra_p.doc_id = doc.id
	  
	ORDER BY doc.date_time;

ALTER TABLE doc_sales_list_view
  OWNER TO bellagio;

