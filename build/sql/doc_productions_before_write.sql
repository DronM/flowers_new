-- Function: doc_productions_before_write(in_view_id varchar(32), in_doc_id integer)

-- DROP FUNCTION doc_productions_before_write(in_view_id varchar(32), in_doc_id integer);

CREATE OR REPLACE FUNCTION doc_productions_before_write(in_view_id varchar(32), in_doc_id integer)
  RETURNS void AS
$BODY$
BEGIN				
	
	--clear fact table
	DELETE FROM doc_productions_t_materials WHERE doc_id=in_doc_id;
	
	--copy data from temp to fact table
	INSERT INTO doc_productions_t_materials
	(doc_id,line_number,material_id,quant)
	(SELECT in_doc_id ,line_number,material_id,quant
	FROM doc_productions_t_tmp_materials
	WHERE view_id=in_view_id);
	
	--clear temp table
	DELETE FROM doc_productions_t_tmp_materials WHERE view_id=in_view_id;
	
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_productions_before_write(in_view_id varchar(32), in_doc_id integer)
  OWNER TO bellagio;
