-- Function: doc_expences_before_open(varchar(32), integer, integer)

-- DROP FUNCTION doc_expences_before_open(varchar(32), integer, integer);

CREATE OR REPLACE FUNCTION doc_expences_before_open(in_view_id varchar(32), in_login_id integer, in_doc_id integer)
  RETURNS void AS
$BODY$
	DELETE FROM doc_expences_t_tmp_expence_types WHERE view_id=in_view_id;
	
	INSERT INTO doc_expences_t_tmp_expence_types
	(view_id,login_id,expence_type_id,total,expence_comment,expence_date)
	(SELECT in_view_id,in_login_id,
	expence_type_id,total,expence_comment,expence_date					
	FROM doc_expences_t_expence_types
	WHERE doc_id=in_doc_id ORDER BY line_number);
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION doc_expences_before_open(varchar(32), integer, integer)
  OWNER TO bellagio;

