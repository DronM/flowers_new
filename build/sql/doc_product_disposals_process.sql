-- Function: doc_product_disposals_process()

-- DROP FUNCTION doc_product_disposals_process();

CREATE OR REPLACE FUNCTION doc_product_disposals_process()
  RETURNS trigger AS
$BODY$
DECLARE
	reg_act_prod ra_products%ROWTYPE;
	reg_act_prod_ord ra_product_orders%ROWTYPE;
	v_product_balance numeric;
	v_product_name text;
	v_doc_production_id int;
	v_error text DEFAULT '';
	v_product_number text;
	v_product_date text;
	v_product_id int;
	v_quant numeric;
	PRODUCT_QUANT int DEFAULT 1;
DECLARE
	v_doc_log_id int;
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		SELECT coalesce(MAX(d.number),0)+1 INTO NEW.number FROM doc_product_disposals AS d
		WHERE
		
		d.store_id=NEW.store_id;
		
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='INSERT') THEN
		--log
		--PERFORM doc_log_insert('product_disposal'::doc_types,NEW.id,NEW.date_time);
		INSERT INTO doc_log
		(doc_type,doc_id,date_time)
		VALUES ('product_disposal'::doc_types,
				NEW.id,
				NEW.date_time
		)
		RETURNING id INTO v_doc_log_id;

		IF NOT doc_operative_processing('product_disposal'::doc_types,NEW.id) THEN
			BEGIN
				INSERT INTO seq_viol_materials
				(doc_log_id,materials)
				VALUES (v_doc_log_id,'{}');
			EXCEPTION WHEN unique_violation THEN 
			END;					
		END IF;
		
	
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		IF NOT doc_operative_processing('product_disposal'::doc_types,NEW.id) THEN
			SELECT doc_log.id INTO v_doc_log_id
			FROM doc_log
			WHERE doc_log.doc_type='product_disposal'
				AND doc_log.doc_id=OLD.id;
		
			BEGIN
				INSERT INTO seq_viol_materials
				(doc_log_id,materials)
				VALUES (v_doc_log_id,'{}');
			EXCEPTION WHEN unique_violation THEN 
			END;
		END IF;
	
		--register actions
		
		PERFORM ra_products_remove_acts('product_disposal'::doc_types,NEW.id);
		
		PERFORM ra_product_orders_remove_acts('product_disposal'::doc_types,NEW.id);
		
		PERFORM ra_materials_remove_acts('product_disposal'::doc_types,NEW.id);

		IF NEW.date_time<>OLD.date_time THEN
			PERFORM doc_log_update('product_disposal'::doc_types,NEW.id,NEW.date_time);
		END IF;

		--CHECK Product BALANCE
		IF doc_operative_processing('product_disposal'::doc_types,NEW.id) THEN
			--OPERATIVE
			SELECT coalesce(SUM(b.quant),0) INTO v_product_balance
				FROM rg_products_balance(
					'{}',
					'{}',
					ARRAY[NEW.doc_production_id]
				) AS b;
		ELSE
			SELECT coalesce(SUM(b.quant),0) INTO v_product_balance
				FROM rg_products_balance(
					'product_disposal'::doc_types,
					NEW.id,				
					'{}',
					'{}',
					ARRAY[NEW.doc_production_id]
				) AS b;		
		END IF;
		
		IF (v_product_balance<PRODUCT_QUANT) THEN
			SELECT
				doc.number::text,
				date5_descr(doc.date_time::date),
				p.name::text,
				doc.quant
			INTO
				v_product_number,
				v_product_date,
				v_product_name,
				v_quant
			FROM doc_productions doc
			LEFT JOIN products AS p ON p.id=doc.product_id
			WHERE doc.id=NEW.doc_production_id;
			
			RAISE EXCEPTION 'Списание букетов №%, остаток букета "%" по комплектации % от %: %, затребовано: %',
				NEW.number,
				v_product_name,
				v_product_number,
				v_product_date,
				v_product_balance,
				v_quant;
		END IF;
	
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='UPDATE') THEN
		--IF NEW.processed THEN
			SELECT product_id INTO v_product_id FROM doc_productions WHERE id=NEW.doc_production_id;		
			--********  DEDUCT Product ******************
			/*
			reg_act_prod.date_time	= NEW.date_time;
			reg_act_prod.deb		= FALSE;
			reg_act_prod.doc_type	= 'product_disposal'::doc_types;
			reg_act_prod.doc_id		= NEW.id;
			reg_act_prod.store_id	= NEW.store_id;
			reg_act_prod.product_id	= v_product_id;
			reg_act_prod.doc_production_id	= NEW.doc_production_id;
			reg_act_prod.quant		= 1;
			reg_act_prod.cost		=
			PERFORM ra_products_add_act(reg_act_prod);
			*/
			INSERT INTO ra_products (
				date_time,
				deb,
				doc_type,
				doc_id,
				store_id,
				product_id,
				doc_production_id,
				quant,
				cost)
			(SELECT
				NEW.date_time,
				FALSE,'product_disposal'::doc_types,
				NEW.id,
				NEW.store_id,
				v_product_id,
				NEW.doc_production_id,
				1,
				(SELECT SUM(ra.cost)
				FROM ra_materials AS ra
				WHERE
					ra.doc_id=NEW.doc_production_id
					AND ra.doc_type='production'			
				
				) AS cost
			);			
			
			--********  DEDUCT Product ******************

			--********  Add Product Order ******************
			/*
			reg_act_prod_ord.date_time		= NEW.date_time;
			reg_act_prod_ord.deb			= TRUE;
			reg_act_prod_ord.doc_type		= 'product_disposal'::doc_types;
			reg_act_prod_ord.doc_id			= NEW.id;
			reg_act_prod_ord.store_id		= NEW.store_id;
			reg_act_prod_ord.product_id		= v_product_id;
			reg_act_prod_ord.product_order_type	='disposal'::product_order_types;
			reg_act_prod_ord.quant			= PRODUCT_QUANT;
			PERFORM ra_product_orders_add_act(reg_act_prod_ord);
			*/
			--********  Add Product Order ******************


			--********  Add Materials To MAIN Store******************
			INSERT INTO ra_materials
			(	date_time,
				deb,
				doc_type,
				doc_id,
				store_id,
				stock_type,
				material_id,
				doc_procurement_id,
				quant,
				cost
			)
			(SELECT
				NEW.date_time,
				TRUE,
				'product_disposal'::doc_types,
				NEW.id,
				NEW.store_id,
				'main'::stock_types,
				m.material_id,
				m.doc_procurement_id,
				m.quant,
				m.cost
				/*
				CASE 
					WHEN ra_in.quant>0 THEN ra_in.cost/ra_in.quant*m.quant
				ELSE
					0
				END AS cost				
				*/
			FROM ra_materials AS m
			/*
			LEFT JOIN ra_materials AS ra_in
				ON ra_in.doc_id=m.doc_procurement_id
				AND ra_in.material_id=m.material_id
			*/
			WHERE m.doc_type='production'::doc_types
				AND m.doc_id=NEW.doc_production_id
			);
			
			
		--END IF;
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		--register actions
		
		PERFORM ra_products_remove_acts('product_disposal'::doc_types,OLD.id);
		
		PERFORM ra_product_orders_remove_acts('product_disposal'::doc_types,OLD.id);
		
		PERFORM ra_materials_remove_acts('product_disposal'::doc_types,OLD.id);

		--log
		PERFORM doc_log_delete('product_disposal'::doc_types,OLD.id);
											
		RETURN OLD;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
		RETURN OLD;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_product_disposals_process()
  OWNER TO bellagio;
