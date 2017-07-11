-- Function: doc_sales_process()

-- DROP FUNCTION doc_sales_process();

CREATE OR REPLACE FUNCTION doc_sales_process()
  RETURNS trigger AS
$BODY$
DECLARE
	v_doc_operative_processing boolean;
	v_doc_log_id int;
	v_materials int[];
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		SELECT coalesce(MAX(d.number),0)+1 INTO NEW.number FROM doc_sales AS d
		WHERE
		
		d.store_id=NEW.store_id;
		/*
		NEW.total = (SELECT coalesce(SUM(t1.total),0)::numeric(15,2) FROM doc_sales_t_products t1 WHERE t1.doc_id=NEW.id) + 
				(SELECT coalesce(SUM(t2.total),0)::numeric(15,2) FROM doc_sales_t_materials t2 WHERE t2.doc_id=NEW.id)
		;
		*/
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='INSERT') THEN
		--log
		PERFORM doc_log_insert('sale'::doc_types,NEW.id,NEW.date_time);
	
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		/*
		NEW.total = (SELECT coalesce(SUM(t1.total),0)::numeric(15,2) FROM doc_sales_t_products t1 WHERE t1.doc_id=NEW.id) + 
				(SELECT coalesce(SUM(t2.total),0)::numeric(15,2) FROM doc_sales_t_materials t2 WHERE t2.doc_id=NEW.id)
		;
		*/
		IF NEW.date_time<>OLD.date_time THEN
			PERFORM doc_log_update('production'::doc_types,NEW.id,NEW.date_time);
		END IF;
					
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='UPDATE') THEN
		
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		--detail tables
		
		DELETE FROM doc_sales_t_materials WHERE doc_id=OLD.id;
		
		DELETE FROM doc_sales_t_products WHERE doc_id=OLD.id;
						
		
		--register actions
		PERFORM doc_sales_del_act(OLD.id);

		--log
		PERFORM doc_log_delete('sale'::doc_types,OLD.id);
											
		RETURN OLD;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
		RETURN OLD;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_sales_process()
  OWNER TO bellagio;
