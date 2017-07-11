--Function rep_sales_on_types(in_date_from timestamp,in_date_to timestamp,in_store_id integer)

 DROP FUNCTION rep_sales_on_types(in_date_from timestamp,in_date_to timestamp,in_store_id integer);

CREATE OR REPLACE FUNCTION rep_sales_on_types(in_date_from timestamp,in_date_to timestamp,in_store_id integer)
RETURNS table(
	d date,
	date_descr text,
	store_id int,
	store_descr text,
	payment_type_for_sale_id int,
	payment_type_for_sale_descr text,	
	total numeric	
	) AS
$BODY$
	SELECT		
		doc.date_time::date AS d,
		date8_descr(doc.date_time::date) AS date_descr,
		
		doc.store_id,
		st.name::text AS store_descr,
		
		spt.payment_type_for_sale_id AS payment_type_for_sale_id,
		pt.name::text AS payment_type_for_sale_descr,
		
		SUM(doc.total) AS total
	FROM doc_sales AS doc
	LEFT JOIN doc_sales_payment_types AS spt ON spt.doc_id=doc.id
	LEFT JOIN stores AS st ON st.id=doc.store_id
	LEFT JOIN payment_types_for_sale AS pt ON pt.id=spt.payment_type_for_sale_id
	WHERE doc.date_time BETWEEN $1 AND $2
		AND ($3 IS NULL OR $3=0 OR ($3>0 AND $3=doc.store_id))
	
	GROUP BY
		doc.date_time::date,
		doc.store_id,
		st.name,
		spt.payment_type_for_sale_id,
		pt.name
	ORDER BY doc.date_time::date
	;
$BODY$  
LANGUAGE sql VOLATILE COST 100;
	
ALTER FUNCTION rep_sales_on_types(timestamp,timestamp,integer)
OWNER TO bellagio;
