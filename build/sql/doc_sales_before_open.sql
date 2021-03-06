-- Function: doc_sales_before_open(varchar(32), integer, integer)

-- DROP FUNCTION doc_sales_before_open(varchar(32), integer, integer);

CREATE OR REPLACE FUNCTION doc_sales_before_open(in_view_id varchar(32), in_login_id integer, in_doc_id integer)
  RETURNS void AS
$BODY$
BEGIN
	
	DELETE FROM doc_sales_t_tmp_materials WHERE view_id=in_view_id;
	IF (in_doc_id IS NOT NULL AND in_doc_id>0) THEN
		INSERT INTO doc_sales_t_tmp_materials
		(view_id, login_id,line_number,material_id,quant,price,total,
		disc_percent,price_no_disc,total_no_disc)
		(SELECT in_view_id, in_login_id
		,line_number,material_id,quant,price,total,
		disc_percent,price_no_disc,total_no_disc
		FROM doc_sales_t_materials
		WHERE doc_id=in_doc_id);
	END IF;
	
	DELETE FROM doc_sales_t_tmp_products WHERE view_id=in_view_id;
	IF (in_doc_id IS NOT NULL AND in_doc_id>0) THEN
		INSERT INTO doc_sales_t_tmp_products
		(view_id, login_id,line_number,doc_production_id,quant,price,total,
		disc_percent,price_no_disc,total_no_disc)
		(SELECT in_view_id, in_login_id
		,line_number,doc_production_id,quant,price,total,
		disc_percent,price_no_disc,total_no_disc
		FROM doc_sales_t_products
		WHERE doc_id=in_doc_id);
	END IF;
	
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_sales_before_open(varchar(32), integer, integer)
  OWNER TO bellagio;
