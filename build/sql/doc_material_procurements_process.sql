-- Function: doc_material_procurements_process()

-- DROP FUNCTION doc_material_procurements_process();

CREATE OR REPLACE FUNCTION doc_material_procurements_process()
  RETURNS trigger AS
$BODY$
BEGIN
	--RAISE EXCEPTION 'doc_material_procurements_process %,%',TG_WHEN,TG_OP;
	
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		SELECT coalesce(MAX(d.number),0)+1 INTO NEW.number FROM doc_material_procurements AS d
		WHERE
		
		d.store_id=NEW.store_id;
		
		RETURN NEW;
		
	ELSIF (TG_WHEN='AFTER' AND TG_OP='INSERT') THEN
		--log
		PERFORM doc_log_insert('material_procurement'::doc_types,NEW.id,NEW.date_time);
				
		RETURN NEW;
		
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN		
		--delete register actions				
		IF NEW.date_time<>OLD.date_time THEN
			PERFORM doc_log_update('material_procurement'::doc_types,NEW.id,NEW.date_time);
		END IF;
	
		RETURN NEW;
		
	ELSIF (TG_WHEN='AFTER' AND TG_OP='UPDATE') THEN
		--new register actions		
		RETURN NEW;
		
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
	
		--delete detail tables		
		DELETE FROM doc_material_procurements_t_materials WHERE doc_id=OLD.id;
						
		
		--delete register actions
		PERFORM doc_material_procurements_del_act(OLD.id);

		--log
		PERFORM doc_log_delete('material_procurement'::doc_types,OLD.id);

		RETURN OLD;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
		RETURN OLD;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_material_procurements_process()
  OWNER TO bellagio;

