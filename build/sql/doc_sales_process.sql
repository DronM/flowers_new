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
		
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='INSERT') THEN
		--log
		--PERFORM doc_log_insert('sale'::doc_types,NEW.id,NEW.date_time);
		INSERT INTO doc_log
		(doc_type,doc_id,date_time)
		VALUES ('sale'::doc_types,
				NEW.id,
				NEW.date_time
		)
		RETURNING id INTO v_doc_log_id;

		IF NOT doc_operative_processing('sale'::doc_types,NEW.id) THEN
			BEGIN
				INSERT INTO seq_viol_materials
				(doc_log_id,materials)
				VALUES (v_doc_log_id,
					ARRAY(SELECT t.material_id
						FROM doc_sales_t_materials t
						WHERE t.doc_id=NEW.id
						)
					);
			EXCEPTION WHEN unique_violation THEN 
			END;					
		END IF;
		
	
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		IF NOT doc_operative_processing('sale'::doc_types,NEW.id) THEN
			
			IF OLD.date_time<>NEW.date_time THEN
				--ВСЕ
				v_materials = ARRAY(
					SELECT t.material_id
					FROM doc_sales_t_materials t
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
					FROM doc_sales_t_materials tt
					WHERE tt.doc_id=OLD.id) AS t
					ON ra.material_id=t.material_id
				WHERE ra.doc_type='sale'
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
				WHERE doc_log.doc_type='sale'
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
		
		PERFORM ra_products_remove_acts('sale'::doc_types,NEW.id);
		
		PERFORM ra_product_orders_remove_acts('sale'::doc_types,NEW.id);
		
		PERFORM ra_materials_remove_acts('sale'::doc_types,NEW.id);

		IF NEW.date_time<>OLD.date_time THEN
			PERFORM doc_log_update('sale'::doc_types,NEW.id,NEW.date_time);
		END IF;

		v_doc_operative_processing = doc_operative_processing('sale'::doc_types,NEW.id);
	
		--CHECK MATERIAL BALANCE
		IF const_negat_material_balance_restrict_val()=TRUE THEN
			PERFORM process_material_check(
				NEW.id,
				'sale'::doc_types,	
				NEW.store_id,
				ARRAY(SELECT t.material_id
					FROM doc_sales_t_materials AS t
					WHERE t.doc_id=NEW.id
				),
				v_doc_operative_processing
			);		
		END IF;

		--CHECK Product BALANCE
		IF const_negat_product_balance_restrict_val()=TRUE THEN
			PERFORM process_product_check(
				NEW.id,
				'sale'::doc_types,	
				NEW.store_id,
				ARRAY(SELECT t.product_id
					FROM doc_sales_t_products AS t
					WHERE t.doc_id=NEW.id
				),
				ARRAY(SELECT t.doc_production_id
					FROM doc_sales_t_products AS t
					WHERE t.doc_id=NEW.id
				),				
				v_doc_operative_processing
			);		
		END IF;
		
		--calc total
		NEW.total = (SELECT coalesce(SUM(total),0)::numeric(15,2) FROM doc_sales_t_products WHERE doc_id=NEW.id) + 
			(SELECT coalesce(SUM(total),0)::numeric(15,2) FROM doc_sales_t_materials WHERE doc_id=NEW.id);

			
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='UPDATE') THEN
		--DOC PROCESSING
		--IF NEW.processed THEN
			v_doc_operative_processing = doc_operative_processing('sale'::doc_types,NEW.id);

			--*************** DEDUCT Products ***************************
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
				FALSE,'sale'::doc_types,
				NEW.id,
				NEW.store_id,
				t.product_id,
				t.doc_production_id,
				t.quant,
				SUM(ra_m.cost) AS cost
			FROM doc_sales_t_products AS t
			LEFT JOIN doc_productions AS d_p ON d_p.id=t.doc_production_id
			LEFT JOIN ra_materials AS ra_m ON
				ra_m.doc_id=t.doc_production_id
				AND ra_m.doc_type='production'			
			WHERE t.doc_id=NEW.id AND t.quant>0
			GROUP BY
				t.product_id,
				t.doc_production_id,
				t.quant			
			);			
			--*************** DEDUCT Products ***************************
/*
SELECT
	ra_p.product_id,
	ra_p.id,
	SUM(ra_m.cost) AS cost
FROM ra_products AS ra_p
LEFT JOIN doc_productions_t_materials AS dpt ON dpt.doc_id=ra_p.doc_production_id
LEFT JOIN ra_materials ra_m ON ra_m.doc_id=dpt.doc_id AND ra_m.doc_type='production' AND ra_m.material_id=dpt.material_id
WHERE ra_p.doc_id=323 AND ra_p.doc_type='sale'
GROUP BY
	ra_p.product_id,
	ra_p.id
*/

			-- ********* ADD ORDER ***************************
			/*
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
			*/
			-- ********* ADD ORDER ***************************

			
			--********* DEDUCT Materials **************************
			PERFORM process_material_deduct(	
				NEW.id,
				NEW.date_time,
				'sale'::doc_types,	
				NEW.store_id,
				doc_operative_processing('sale'::doc_types,NEW.id)
			);
			--********* DEDUCT Materials **************************

			--calc total cost
			/*
			NEW.total_material_cost = (
				SELECT
					coalesce(SUM(ra.cost),0) AS cost
				FROM ra_materials ra
				WHERE ra.doc_id=NEW.id
					AND ra.doc_type='sale'			
			);
			*/
			--NEW.total_product_cost = 
			/*
			RAISE '%',
			(
				SELECT
					coalesce(SUM(ra_m.cost),0) AS cost
				FROM doc_sales_t_products AS items
				LEFT JOIN ra_products AS ra ON ra.doc_id=items.doc_id AND ra.doc_type='sale' AND ra.product_id=items.product_id
				LEFT JOIN (
					SELECT 
						ra_m.doc_id,
						ra_m.doc_type,
						SUM(ra_m.cost) AS cost
					FROM ra_materials AS ra_m
					GROUP BY ra_m.doc_id,ra_m.doc_type
				) AS ra_m ON ra_m.doc_id=ra.doc_production_id AND ra_m.doc_type='production'
				WHERE ra.doc_id=NEW.id			
			);
			*/
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
