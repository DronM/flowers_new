-- Function: doc_client_orders_process()

-- DROP FUNCTION doc_client_orders_process();

CREATE OR REPLACE FUNCTION doc_client_orders_process()
  RETURNS trigger AS
$BODY$
DECLARE
	v_tel text;
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		SELECT coalesce(MAX(d.number),0)+1 INTO NEW.number FROM doc_client_orders AS d;
		
		v_tel = REPLACE(
				REPLACE(
					REPLACE(
						REPLACE(
							REPLACE(
								NEW.client_tel,'+',''
							),
							'(',''
						),
						')',''
					),
					' ',''
				),
				'-',''
			);
		IF (SUBSTR(v_tel,1,1)='7') THEN
			v_tel = SUBSTR(v_tel,2);
		END IF;
		v_tel = format_cel_phone(v_tel);
		
		SELECT cl.id INTO NEW.client_id
		FROM clients cl WHERE cl.phone_cel=v_tel;
		
		IF NEW.client_id IS NULL THEN
			--новый клиент
			INSERT INTO clients
			(name,name_full,phone_cel)
			VALUES (NEW.client_name,NEW.client_name,v_tel)
			RETURNING id INTO NEW.client_id;
		END IF;
		
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='INSERT') THEN
		--log
		PERFORM doc_log_insert('doc_client_order'::doc_types,NEW.id,NEW.date_time);
	
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		--remove register actions					
											
	
		IF NEW.date_time<>OLD.date_time THEN
			PERFORM doc_log_update('doc_client_order'::doc_types,NEW.id,NEW.date_time);
		END IF;
	
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='UPDATE') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		--detail tables
		DELETE FROM doc_client_orders_t_products WHERE doc_id=OLD.id;
		DELETE FROM doc_client_orders_t_materials WHERE doc_id=OLD.id;
		
		--register actions					
											
		
		--log
		PERFORM doc_log_delete('doc_client_order'::doc_types,OLD.id);
		
		RETURN OLD;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
		RETURN OLD;
	END IF;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_client_orders_process()
  OWNER TO bellagio;
