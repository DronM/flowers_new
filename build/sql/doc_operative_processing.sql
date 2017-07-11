-- Function: doc_operative_processing(doc_types, integer)

-- DROP FUNCTION doc_operative_processing(doc_types, integer);

CREATE OR REPLACE FUNCTION doc_operative_processing(in_doc_type doc_types, in_doc_id integer)
  RETURNS boolean AS
$BODY$
	SELECT (doc_type=in_doc_type) AND (doc_id=in_doc_id) FROM doc_log ORDER BY date_time DESC LIMIT 1;
$BODY$
  LANGUAGE sql VOLATILE STRICT
  COST 100;
ALTER FUNCTION doc_operative_processing(doc_types, integer)
  OWNER TO bellagio;

