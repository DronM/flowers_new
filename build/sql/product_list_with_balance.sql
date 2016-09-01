-- Function: product_list_with_balance(integer)

-- DROP FUNCTION product_list_with_balance(integer);

CREATE OR REPLACE FUNCTION product_list_with_balance(
	IN in_store_id integer)
  RETURNS TABLE(
	code text,
	id integer,
	name text,
	price text,
	total text,
	quant numeric,
	order_quant numeric,
	quant_descr text,
	ord_quant_descr text,
	after_production_time text
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
		b_ord.quant AS order_quant,
		CASE 
		WHEN b_p.quant IS NULL OR b_p.quant=0 THEN ''
		ELSE round(b_p.quant)::text
		END AS quant_descr,
		CASE 
		WHEN b_ord.quant IS NULL OR b_ord.quant=0 THEN ''
		ELSE round(b_ord.quant)::text
		END AS ord_quant_descr,

		--(SELECT product_current_fact_cost(d_p.id))  AS cost,
		--(SELECT product_current_fact_cost(d_p.id))*b_p.quant  AS cost_total,
		now()-d_p.date_time AS after_production_time

	FROM products AS p
	LEFT JOIN rg_products_balance(ARRAY[$1],'{}','{}') AS b_p
	ON b_p.product_id=p.id
	LEFT JOIN rg_product_orders_balance(ARRAY[$1],'{}','{}') AS b_ord
	ON b_ord.product_id=p.id 
	LEFT JOIN doc_productions AS d_p ON d_p.id=b_p.doc_production_id
	WHERE p.for_sale=TRUE AND b_p.quant<>0
	--ORDER BY p.name
	)
	SELECT
		data.code,
		data.id,
		data.name,
		format_money(data.price),
		format_money(data.total) AS total,
		data.quant,
		data.order_quant,
		data.quant_descr,
		data.ord_quant_descr,

		--format_money(data.cost),
		--format_money(data.cost_total),
		interval_descr(data.after_production_time)
	FROM data

	UNION ALL

	SELECT
		NULL,
		NULL,
		NULL,
		NULL,
		format_money(SUM(agg.total)) AS total,
		NULL,
		NULL,
		NULL,
		NULL,

		--NULL,
		--format_money(SUM(agg.cost_total)),
		interval_descr(AVG(agg.after_production_time))
	FROM data AS agg;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION product_list_with_balance(integer)
  OWNER TO bellagio;
