-- View: doc_client_orders_list

--DROP VIEW doc_client_orders_list;

CREATE OR REPLACE VIEW doc_client_orders_list AS 
	SELECT
		d.id,
		d.number,
		d.processed,
		d.date_time,
		d.delivery_type,
		d.client_name,
		d.client_tel,

		d.recipient_type,
		d.recipient_name,
		d.recipient_tel,
		
		d.address,
		d.delivery_date,
		d.delivery_hour_id,
		dh.descr AS delivery_hour_descr,
		d.card,
		d.card_text,
		d.anonym_gift,
		
		d.delivery_note_type,
		d.delivery_comment,
		d.extra_comment,
		d.payment_type,
		
		d.client_order_state,
		
		d.payed,
		d.number_from_site,
		
		d.store_id,
		st.name AS store_descr,
		
		d.client_id,
		cl.name AS client_descr,
		
		d.number_from_site||' ('||date8_descr(date_time::date)||')' AS doc_client_order_descr,
		
		d.total
	
	FROM doc_client_orders AS d
	LEFT JOIN delivery_hours_list AS dh ON dh.id=d.delivery_hour_id
	LEFT JOIN stores AS st ON st.id=d.store_id
	LEFT JOIN clients AS cl ON cl.id=d.client_id
	ORDER BY d.delivery_date;

ALTER TABLE doc_client_orders_list OWNER TO bellagio;
