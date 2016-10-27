-- Function: doc_productions_t_tmp_materials_process()

-- DROP FUNCTION doc_productions_t_tmp_materials_process();

CREATE OR REPLACE FUNCTION doc_productions_t_tmp_materials_process()
  RETURNS trigger AS
$BODY$
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		SELECT coalesce(MAX(t.line_number),0)+1 INTO NEW.line_number FROM doc_productions_t_tmp_materials AS t
		WHERE t.tmp_doc_id = NEW.tmp_doc_id;
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
		UPDATE doc_productions_t_tmp_materials
		SET line_number = line_number - 1
		WHERE tmp_doc_id=OLD.tmp_doc_id AND line_number>OLD.line_number;
		RETURN OLD;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_productions_t_tmp_materials_process()
  OWNER TO bellagio;
