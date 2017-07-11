-- Function: doc_productions_process()

-- DROP FUNCTION doc_productions_process();

CREATE OR REPLACE FUNCTION doc_productions_process()
  RETURNS trigger AS
$BODY$
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		SELECT coalesce(MAX(d.number),0)+1 INTO NEW.number FROM doc_productions AS d
		WHERE
		
		d.store_id=NEW.store_id;
		
		IF NEW.price IS NULL OR NEW.price=0 THEN
			SELECT p.price INTO NEW.price
			FROM products p
			WHERE p.id=NEW.product_id;
		END IF;
		
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='INSERT') THEN
		--log
		PERFORM doc_log_insert('production'::doc_types,NEW.id,NEW.date_time);
	
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		IF NEW.date_time<>OLD.date_time THEN
			PERFORM doc_log_update('production'::doc_types,NEW.id,NEW.date_time);
		END IF;
		
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='UPDATE') THEN
	
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		--detail tables
		--DELETE FROM doc_productions_t_tmp_materials WHERE doc_id=OLD.id;
		DELETE FROM doc_productions_t_materials WHERE doc_id=OLD.id;
						
		
		--register actions
		PERFORM doc_productions_del_act(OLD.id);	

		--log
		PERFORM doc_log_delete('production'::doc_types,OLD.id);
											
		RETURN OLD;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
		RETURN OLD;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_productions_process()
  OWNER TO bellagio;
