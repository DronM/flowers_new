-- Function: doc_expences_before_write(varchar(32), integer)

-- DROP FUNCTION doc_expences_before_write(varchar(32), integer);

CREATE OR REPLACE FUNCTION doc_expences_before_write(in_view_id varchar(32), in_doc_id integer)
  RETURNS void AS
$BODY$
	
	--clear fact table
	DELETE FROM doc_expences_t_expence_types WHERE doc_id=$2;
	
	--copy data from temp to fact table
	INSERT INTO doc_expences_t_expence_types
	(doc_id,line_number,expence_type_id,total,expence_comment,expence_date)
	(SELECT in_doc_id
	,line_number,expence_type_id,total,expence_comment,expence_date
	FROM doc_expences_t_tmp_expence_types
	WHERE view_id=in_view_id);				
	
	--clear temp table
	DELETE FROM doc_expences_t_tmp_expence_types WHERE view_id=in_view_id;
	
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION doc_expences_before_write(varchar(32), integer)
  OWNER TO bellagio;

