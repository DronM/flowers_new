-- Function: doc_material_to_wastes_process()

-- DROP FUNCTION doc_material_to_wastes_process();

CREATE OR REPLACE FUNCTION doc_material_to_wastes_process()
  RETURNS trigger AS
$BODY$
DECLARE
	v_error text DEFAULT '';
	balance_check RECORD;
	reg_act ra_materials%ROWTYPE;
	v_quant numeric;
	v_cost_to_act numeric;
	v_quant_to_act numeric;
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		SELECT coalesce(MAX(d.number),0)+1 INTO NEW.number FROM doc_material_to_wastes AS d
		WHERE		
		d.store_id=NEW.store_id;
		
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='INSERT') THEN
		--log
		INSERT INTO doc_log (doc_type,doc_id)
		VALUES ('material_to_waste'::doc_types,NEW.id);
	
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		--register actions
		PERFORM ra_materials_remove_acts('material_to_waste'::doc_types,NEW.id);

		--CHECK MATERIAL BALANCE
		FOR balance_check IN
			SELECT doct.material_id,doct.quant,m.name,coalesce(b.balance,0) AS balance
			FROM doc_material_to_wastes_t_materials AS doct
			
			LEFT JOIN (SELECT subb.material_id,SUM(subb.quant) AS balance
					FROM rg_materials_balance(
						ARRAY[NEW.store_id],
						ARRAY['main'::stock_types],
						ARRAY(SELECT t.material_id FROM doc_material_to_wastes_t_materials AS t WHERE t.doc_id=NEW.id),
						'{}'
					) AS subb
					GROUP BY subb.material_id
				) AS b
				ON b.material_id=doct.material_id
			LEFT JOIN materials AS m ON m.id=doct.material_id
			
			WHERE doct.doc_id=NEW.id
			AND coalesce(b.balance,0)-doct.quant<0
			LOOP

			IF v_error<>'' THEN
				v_error = v_error || ', ';
			END IF;
			v_error = v_error || 'материал: ' || balance_check.name || ' остаток: ' || balance_check.balance || ' затребовано ' || balance_check.quant;
		END LOOP;

		IF v_error<>'' THEN
			RAISE EXCEPTION '%',v_error;
		END IF;
	
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='UPDATE') THEN
		--IF NEW.processed THEN
			CREATE TEMP TABLE IF NOT EXISTS t_tmp_materials
			(material_id int, quant numeric ,CONSTRAINT t_materials_pkey PRIMARY KEY (material_id))
			ON COMMIT DROP;
			DELETE FROM t_tmp_materials;

			INSERT INTO t_tmp_materials (SELECT material_id, quant FROM doc_material_to_wastes_t_materials WHERE doc_id=NEW.id AND quant>0);
		
			--DEDUCT materials ON Main
			-- ADD Materials On Waste
			FOR balance_check IN
				SELECT b.material_id,b.doc_procurement_id,b.quant AS quant,b.cost AS cost
				FROM rg_materials_balance(
					ARRAY[NEW.store_id],
					ARRAY['main'::stock_types],
					ARRAY(SELECT t.material_id FROM doc_material_to_wastes_t_materials AS t WHERE t.doc_id=NEW.id),
					'{}'
					) AS b
				LEFT JOIN doc_material_procurements AS dp ON dp.id=b.doc_procurement_id
				ORDER BY dp.date_time
				LOOP
				
				SELECT quant INTO v_quant FROM t_tmp_materials WHERE material_id=balance_check.material_id;
				IF FOUND THEN
					v_quant_to_act = LEAST(v_quant,balance_check.quant);
					IF v_quant_to_act = balance_check.quant THEN
						v_cost_to_act = balance_check.cost;
					ELSIF balance_check.quant>0 THEN
						v_cost_to_act = ROUND(balance_check.cost/balance_check.quant*v_quant_to_act,2);
					ELSE
						v_cost_to_act = 0;
					END IF;

					--DEDUCT FROM MAIN
					reg_act.date_time		= NEW.date_time;
					reg_act.deb			= FALSE;
					reg_act.doc_type  		= 'material_to_waste'::doc_types;
					reg_act.doc_id  		= NEW.id;
					reg_act.store_id 		= NEW.store_id;
					reg_act.stock_type		= 'main'::stock_types;
					reg_act.doc_procurement_id	= balance_check.doc_procurement_id;
					reg_act.material_id		= balance_check.material_id;
					reg_act.quant			= v_quant_to_act;
					reg_act.cost			= v_cost_to_act;
					PERFORM ra_materials_add_act(reg_act);

					--ADD TO WASTE
					reg_act.date_time		= NEW.date_time;
					reg_act.deb			= TRUE;
					reg_act.doc_type  		= 'material_to_waste'::doc_types;
					reg_act.doc_id  		= NEW.id;
					reg_act.store_id 		= NEW.store_id;
					reg_act.stock_type		= 'waste'::stock_types;
					reg_act.doc_procurement_id	= balance_check.doc_procurement_id;
					reg_act.material_id		= balance_check.material_id;
					reg_act.quant			= v_quant_to_act;
					reg_act.cost			= v_cost_to_act;
					PERFORM ra_materials_add_act(reg_act);

					v_quant = v_quant - v_quant_to_act;
					IF (v_quant=0) THEN
						DELETE FROM t_tmp_materials WHERE material_id=balance_check.material_id;
					ELSE
						UPDATE t_tmp_materials SET quant=v_quant WHERE material_id=balance_check.material_id;
					END IF;
				END IF;
			END LOOP;
		--END IF;
	
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
		--detail tables
		
		DELETE FROM doc_material_to_wastes_t_materials WHERE doc_id=OLD.id;
						
		
		--register actions					
		
		PERFORM ra_materials_remove_acts('material_to_waste'::doc_types,OLD.id);
											
		
		--log
		DELETE FROM doc_log WHERE
		doc_type='material_to_waste'::doc_types
		AND doc_id=OLD.id;
		
		RETURN OLD;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
		RETURN OLD;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_material_to_wastes_process()
  OWNER TO bellagio;
