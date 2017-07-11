-- Function: bellagio.product_list_with_balance(integer)

 DROP FUNCTION product_list_with_balance(integer);

CREATE OR REPLACE FUNCTION product_list_with_balance(IN in_store_id integer)
  RETURNS TABLE(
  	code text,
  	id integer,
  	name text,
  	price numeric,
  	total numeric,
  	quant numeric,
  	order_quant numeric,
  	after_production_time text,
  	doc_production_id int,
  	doc_production_date_time timestamp,
  	doc_production_number text,
  	store_id integer,
  	store_descr text
  ) AS
$BODY$
	WITH data AS (
	SELECT 
		d_p.number::text AS code,
		p.id AS id,
		p.name::text AS name,
		d_p.price AS price,
		d_p.price*b_p.quant AS total,
		b_p.quant AS quant,
		0::numeric AS order_quant,

		--(SELECT product_current_fact_cost(d_p.id))  AS cost,
		--(SELECT product_current_fact_cost(d_p.id))*b_p.quant  AS cost_total,
		now()-d_p.date_time AS after_production_time,
		
		d_p.id AS doc_production_id,
		d_p.date_time AS doc_production_date_time,
		d_p.number::text AS doc_production_number,
		
		in_store_id AS store_id,
		st.name::text AS store_descr

	FROM products AS p
	LEFT JOIN rg_products_balance(ARRAY[$1],'{}','{}') AS b_p
	ON b_p.product_id=p.id
	LEFT JOIN doc_productions AS d_p ON d_p.id=b_p.doc_production_id
	LEFT JOIN stores AS st ON st.id=$1
	WHERE p.for_sale=TRUE AND b_p.quant<>0
	--ORDER BY p.name
	)
	SELECT
		data.code,
		data.id,
		data.name,
		data.price,
		data.total AS total,
		data.quant,
		data.order_quant,

		interval_descr(data.after_production_time),
		data.doc_production_id,
		data.doc_production_date_time,
		data.doc_production_number,
		
		data.store_id,
		data.store_descr
		
	FROM data

	UNION ALL

	SELECT
		NULL,
		NULL,
		NULL,
		NULL,
		SUM(agg.total) AS total,
		NULL,
		NULL,

		--NULL,
		--format_money(SUM(agg.cost_total)),
		interval_descr(AVG(agg.after_production_time)),
		NULL,
		NULL,
		NULL,
		NULL,NULL
	FROM data AS agg;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION bellagio.product_list_with_balance(integer)
  OWNER TO bellagio;

