-- View: doc_client_orders_list

DROP VIEW doc_client_orders_list;

CREATE OR REPLACE VIEW doc_client_orders_list AS 
	SELECT
		d.id,
		d.number,
		d.processed,
		d.date_time,
		date8_time8_descr(d.date_time) AS date_time_descr,
		d.delivery_type,
		get_delivery_types_descr(d.delivery_type) AS delivery_type_descr,
		d.client_name,
		d.client_tel,

		d.recipient_type,
		get_recipient_types_descr(d.recipient_type) AS recipient_type_descr,
		d.recipient_name,
		d.recipient_tel,
		
		d.address,
		d.delivery_date,
		date5_descr(d.delivery_date) AS delivery_date_descr,
		d.delivery_hour_id,
		dh.descr AS delivery_hour_descr,
		d.card,
		d.card_text,
		d.anonym_gift,
		
		d.delivery_note_type,
		get_delivery_note_types_descr(d.delivery_note_type)AS delivery_note_type_descr,
		d.delivery_comment,
		d.extra_comment,
		d.payment_type,
		get_payment_types_descr(d.payment_type) AS payment_type_descr,
		
		d.client_order_state,
		get_client_order_states_descr(d.client_order_state) AS client_order_state_descr,
		
		d.payed,
		d.number_from_site
		
	
	FROM doc_client_orders AS d
	LEFT JOIN delivery_hours_list AS dh ON dh.id=d.delivery_hour_id
	ORDER BY d.delivery_date;

ALTER TABLE doc_client_orders_list OWNER TO bellagio;