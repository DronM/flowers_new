-- Function: doc_log_update(doc_types, integer, timestamp without time zone)

-- DROP FUNCTION doc_log_update(doc_types, integer, timestamp without time zone);

CREATE OR REPLACE FUNCTION doc_log_update(doc_types, integer, timestamp without time zone)
  RETURNS void AS
$BODY$
	UPDATE doc_log SET date_time=$3 WHERE doc_type=$1 AND doc_id=$2;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION doc_log_update(doc_types, integer, timestamp without time zone)
  OWNER TO bellagio;
