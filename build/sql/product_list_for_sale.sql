-- Function: product_list_for_sale(integer)

-- DROP FUNCTION product_list_for_sale(integer);

CREATE OR REPLACE FUNCTION product_list_for_sale(IN in_store_id integer)
  RETURNS TABLE(id integer, name text, price text, quant numeric, quant_descr text, code text, doc_production_id integer) AS
$BODY$
	SELECT
		p.id,
		p.name::text || ',код:'||(b.code::text)::text,
		format_rub(d_p.price) AS price,
		coalesce(b.quant,0) AS quant,
		CASE 
			WHEN b.quant IS NULL OR b.quant=0 THEN ''
			ELSE round(b.quant)::text || ' шт.'
		END AS quant_descr,

		b.code::text,
		b.doc_production_id
	
	FROM products AS p
	RIGHT JOIN
		(SELECT rg.product_id,rg.quant,doc_prod.number AS code,rg.doc_production_id AS doc_production_id
		FROM rg_products_balance(ARRAY[$1],'{}','{}') AS rg
		LEFT JOIN doc_productions AS doc_prod ON doc_prod.id=rg.doc_production_id
		) AS b
		ON b.product_id=p.id
	LEFT JOIN doc_productions AS d_p ON d_p.id=b.doc_production_id
	WHERE p.for_sale=TRUE AND d_p.price>0
	ORDER BY d_p.price;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION product_list_for_sale(integer)
  OWNER TO bellagio;
