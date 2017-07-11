-- Function: seq_violation_set_on_doc(in_doc_sequence doc_sequences, in_doc_type doc_types, in_doc_id integer)

-- DROP FUNCTION seq_violation_set_on_doc(in_doc_sequence doc_sequences, in_doc_type doc_types, in_doc_id integer)

CREATE OR REPLACE FUNCTION seq_violation_set_on_doc(in_doc_sequence doc_sequences, in_doc_type doc_types, in_doc_id integer)
  RETURNS void AS
$$
DECLARE
	v_seq_log_date_time timestamp without time zone;
	v_log_date_time timestamp without time zone;
BEGIN
	
	IF NOT doc_operative_processing(in_doc_type, in_doc_id) THEN
		--current date
		SELECT doc_log_date_time INTO v_seq_log_date_time FROM seq_violations WHERE doc_sequence = in_doc_sequence LIMIT 1;
		
		SELECT date_time INTO v_log_date_time FROM doc_log WHERE doc_id=in_doc_id AND doc_type=in_doc_type;
		
		--RAISE EXCEPTION 'v_seq_log_date_time=%,v_log_date_time=%',v_seq_log_date_time,v_log_date_time;
		
		IF v_seq_log_date_time IS NULL THEN
			INSERT INTO seq_violations (doc_sequence,doc_log_date_time) VALUES(in_doc_sequence,v_log_date_time);
		
		ELSIF v_seq_log_date_time>v_log_date_time
		THEN
	
			UPDATE seq_violations
			SET 
				date_time		= now(),
				doc_log_date_time	= v_log_date_time
			WHERE doc_sequence = in_doc_sequence
			;
		END IF;
		
	END IF;

END;	
$$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION seq_violation_set_on_doc(in_doc_sequence doc_sequences, in_doc_type doc_types, in_doc_id integer) OWNER TO bellagio;
