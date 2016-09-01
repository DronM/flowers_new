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
		
		PERFORM ra_materials_remove_acts('material_disposal'::doc_types,NEW.id);

		IF NEW.date_time<>OLD.date_time THEN
			PERFORM doc_log_update('material_disposal'::doc_types,NEW.id,NEW.date_time);
		END IF;
		
		--CHECK MATERIAL BALANCE
		IF const_negat_material_balance_restrict_val()=TRUE THEN
			PERFORM process_material_check(
				NEW.id,
				'material_disposal'::doc_types,	
				NEW.store_id,
				ARRAY(SELECT t.material_id
					FROM doc_material_disposals_t_materials AS t
					WHERE t.doc_id=NEW.id
				),
				doc_operative_processing('material_disposal'::doc_types,NEW.id)
			);				
		END IF;
		
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='UPDATE') THEN
		--IF NEW.processed THEN
			--DEDUCT materials
			PERFORM process_material_deduct(	
				NEW.id,
				NEW.date_time,
				'material_disposal'::doc_types,	
				NEW.store_id,
				doc_operative_processing('material_disposal'::doc_types,NEW.id)
			);
			
			/*
			IF NOT v_operative_processing THEN
				--sequence doc reprocessing
				v_id_material_ids = ARRAY(SELECT t.material_id FROM doc_material_disposals_t_materials AS t WHERE t.doc_id= NEW.id);
				PERFORM seq_material_cost_reprocess(NEW.id, 'material_disposal'::doc_types, v_id_material_ids);
			END IF;
			*/
		--END IF;
	
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		--detail tables
		
		DELETE FROM doc_material_disposals_t_materials WHERE doc_id=OLD.id;
						
		
		--register actions
		
		PERFORM ra_materials_remove_acts('material_disposal'::doc_types,OLD.id);

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
