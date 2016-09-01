/*DROP FUNCTION receipt_update_item(
	in_user_id int,
	in_item_id int,
	in_item_type int,
	in_doc_production_id int,
	in_quant numeric,
	in_disc_percent numeric
)
*/

CREATE OR REPLACE FUNCTION receipt_update_item(
	in_user_id int,
	in_item_id int,
	in_item_type int,
	in_doc_production_id int,
	in_quant numeric,
	in_disc_percent numeric
)
  RETURNS VOID AS
$BODY$
DECLARE
	v_price_no_disc numeric;
BEGIN
	IF in_item_type = 0 THEN
		SELECT d_p.price
		INTO v_price_no_disc
		FROM doc_productions AS d_p
		LEFT JOIN products p ON p.id=d_p.product_id
		WHERE d_p.id=in_doc_production_id;
	ELSE
		SELECT m.price
		INTO v_price_no_disc
		FROM materials m
		WHERE m.id = in_item_id;
	END IF;

	UPDATE receipts
	SET
		quant = in_quant,
		price_no_disc = v_price_no_disc,
		disc_percent = in_disc_percent,
		total=calc_total(v_price_no_disc*in_quant,in_disc_percent)
	WHERE user_id = in_user_id AND item_id = in_item_id
	AND item_type = in_item_type
	AND (in_item_type=1
		OR (in_item_type=0
		AND in_doc_production_id=doc_production_id
		)
	);
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION receipt_update_item(
	in_user_id int,
	in_item_id int,
	in_item_type int,
	in_doc_production_id int,
	in_quant numeric,
	in_disc_percent numeric
)
OWNER TO bellagio;
