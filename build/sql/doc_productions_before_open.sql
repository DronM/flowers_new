-- Function: doc_productions_before_open(integer, integer)

-- DROP FUNCTION doc_productions_before_open(in_tmp_doc_id varchar(32), in_doc_id integer);

CREATE OR REPLACE FUNCTION doc_productions_before_open(in_tmp_doc_id varchar(32), in_doc_id integer)
  RETURNS void AS
$BODY$
BEGIN
	
	DELETE FROM doc_productions_t_tmp_materials WHERE tmp_doc_id=in_tmp_doc_id;
	
	IF (in_doc_id IS NOT NULL AND in_doc_id>0) THEN
		INSERT INTO doc_productions_t_tmp_materials
		(tmp_doc_id,line_number,material_id,quant)
		(SELECT in_tmp_doc_id
		,line_number,material_id,quant
		FROM doc_productions_t_materials
		WHERE doc_id=in_doc_id);
	END IF;
	
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_productions_before_open(in_tmp_doc_id varchar(32), in_doc_id integer)
  OWNER TO bellagio;

