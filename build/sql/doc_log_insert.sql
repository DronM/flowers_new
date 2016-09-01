-- Function: doc_log_insert(doc_types, integer, timestamp without time zone)

-- DROP FUNCTION doc_log_insert(doc_types, integer, timestamp without time zone);

CREATE OR REPLACE FUNCTION doc_log_insert(doc_types, integer, timestamp without time zone)
  RETURNS void AS
$BODY$
	INSERT INTO doc_log (doc_type,doc_id,date_time) VALUES ($1,$2,$3);
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION doc_log_insert(doc_types, integer, timestamp without time zone)
  OWNER TO bellagio;
