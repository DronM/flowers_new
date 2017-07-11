-- Function: logins_forse_close()

-- DROP FUNCTION logins_forse_close();

CREATE OR REPLACE FUNCTION logins_forse_close()
  RETURNS void AS
$$
	UPDATE logins
		SET date_time_out = now()
	FROM (	
	SELECT t.id
	FROM logins t
	WHERE t.date_time_out IS NULL
		AND (t.date_time_in+const_session_live_time_val()) < now()
	) AS sel	
	WHERE sel.id=logins.id;
$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION logins_forse_close() OWNER TO bellagio;
