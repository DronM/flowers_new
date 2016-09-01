-- Function: doc_productions_before_write(integer, integer)

-- DROP FUNCTION doc_productions_before_write(integer, integer);

CREATE OR REPLACE FUNCTION doc_productions_before_write(in_login_id integer, in_doc_id integer)
  RETURNS void AS
$BODY$
BEGIN				
	
	--clear fact table
	DELETE FROM doc_productions_t_materials WHERE doc_id=in_doc_id;
	
	--copy data from temp to fact table
	INSERT INTO doc_productions_t_materials
	(doc_id,line_number,material_id,quant_norm,quant,quant_waste)
	(SELECT in_doc_id
	,line_number,material_id,quant_norm,quant,quant_waste					
	FROM doc_productions_t_tmp_materials
	WHERE login_id=in_login_id AND (quant_norm>0 OR (quant+quant_waste)>0));
	
	--clear temp table
	DELETE FROM doc_productions_t_tmp_materials WHERE login_id=in_login_id;
	
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_productions_before_write(integer, integer)
  OWNER TO bellagio;
