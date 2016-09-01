-- Function: doc_productions_list_with_balance(integer)

--DROP FUNCTION doc_productions_list_with_balance(integer);

CREATE OR REPLACE FUNCTION doc_productions_list_with_balance(IN in_store_id integer)
  RETURNS TABLE(
	doc_production_id integer,
	doc_descr text,
	product_id integer,
	product_descr text,
	user_descr text,
	on_norm boolean,
	price numeric
) AS
$BODY$
	SELECT
		rg.doc_production_id AS doc_production_id,
		doc_descr('production'::doc_types,prod.number::text,prod.date_time) AS doc_descr,
		rg.product_id AS product_id,
		p.name::text AS product_descr,
		u.name::text AS user_descr,
		prod.on_norm,
		prod.price
		
	FROM rg_products_balance(ARRAY[in_store_id],'{}','{}') AS rg
	LEFT JOIN products As p ON rg.product_id=p.id
	LEFT JOIN doc_productions AS prod ON prod.id=rg.doc_production_id
	LEFT JOIN users AS u ON u.id=prod.user_id;	
$BODY$
  LANGUAGE sql VOLATILE STRICT
  COST 100
  ROWS 1000;
ALTER FUNCTION doc_productions_list_with_balance(integer)
  OWNER TO bellagio;
