-- Function: doc_descr(record)

-- DROP FUNCTION doc_descr(record);

CREATE OR REPLACE FUNCTION doc_descr(record)
  RETURNS void AS
$$
	SELECT $1.
	SELECT concat(get_doc_types_descr($1)::text,' №',$1.number::text,' от ',date8$1.date_time::date);
$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION doc_descr(record) OWNER TO bellagio;
