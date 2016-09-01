-- Function: doc_productions_process()

-- DROP FUNCTION doc_productions_process();

CREATE OR REPLACE FUNCTION doc_productions_process()
  RETURNS trigger AS
$BODY$
DECLARE
	reg_act ra_products%ROWTYPE;
	reg_ord_act ra_product_orders%ROWTYPE;
	v_doc_log_id int;
	v_materials int[];	
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
		--PERFORM doc_log_insert('production'::doc_types,NEW.id,NEW.date_time);
		INSERT INTO doc_log
		(doc_type,doc_id,date_time)
		VALUES ('production'::doc_types,
				NEW.id,
				NEW.date_time
		)
		RETURNING id INTO v_doc_log_id;

		IF NOT doc_operative_processing('production'::doc_types,NEW.id) THEN
			BEGIN
				INSERT INTO seq_viol_materials
				(doc_log_id,materials)
				VALUES (v_doc_log_id,
					ARRAY(SELECT t.material_id
						FROM doc_productions_t_materials t
						WHERE t.doc_id=NEW.id
						)
					);
			EXCEPTION WHEN unique_violation THEN 
			END;					
		END IF;
	
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		IF NOT doc_operative_processing('production'::doc_types,NEW.id) THEN
			
			IF OLD.date_time<>NEW.date_time THEN
				--ВСЕ
				v_materials = ARRAY(
					SELECT t.material_id
					FROM doc_productions_t_materials t
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
						tt.material_id
					FROM doc_productions_t_materials tt
					WHERE tt.doc_id=OLD.id) AS t
					ON ra.material_id=t.material_id
				WHERE ra.doc_type='production'
					AND ra.doc_id=OLD.id
					AND (
						ra.material_id IS NULL
						OR t.material_id IS NULL
					)
				);
			END IF;
			
			IF COALESCE(ARRAY_LENGTH(v_materials,1),0)>0 THEN
				
				SELECT doc_log.id INTO v_doc_log_id
				FROM doc_log
				WHERE doc_log.doc_type='production'
					AND doc_log.doc_id=OLD.id;
			
				BEGIN
					INSERT INTO seq_viol_materials
					(doc_log_id,materials)
					VALUES (v_doc_log_id,v_materials);
				EXCEPTION WHEN unique_violation THEN 
				END;
			END IF;
		END IF;
	
		--register actions
		
		PERFORM ra_products_remove_acts('production'::doc_types,NEW.id);
		
		PERFORM ra_product_orders_remove_acts('production'::doc_types,NEW.id);
		
		PERFORM ra_materials_remove_acts('production'::doc_types,NEW.id);

		IF NEW.date_time<>OLD.date_time THEN
			PERFORM doc_log_update('production'::doc_types,NEW.id,NEW.date_time);
		END IF;

		--CHECK MATERIAL BALANCE
		IF const_negat_material_balance_restrict_val()=TRUE THEN
			PERFORM process_material_check(
				NEW.id,
				'production'::doc_types,	
				NEW.store_id,
				ARRAY(SELECT t.material_id
					FROM doc_productions_t_materials AS t
					WHERE t.doc_id=NEW.id
				),
				doc_operative_processing('production'::doc_types,NEW.id)
			);				
		END IF;
		
		--SETTING ON NORM
		SELECT NOT (COUNT(*)>0) INTO NEW.on_norm
		FROM doc_productions_t_materials AS t
		FULL JOIN specifications AS sp ON sp.product_id=NEW.product_id AND sp.material_id=t.material_id
		WHERE t.doc_id=NEW.id AND ((COALESCE(quant,0)+COALESCE(quant_waste,0))<>coalesce(sp.material_quant,0));		
		
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='UPDATE') THEN
		--IF NEW.processed THEN

			-- ***** DEDUCT materials ************
			PERFORM process_material_deduct(	
				NEW.id,
				NEW.date_time,
				'production'::doc_types,	
				NEW.store_id,
				doc_operative_processing('production'::doc_types,NEW.id)
			);
			-- ***** DEDUCT materials ************
			
			--********  ADD NEW Product ******************
			reg_act.date_time		= NEW.date_time;
			reg_act.deb				= TRUE;
			reg_act.doc_type		= 'production'::doc_types;
			reg_act.doc_id			= NEW.id;
			reg_act.store_id		= NEW.store_id;
			reg_act.product_id		= NEW.product_id;
			reg_act.doc_production_id	= NEW.id;
			reg_act.quant			= NEW.quant;
			reg_act.cost			= (
					SELECT SUM(ra.cost)
					FROM ra_materials AS ra
					WHERE
						ra.doc_id=NEW.id
					AND ra.doc_type='production'			
			);
			PERFORM ra_products_add_act(reg_act);
			--********  ADD NEW Product ******************

			--********  DEDUCT Product Order ******************
			/*
			IF (
				(SELECT p.make_order
				FROM products p WHERE id=NEW.product_id
				)
				AND NEW.product_order_type IS NOT NULL
				AND NEW.product_order_type<>'manual'::product_order_types
			) THEN
				reg_ord_act.date_time		= NEW.date_time;
				reg_ord_act.deb			= FALSE;
				reg_ord_act.doc_type		= 'production'::doc_types;
				reg_ord_act.doc_id		= NEW.id;
				reg_ord_act.store_id		= NEW.store_id;
				reg_ord_act.product_id		= NEW.product_id;
				reg_ord_act.product_order_type	= NEW.product_order_type;				
				reg_ord_act.quant		= NEW.quant;
				PERFORM ra_product_orders_add_act(reg_ord_act);
			--********  DEDUCT NEW Order ******************
			END IF;
			*/
		--END IF;
	
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		--detail tables
		--DELETE FROM doc_productions_t_tmp_materials WHERE doc_id=OLD.id;
		DELETE FROM doc_productions_t_materials WHERE doc_id=OLD.id;
						
		
		--register actions
		
		PERFORM ra_products_remove_acts('production'::doc_types,OLD.id);
		
		PERFORM ra_product_orders_remove_acts('production'::doc_types,OLD.id);
		
		PERFORM ra_materials_remove_acts('production'::doc_types,OLD.id);

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
