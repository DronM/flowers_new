-- Function: seq_viol_materials_set(in_doc_log_id integer, in_doc_log_date_time timestamp without time zone)

-- DROP FUNCTION seq_viol_materials_set(in_doc_log_id integer, in_doc_log_date_time timestamp without time zone);

CREATE OR REPLACE FUNCTION seq_viol_materials_set(in_doc_log_id integer, in_doc_log_date_time timestamp without time zone)
  RETURNS void AS
$$
	SELECT seq_violation_set('materials', in_doc_log_id, in_doc_log_date_time);
$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION seq_viol_materials_set(in_doc_log_id integer, in_doc_log_date_time timestamp without time zone) OWNER TO bellagio;
