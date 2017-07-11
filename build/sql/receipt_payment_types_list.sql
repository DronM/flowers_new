-- VIEW: receipt_payment_types_list

--DROP VIEW receipt_payment_types_list;

CREATE OR REPLACE VIEW receipt_payment_types_list AS
	SELECT
		t.*,
		pt.name AS payment_type_for_sale_descr,
		pt.kkm_type_close As kkm_type_close
	FROM receipt_payment_types t
	LEFT JOIN payment_types_for_sale AS pt ON pt.id=t.payment_type_for_sale_id
	;
	
ALTER VIEW receipt_payment_types_list OWNER TO bellagio;
