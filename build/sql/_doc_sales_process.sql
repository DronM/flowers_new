-- Function: doc_sales_process()

-- DROP FUNCTION doc_sales_process();

CREATE OR REPLACE FUNCTION doc_sales_process()
  RETURNS trigger AS
$BODY$
DECLARE
	balance_check RECORD;
	v_error text DEFAULT '';
	v_quant numeric;
	v_quant_to_act numeric;
	reg_act ra_products%ROWTYPE;
	reg_act_mat ra_materials%ROWTYPE;
	v_sql text;
	v_doc_operative_processing boolean;
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		SELECT coalesce(MAX(d.number),0)+1 INTO NEW.number FROM doc_sales AS d
		WHERE
		
		d.store_id=NEW.store_id;
		
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='INSERT') THEN
		--log
		PERFORM doc_log_insert('sale'::doc_types,NEW.id,NEW.date_time);
	
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		--register actions
		
		PERFORM ra_products_remove_acts('sale'::doc_types,NEW.id);
		
		PERFORM ra_product_orders_remove_acts('sale'::doc_types,NEW.id);
		
		PERFORM ra_materials_remove_acts('sale'::doc_types,NEW.id);

		IF NEW.date_time<>OLD.date_time THEN
			PERFORM doc_log_update('sale'::doc_types,NEW.id,NEW.date_time);
		END IF;

		v_doc_operative_processing = doc_operative_processing('sale'::doc_types,NEW.id);
	
		--CHECK MATERIAL BALANCE
		IF v_doc_operative_processing THEN
			v_sql = 
			'SELECT doct.material_id,doct.quant,m.name, coalesce(b.balance,0) AS balance
			FROM doc_sales_t_materials AS doct
			LEFT JOIN (SELECT subb.material_id, SUM(subb.quant) AS balance
					FROM rg_materials_balance(
						ARRAY['|| NEW.store_id ||'],
						ARRAY[''main''::stock_types],
						ARRAY(SELECT t.material_id FROM doc_sales_t_materials AS t WHERE t.doc_id='|| NEW.id ||'),
						''{}''
					) AS subb
					GROUP BY subb.material_id					
				) AS b
				ON b.material_id=doct.material_id
			LEFT JOIN materials AS m ON m.id=doct.material_id
			WHERE doct.doc_id='|| NEW.id ||' AND coalesce(b.balance,0)-doct.quant<0';			
		ELSE
			v_sql = 
			'SELECT doct.material_id,doct.quant,m.name, coalesce(b.balance,0) AS balance
			FROM doc_sales_t_materials AS doct
			LEFT JOIN (SELECT subb.material_id, SUM(subb.quant) AS balance
					FROM rg_materials_balance(
						''sale''::doc_types,
						'|| NEW.id ||',
						ARRAY['|| NEW.store_id ||'],
						ARRAY[''main''::stock_types],
						ARRAY(SELECT t.material_id FROM doc_sales_t_materials AS t WHERE t.doc_id='|| NEW.id ||'),
						''{}''
					) AS subb
					GROUP BY subb.material_id					
				) AS b
				ON b.material_id=doct.material_id
			LEFT JOIN materials AS m ON m.id=doct.material_id
			WHERE doct.doc_id='|| NEW.id ||' AND coalesce(b.balance,0)-doct.quant<0';					
		END IF;
		
		FOR balance_check IN EXECUTE v_sql LOOP
			IF v_error<>'' THEN
				v_error = v_error || ', ';
			END IF;
			v_error = v_error || 'материал: ' || balance_check.name || ' остаток: ' || balance_check.balance || ' затребовано ' || balance_check.quant;
		END LOOP;

		--CHECK Product BALANCE
		IF v_doc_operative_processing THEN
			v_sql = 
			'SELECT doct.product_id,doct.quant,p.name, coalesce(b.balance,0) AS balance
			FROM doc_sales_t_products AS doct
			LEFT JOIN (SELECT subb.product_id,SUM(subb.quant) AS balance
					FROM rg_products_balance(
						ARRAY['|| NEW.store_id ||'],
						ARRAY(SELECT t.product_id FROM doc_sales_t_products AS t WHERE t.doc_id='|| NEW.id ||'),
						''{}''
					) AS subb
					GROUP BY subb.product_id					
				) AS b
				ON b.product_id=doct.product_id
			LEFT JOIN products AS p ON p.id=doct.product_id
			WHERE doct.doc_id='|| NEW.id ||' AND coalesce(b.balance,0)-doct.quant<0';			
		ELSE
			v_sql = 
			'SELECT doct.product_id,doct.quant,p.name, coalesce(b.balance,0) AS balance
			FROM doc_sales_t_products AS doct
			LEFT JOIN (SELECT subb.product_id,SUM(subb.quant) AS balance
					FROM rg_products_balance(
						''sale''::doc_types,
						'|| NEW.id ||',
						ARRAY['|| NEW.store_id ||'],
						ARRAY(SELECT t.product_id FROM doc_sales_t_products AS t WHERE t.doc_id='|| NEW.id ||'),
						''{}''
					) AS subb
					GROUP BY subb.product_id					
				) AS b
				ON b.product_id=doct.product_id
			LEFT JOIN products AS p ON p.id=doct.product_id
			WHERE doct.doc_id='|| NEW.id ||' AND coalesce(b.balance,0)-doct.quant<0';					
		END IF;
		
		FOR balance_check IN EXECUTE v_sql LOOP
			IF v_error<>'' THEN
				v_error = v_error || ', ';
			END IF;
			v_error = v_error || 'букет: ' || balance_check.name || ' остаток: ' || balance_check.balance || ' затребовано ' || balance_check.quant;
		END LOOP;

		IF v_error<>'' THEN
			RAISE EXCEPTION '%',v_error;
		END IF;
	
		--calc total
		NEW.total = (SELECT coalesce(SUM(total),0)::numeric(15,2) FROM doc_sales_t_products WHERE doc_id=NEW.id) + 
			(SELECT coalesce(SUM(total),0)::numeric(15,2) FROM doc_sales_t_materials WHERE doc_id=NEW.id);
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='UPDATE') THEN
		--DOC PROCESSING
		--IF NEW.processed THEN
			v_doc_operative_processing = doc_operative_processing('sale'::doc_types,NEW.id);

			CREATE TEMP TABLE t_tmp_items
			(item_id int, quant numeric ,CONSTRAINT t_items_pkey PRIMARY KEY (item_id))
			ON COMMIT DROP;
		
			--*************** DEDUCT Products ***************************
			INSERT INTO t_tmp_items (SELECT product_id, quant FROM doc_sales_t_products WHERE doc_id=NEW.id AND quant>0);
			IF v_doc_operative_processing THEN
				v_sql =
				'SELECT b.product_id,b.doc_production_id,b.quant AS quant
				FROM rg_products_balance(
					ARRAY['|| NEW.store_id ||'],
					ARRAY(SELECT t.product_id FROM doc_sales_t_products AS t WHERE t.doc_id='|| NEW.id ||'),
					''{}''
					) AS b
				LEFT JOIN doc_productions AS dp ON dp.id=b.doc_production_id
				ORDER BY dp.date_time';				
			ELSE
				v_sql =
				'SELECT b.product_id,b.doc_production_id,b.quant AS quant
				FROM rg_products_balance(
					''sale''::doc_types,
					'|| NEW.id ||',
					ARRAY['|| NEW.store_id ||'],
					ARRAY(SELECT t.product_id FROM doc_sales_t_products AS t WHERE t.doc_id='|| NEW.id ||'),
					''{}''
					) AS b
				LEFT JOIN doc_productions AS dp ON dp.id=b.doc_production_id
				ORDER BY dp.date_time';							
			END IF;
			
			FOR balance_check IN EXECUTE v_sql LOOP
				
				SELECT quant INTO v_quant FROM t_tmp_items WHERE item_id=balance_check.product_id;
				IF FOUND THEN
					v_quant_to_act = LEAST(v_quant,balance_check.quant);

					reg_act.date_time		= NEW.date_time;
					reg_act.deb			= FALSE;
					reg_act.doc_type  		= 'sale'::doc_types;
					reg_act.doc_id  		= NEW.id;
					reg_act.store_id 		= NEW.store_id;
					reg_act.doc_production_id	= balance_check.doc_production_id;
					reg_act.product_id		= balance_check.product_id;
					reg_act.quant			= v_quant_to_act;
					PERFORM ra_products_add_act(reg_act);

					v_quant = v_quant - v_quant_to_act;
					IF (v_quant=0) THEN
						DELETE FROM t_tmp_items WHERE item_id=balance_check.product_id;
					ELSE
						UPDATE t_tmp_items SET quant=v_quant WHERE item_id=balance_check.product_id;
					END IF;
				END IF;
			END LOOP;			
			--*************** DEDUCT Products ***************************


			-- ********* ADD ORDER ***************************
			INSERT INTO ra_product_orders (date_time,deb,doc_type,doc_id,store_id, product_order_type, product_id ,quant)
			(SELECT
				NEW.date_time, TRUE,'sale'::doc_types,
				NEW.id, NEW.store_id, 'sale'::product_order_types, p.product_id, p.quant
			FROM doc_sales_t_products AS p
			LEFT JOIN products AS pr ON pr.id=p.product_id
			LEFT JOIN 
				(SELECT rg.product_id,COALESCE(SUM(rg.quant),0) AS quant
				FROM rg_products_balance(
					'sale'::doc_types,
					NEW.id,
					ARRAY[NEW.store_id],
					ARRAY(SELECT t.product_id FROM doc_sales_t_products AS t
						LEFT JOIN products ON products.id=t.product_id
						WHERE t.doc_id=NEW.id AND products.make_order),
					'{}'
					) AS rg
				GROUP BY rg.product_id
				) AS bal ON bal.product_id=p.product_id
			WHERE p.doc_id=NEW.id AND p.quant<>0 AND pr.make_order AND (bal.quant-1)<pr.min_stock_quant);
			-- ********* ADD ORDER ***************************

			
			--********* DEDUCT Materials **************************
			DELETE FROM t_tmp_items;
			INSERT INTO t_tmp_items (SELECT material_id, quant FROM doc_sales_t_materials WHERE doc_id=NEW.id AND quant>0);
			IF v_doc_operative_processing THEN
				v_sql =
				'SELECT b.material_id,b.doc_procurement_id,b.quant AS quant
				FROM rg_materials_balance(
					ARRAY['|| NEW.store_id ||'],
					ARRAY[''main''::stock_types],
					ARRAY(SELECT t.material_id FROM doc_sales_t_materials AS t WHERE t.doc_id='|| NEW.id ||'),
					''{}''
					) AS b
				LEFT JOIN doc_material_procurements AS dp ON dp.id=b.doc_procurement_id
				ORDER BY dp.date_time';				
			ELSE
				v_sql =
				'SELECT b.material_id,b.doc_procurement_id,b.quant AS quant
				FROM rg_materials_balance(
					''sale''::doc_types,
					'|| NEW.id ||',
					ARRAY['|| NEW.store_id ||'],
					ARRAY[''main''::stock_types],
					ARRAY(SELECT t.material_id FROM doc_sales_t_materials AS t WHERE t.doc_id='|| NEW.id ||'),
					''{}''
					) AS b
				LEFT JOIN doc_material_procurements AS dp ON dp.id=b.doc_procurement_id
				ORDER BY dp.date_time';							
			END IF;
			FOR balance_check IN EXECUTE v_sql LOOP
				
				SELECT quant INTO v_quant FROM t_tmp_items WHERE item_id=balance_check.material_id;
				IF FOUND THEN
					v_quant_to_act = LEAST(v_quant,balance_check.quant);

					reg_act_mat.date_time		= NEW.date_time;
					reg_act_mat.deb			= FALSE;
					reg_act_mat.doc_type  		= 'sale'::doc_types;
					reg_act_mat.doc_id  		= NEW.id;
					reg_act_mat.store_id 		= NEW.store_id;
					reg_act_mat.stock_type		= 'main'::stock_types;
					reg_act_mat.doc_procurement_id	= balance_check.doc_procurement_id;
					reg_act_mat.material_id		= balance_check.material_id;
					reg_act_mat.quant		= v_quant_to_act;
					PERFORM ra_materials_add_act(reg_act_mat);

					v_quant = v_quant - v_quant_to_act;
					IF (v_quant=0) THEN
						DELETE FROM t_tmp_items WHERE item_id=balance_check.material_id;
					ELSE
						UPDATE t_tmp_items SET quant=v_quant WHERE item_id=balance_check.material_id;
					END IF;
				END IF;
			END LOOP;
			--********* DEDUCT Materials **************************
			
		--END IF;
		
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		--detail tables
		
		DELETE FROM doc_sales_t_materials WHERE doc_id=OLD.id;
		
		DELETE FROM doc_sales_t_products WHERE doc_id=OLD.id;
						
		
		--register actions
		
		PERFORM ra_products_remove_acts('sale'::doc_types,OLD.id);
		
		PERFORM ra_product_orders_remove_acts('sale'::doc_types,OLD.id);
		
		PERFORM ra_materials_remove_acts('sale'::doc_types,OLD.id);

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



