-- Function: doc_client_orders_before_write(in_view_id varchar(32), in_doc_id integer)

-- DROP FUNCTION doc_client_orders_before_write(in_view_id varchar(32), in_doc_id integer);

CREATE OR REPLACE FUNCTION doc_client_orders_before_write(in_view_id varchar(32), in_doc_id integer)
  RETURNS void AS
$BODY$
--BEGIN	
	--clear fact table
	DELETE FROM doc_client_orders_t_materials WHERE doc_id=in_doc_id;
	
	--copy data from temp to fact table
	INSERT INTO doc_client_orders_t_materials
	(doc_id,line_number,material_id,quant,price,total,disc_percent,price_no_disc)
	(SELECT in_doc_id
	,line_number,material_id,quant,price,total,disc_percent,price_no_disc					
	FROM doc_client_orders_t_tmp_materials
	WHERE view_id=in_view_id);
	
	--clear temp table
	DELETE FROM doc_client_orders_t_tmp_materials WHERE view_id=in_view_id;
	
	--clear fact table
	DELETE FROM doc_client_orders_t_products WHERE doc_id=in_doc_id;
	
	--copy data from temp to fact table
	INSERT INTO doc_client_orders_t_products
	(doc_id,line_number,product_id,quant,price,total,disc_percent,price_no_disc)
	(SELECT in_doc_id
	,t.line_number,t.product_id,t.quant,t.price,t.total,t.disc_percent,t.price_no_disc					
	FROM doc_client_orders_t_tmp_products AS t
	WHERE view_id=in_view_id);				
	
	--clear temp table
	DELETE FROM doc_client_orders_t_tmp_products WHERE view_id=in_view_id;
	
	UPDATE 	doc_client_orders
	SET total =
		coalesce((SELECT sum(t.total) FROM doc_client_orders_t_products t WHERE t.doc_id=in_doc_id),0)+
		coalesce((SELECT sum(t.total) FROM doc_client_orders_t_materials t WHERE t.doc_id=in_doc_id),0)
	WHERE id=in_doc_id;
--END;	
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION doc_client_orders_before_write(in_view_id varchar(32), in_doc_id integer)
  OWNER TO bellagio;
