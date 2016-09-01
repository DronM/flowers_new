-- Function: doc_sales_before_write(integer, integer)

-- DROP FUNCTION doc_sales_before_write(integer, integer);

CREATE OR REPLACE FUNCTION doc_sales_before_write(in_login_id integer, in_doc_id integer)
  RETURNS void AS
$BODY$
	--clear fact table
	DELETE FROM doc_sales_t_materials WHERE doc_id=in_doc_id;
	
	--copy data from temp to fact table
	INSERT INTO doc_sales_t_materials
	(doc_id,line_number,material_id,quant,price,total,
	disc_percent,price_no_disc,total_no_disc)
	(SELECT in_doc_id,
	line_number,material_id,quant,price,total,
	disc_percent,price_no_disc,total_no_disc
	FROM doc_sales_t_tmp_materials
	WHERE login_id=in_login_id);				
	
	--clear temp table
	DELETE FROM doc_sales_t_tmp_materials WHERE login_id=in_login_id;
	
	--clear fact table
	DELETE FROM doc_sales_t_products WHERE doc_id=in_doc_id;
	
	--copy data from temp to fact table
	INSERT INTO doc_sales_t_products
	(doc_id,line_number,product_id,doc_production_id,quant,price,total,
	disc_percent,price_no_disc,total_no_disc)
	(SELECT in_doc_id
	,t.line_number,doc_prod.product_id,t.doc_production_id,t.quant,t.price,t.total,
	t.disc_percent,t.price_no_disc,t.total_no_disc
	FROM doc_sales_t_tmp_products AS t
	LEFT JOIN doc_productions AS doc_prod ON doc_prod.id=t.doc_production_id
	WHERE login_id=in_login_id);				
	
	--clear temp table
	DELETE FROM doc_sales_t_tmp_products WHERE login_id=in_login_id;
	
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION doc_sales_before_write(integer, integer)
  OWNER TO bellagio;
