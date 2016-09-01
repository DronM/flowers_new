-- Function: doc_material_procurements_process()

-- DROP FUNCTION doc_material_procurements_process();

CREATE OR REPLACE FUNCTION doc_material_procurements_process()
  RETURNS trigger AS
$BODY$
DECLARE
	v_doc_log_id int;
	v_materials int[];
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		SELECT coalesce(MAX(d.number),0)+1 INTO NEW.number FROM doc_material_procurements AS d
		WHERE
		
		d.store_id=NEW.store_id;
		
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='INSERT') THEN
		--log
		--PERFORM doc_log_insert('material_procurement'::doc_types,NEW.id,NEW.date_time);
		INSERT INTO doc_log
		(doc_type,doc_id,date_time)
		VALUES ('material_procurement'::doc_types,
				NEW.id,
				NEW.date_time
		)
		RETURNING id INTO v_doc_log_id;

		IF NOT doc_operative_processing('material_procurement'::doc_types,NEW.id) THEN
			BEGIN
				INSERT INTO seq_viol_materials
				(doc_log_id,materials)
				VALUES (v_doc_log_id,
					ARRAY(SELECT t.material_id
						FROM doc_material_procurements_t_materials t
						WHERE t.doc_id=NEW.id
						)
					);
			EXCEPTION WHEN unique_violation THEN 
			END;					
		END IF;
		
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		IF NOT doc_operative_processing('material_procurement'::doc_types,NEW.id) THEN
			
			IF OLD.date_time<>NEW.date_time THEN
				--ВСЕ
				v_materials = ARRAY(
					SELECT t.material_id
					FROM doc_material_procurements_t_materials t
					WHERE t.doc_id=OLD.id
				);
			ELSE
				--РАЗНИЦА
				v_materials = ARRAY(
				SELECT
					COALESCE(ra.material_id,t.material_id) AS material_id
				FROM ra_materials ra
				FULL JOIN
					(SELECT
						tt.material_id,
						tt.total
					FROM doc_material_procurements_t_materials tt
					WHERE tt.doc_id=OLD.id) AS t
					ON ra.material_id=t.material_id
				WHERE ra.doc_type='material_procurement'
					AND ra.doc_id=OLD.id
					AND (
						ra.material_id IS NULL
						OR t.material_id IS NULL
						OR ra.cost<>t.total
					)
				);
			END IF;
			
			IF COALESCE(ARRAY_LENGTH(v_materials,1),0)>0 THEN
				
				SELECT doc_log.id INTO v_doc_log_id
				FROM doc_log
				WHERE doc_log.doc_type='material_procurement'
					AND doc_log.doc_id=OLD.id;
			
				BEGIN
					INSERT INTO seq_viol_materials
					(doc_log_id,materials)
					VALUES (v_doc_log_id,v_materials);
				EXCEPTION WHEN unique_violation THEN 
				END;
			END IF;
		END IF;
		
		--delete register actions		
		PERFORM ra_materials_remove_acts('material_procurement'::doc_types,NEW.id);

		IF NEW.date_time<>OLD.date_time THEN
			PERFORM doc_log_update('material_procurement'::doc_types,NEW.id,NEW.date_time);
		END IF;
	
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='UPDATE') THEN
		--new register actions		
		--IF NEW.processed THEN
		
			--add materials
			INSERT INTO ra_materials (date_time,deb,doc_type,doc_id,store_id,stock_type,material_id,doc_procurement_id,quant,cost)
			(SELECT
				NEW.date_time,TRUE,'material_procurement'::doc_types,
				NEW.id,NEW.store_id,'main'::stock_types,mat.material_id,NEW.id,mat.quant,mat.total
			FROM doc_material_procurements_t_materials AS mat
			WHERE mat.doc_id=NEW.id);

		--END IF;
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		IF NOT doc_operative_processing('material_procurement'::doc_types,OLD.id) THEN
			SELECT doc_log.id INTO v_doc_log_id
			FROM doc_log
			WHERE doc_log.date_time<(
				SELECT s.date_time
				FROM doc_log s
				WHERE s.doc_type='material_procurement'
					AND s.doc_id=OLD.id
				)
			ORDER BY doc_log.date_time DESC
			LIMIT 1;
		
			BEGIN
				INSERT INTO seq_viol_materials
				(doc_log_id,materials)
				VALUES (v_doc_log_id,
					ARRAY(SELECT t.material_id
						FROM doc_material_procurements_t_materials t
						WHERE t.doc_id=OLD.id
						)
					);
			EXCEPTION WHEN unique_violation THEN 
			END;					
		END IF;
	
		--delete detail tables
		
		DELETE FROM doc_material_procurements_t_materials WHERE doc_id=OLD.id;
						
		
		--delete register actions
		PERFORM ra_materials_remove_acts('material_procurement'::doc_types,OLD.id);

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
