-- Function: doc_expences_t_tmp_expence_types_process()

-- DROP FUNCTION doc_expences_t_tmp_expence_types_process();

CREATE OR REPLACE FUNCTION doc_expences_t_tmp_expence_types_process()
  RETURNS trigger AS
$BODY$
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		SELECT coalesce(MAX(t.line_number),0)+1 INTO NEW.line_number
		FROM doc_expences_t_tmp_expence_types AS t WHERE t.view_id = NEW.view_id;
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='INSERT') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		RETURN NEW;					
	ELSIF (TG_WHEN='AFTER' AND TG_OP='UPDATE') THEN
		RETURN NEW;									
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		RETURN OLD;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
		UPDATE doc_expences_t_tmp_expence_types
		SET line_number = line_number - 1
		WHERE view_id=OLD.view_id AND line_number>OLD.line_number;
		RETURN OLD;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_expences_t_tmp_expence_types_process()
  OWNER TO bellagio;

