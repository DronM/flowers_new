-- Function: receipt_close(int,int,int,int,int)

DROP FUNCTION receipt_close(int,int,int,int,int);

CREATE OR REPLACE FUNCTION receipt_close(
	in_store_id int,
	in_user_id int,
	in_payment_type_for_sale_id int,
	in_client_id int,
	in_doc_client_order_id int
)
  RETURNS integer AS
$BODY$
DECLARE
	v_doc_id int;
BEGIN
	--head
	INSERT INTO doc_sales
	(	date_time,
		store_id,
		user_id,
		payment_type_for_sale_id,
		client_id,
		doc_client_order_id)
	VALUES (now(),$1,$2,0,$4,$5)
	RETURNING id INTO v_doc_id;
		
	--table products
	INSERT INTO doc_sales_t_products
	(doc_id, product_id, doc_production_id,
	quant, price, total,
	disc_percent,price_no_disc,total_no_disc)
		(SELECT v_doc_id, p.item_id, p.doc_production_id,
			p.quant, ROUND(p.total/p.quant,2), p.total,
			p.disc_percent,p.price_no_disc,ROUND(p.price_no_disc*p.quant,2)
		FROM receipts AS p
		WHERE p.user_id=$2 AND p.item_type=0
		);
	
	--table materials
	INSERT INTO doc_sales_t_materials
	(doc_id, material_id,
	quant, price, total,
	disc_percent,price_no_disc,total_no_disc)
		(SELECT v_doc_id, m.item_id,
		m.quant, ROUND(m.total/m.quant,2), m.total,
		m.disc_percent,m.price_no_disc,ROUND(m.price_no_disc*m.quant,2)
		FROM receipts AS m
		WHERE m.user_id=$2 AND m.item_type=1
	);

	--process new doc
	UPDATE doc_sales SET processed=TRUE
	WHERE id=v_doc_id;
	
	DELETE FROM receipts WHERE user_id = $2;

	RETURN v_doc_id;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100 CALLED ON NULL INPUT;
ALTER FUNCTION receipt_close(int,int,int,int,int)
  OWNER TO bellagio;
