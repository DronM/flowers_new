-- Function: doc_material_disposals_process()

-- DROP FUNCTION doc_material_disposals_process();

CREATE OR REPLACE FUNCTION doc_material_disposals_process()
  RETURNS trigger AS
$BODY$
BEGIN	
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		SELECT coalesce(MAX(d.number),0)+1 INTO NEW.number FROM doc_material_disposals AS d
		WHERE
		
		d.store_id=NEW.store_id;
		
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='INSERT') THEN
		--log
		PERFORM doc_log_insert('material_disposal'::doc_types,NEW.id,NEW.date_time);
	
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		--register actions
		IF NEW.date_time<>OLD.date_time THEN		
			PERFORM doc_log_update('material_disposal'::doc_types,NEW.id,NEW.date_time);
		END IF;
		
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='UPDATE') THEN
	
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		--detail tables
		
		DELETE FROM doc_material_disposals_t_materials WHERE doc_id=OLD.id;
						
		
		--register actions
		PERFORM doc_material_disposals_del_act(OLD.id);

		--log
		PERFORM doc_log_delete('material_disposal'::doc_types,OLD.id);
											
		RETURN OLD;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
		RETURN OLD;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_material_disposals_process()
  OWNER TO bellagio;
