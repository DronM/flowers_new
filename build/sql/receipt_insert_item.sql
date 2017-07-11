-- Function: receipt_insert_item(integer, integer, integer)

--DROP FUNCTION receipt_insert_item(integer, integer, integer, integer);

CREATE OR REPLACE FUNCTION receipt_insert_item(
		in_item_id integer,
		in_doc_production_id int,
		in_item_type integer,
		in_user_id integer
		)
  RETURNS void AS
$BODY$
DECLARE
	v_name text;
	v_price numeric(15,2);
	v_disc_percent numeric;
BEGIN
	IF in_item_type = 0 THEN
		SELECT p.name::text,d_p.price
		INTO v_name, v_price
		FROM doc_productions AS d_p
		LEFT JOIN products p ON p.id=d_p.product_id
		WHERE d_p.id=in_doc_production_id;
	ELSE
		SELECT name::text,price
		INTO v_name, v_price
		FROM materials
		WHERE id=in_item_id;
	END IF;

	SELECT d.percent INTO v_disc_percent
	FROM receipt_head h
	LEFT JOIN discounts AS d ON d.id=h.discount_id
	WHERE user_id=in_user_id;

	IF v_disc_percent IS NULL THEN
		v_disc_percent = 0;
	END IF;
	--RAISE EXCEPTION 'percent=%',v_disc_percent;

	UPDATE receipts
	SET quant = quant + 1,
		price_no_disc = v_price,
		disc_percent = v_disc_percent,		
		total = calc_total(v_price*(quant+1),v_disc_percent)
	WHERE
		user_id = in_user_id
		AND item_id = in_item_id
		AND item_type = in_item_type
		AND (in_item_type=1
			OR (in_item_type=0 AND in_doc_production_id=doc_production_id)
		);
	IF NOT FOUND THEN
		BEGIN
			INSERT INTO receipts
			(	user_id,
				item_id,
				doc_production_id,
				item_type,
				item_name,
				quant,
				disc_percent,
				price_no_disc,
				total
			)
			VALUES (
				in_user_id,
				in_item_id,
				in_doc_production_id,
				in_item_type,
				v_name,
				1,
				v_disc_percent,
				v_price,				
				calc_total(v_price,v_disc_percent)
			);
		EXCEPTION WHEN OTHERS THEN
			UPDATE receipts
			SET quant = quant + 1,
				price_no_disc = v_price,
				disc_percent = v_disc_percent,		
				total = calc_total(v_price*(quant+1),v_disc_percent)
			WHERE
				user_id = in_user_id
				AND item_id = in_item_id
				AND item_type = in_item_type
				AND (in_item_type=1
					OR (in_item_type=0 AND in_doc_production_id=doc_production_id)
				);
		END;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION receipt_insert_item(in_item_id integer, in_doc_production_id int, in_item_type integer, in_user_id integer)
  OWNER TO bellagio;
