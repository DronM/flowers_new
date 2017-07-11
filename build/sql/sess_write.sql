-- Function: sess_write(in_id varchar(128), in_data text, in_remote_ip varchar(15))

-- DROP FUNCTION sess_write(in_id varchar(128), in_data text, in_remote_ip varchar(15));

CREATE OR REPLACE FUNCTION sess_write(in_id varchar(128), in_data text, in_remote_ip varchar(15))
  RETURNS void AS
$BODY$
BEGIN
	UPDATE sessions
	SET
		set_time = now(),
		data = in_data
	WHERE id = in_id;
	
	IF FOUND THEN
		RETURN;
	END IF;
	
	BEGIN
		INSERT INTO sessions (id, data, set_time)
		VALUES(in_id, in_data, now());
		
		INSERT INTO logins(date_time_in,ip,session_id)
		VALUES(now(),in_remote_ip,in_id);
		
	EXCEPTION WHEN OTHERS THEN
		UPDATE sessions
		SET
			set_time = now(),
			data = in_data
		WHERE id = in_id;
	END;
	
	RETURN;

END;	
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sess_write(in_id varchar(128), in_data text, in_remote_ip varchar(15)) OWNER TO ;

