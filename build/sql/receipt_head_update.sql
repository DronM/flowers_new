/*DROP FUNCTION receipt_head_update(
	in_user_id int,
	in_client_id int,
	in_discount_id int,
	in_doc_client_order_id int
);*/


CREATE OR REPLACE FUNCTION receipt_head_update(
	in_user_id int,
	in_client_id int,
	in_discount_id int,
	in_doc_client_order_id int
)
  RETURNS VOID AS
$BODY$
BEGIN
	UPDATE receipt_head SET
		client_id = in_client_id,
		discount_id = in_discount_id,
		doc_client_order_id = in_doc_client_order_id
	WHERE user_id = in_user_id
	;
    IF FOUND THEN
        RETURN;
    END IF;
    
    --BEGIN
	INSERT INTO receipt_head
		(user_id,client_id,discount_id,doc_client_order_id)
		VALUES (in_user_id,in_client_id,in_discount_id,in_doc_client_order_id)
	;
	/*
    EXCEPTION WHEN OTHERS THEN
	UPDATE receipt_head SET
		client_id = in_client_id,
		discount_id = in_discount_id,
		doc_client_order_id = in_doc_client_order_id
	WHERE user_id = in_user_id
	;
    END;
    */
    RETURN;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION receipt_head_update(
	in_client_id int,
	in_discount_id int,
	in_doc_production_id int
)
OWNER TO bellagio;
