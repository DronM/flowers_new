-- Function: doc_client_orders_before_write(integer, integer)

-- DROP FUNCTION doc_client_orders_before_write(integer, integer);

CREATE OR REPLACE FUNCTION doc_client_orders_before_write(in_login_id integer, in_doc_id integer)
  RETURNS void AS
$BODY$
	
	--clear fact table
	DELETE FROM doc_client_orders_t_materials WHERE doc_id=$2;
	
	--copy data from temp to fact table
	INSERT INTO doc_client_orders_t_materials
	(doc_id,line_number,material_id,quant,price,total)
	(SELECT $2
	,line_number,material_id,quant,price,total					
	FROM doc_client_orders_t_tmp_materials
	WHERE login_id=$1);				
	
	--clear temp table
	DELETE FROM doc_client_orders_t_tmp_materials WHERE login_id=$1;
	
	--clear fact table
	DELETE FROM doc_client_orders_t_products WHERE doc_id=$2;
	
	--copy data from temp to fact table
	INSERT INTO doc_client_orders_t_products
	(doc_id,line_number,product_id,quant,price,total)
	(SELECT $1
	,t.line_number,t.product_id,t.quant,t.price,t.total					
	FROM doc_client_orders_t_tmp_products AS t
	WHERE login_id=$1);				
	
	--clear temp table
	DELETE FROM doc_client_orders_t_tmp_products WHERE login_id=$1;
	
	UPDATE 	doc_client_orders
	SET total =
		(SELECT coalesce(t.total,0) FROM doc_client_orders_t_products t)+
		(SELECT coalesce(t.total,0) FROM doc_client_orders_t_materials t)
	WHERE id=$2;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION doc_client_orders_before_write(integer, integer)
  OWNER TO bellagio;
