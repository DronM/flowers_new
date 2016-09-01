-- Function: receipt_fill_on_client_order(int,int,int)

--DROP FUNCTION receipt_fill_on_client_order(int,int,int);

CREATE OR REPLACE FUNCTION receipt_fill_on_client_order(
	in_store_id int,
	in_user_id int,
	in_doc_client_order_id int
)
  RETURNS void AS
$BODY$
	--букеты
	INSERT INTO receipts
	(	user_id,
		item_id,item_type,item_name,
		doc_production_id,
		quant,price,total,ord
	)
	(SELECT
		in_user_id,
		t.product_id,0,p.name::text,
		(SELECT b.doc_production_id
			FROM rg_products_balance(
				ARRAY[in_store_id],ARRAY[t.product_id],'{}'
			) AS b
		LEFT JOIN doc_productions AS d_pr
			ON d_pr.id=b.doc_production_id
		ORDER BY d_pr.date_time
		LIMIT 1
		),
		t.quant,t.price,t.total,now()::timestamp
	FROM doc_client_orders_t_products t
	LEFT JOIN products p ON p.id=t.product_id
	WHERE t.doc_id=in_doc_client_order_id
	);
	
	--материалы
	INSERT INTO receipts
	(	user_id,
		item_id,item_type,item_name,
		doc_production_id,
		quant,price,total,ord
	)
	(SELECT
		in_user_id,
		t.material_id,1,m.name::text,
		0,
		t.quant,t.price,t.total,now()::timestamp
	FROM doc_client_orders_t_materials t
	LEFT JOIN materials m ON m.id=t.material_id
	WHERE t.doc_id=in_doc_client_order_id
	);
	
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION receipt_fill_on_client_order(int,int,int)
  OWNER TO bellagio;
