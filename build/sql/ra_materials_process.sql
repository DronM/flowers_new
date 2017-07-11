-- Function: ra_materials_process()

-- DROP FUNCTION ra_materials_process();

CREATE OR REPLACE FUNCTION ra_materials_process()
  RETURNS trigger AS
$BODY$
DECLARE
	v_delta_quant  numeric(19,3) DEFAULT 0;
	v_delta_cost  numeric(15,2) DEFAULT 0;
	
	CALC_DATE_TIME timestamp without time zone;
	CURRENT_BALANCE_DATE_TIME timestamp without time zone;
	v_loop_rg_period timestamp without time zone;
	v_calc_interval interval;			  			
BEGIN
	IF (TG_WHEN='BEFORE' AND TG_OP='INSERT') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='UPDATE') THEN
		RETURN NEW;
	ELSIF (TG_WHEN='AFTER' AND (TG_OP='UPDATE' OR TG_OP='INSERT')) THEN

		CALC_DATE_TIME = rg_calc_period('material'::reg_types);
		
		IF (CALC_DATE_TIME IS NULL) OR (NEW.date_time::date > rg_period_balance('material'::reg_types, CALC_DATE_TIME)) THEN
			--RAISE EXCEPTION 'На период % итоги не расчитаны!',date8_descr(NEW.date_time::date);						
			CALC_DATE_TIME = rg_period('material'::reg_types,NEW.date_time);
			PERFORM rg_materials_set_period(CALC_DATE_TIME);						
		END IF;
		
		IF TG_OP='UPDATE' THEN
			v_delta_quant = OLD.quant;
			v_delta_cost = OLD.cost;
		ELSE
			v_delta_quant = 0;
			v_delta_cost = 0;						
		END IF;
		v_delta_quant = NEW.quant - v_delta_quant;
		v_delta_cost = NEW.cost - v_delta_cost;
		
		IF NOT NEW.deb THEN
			v_delta_quant = -1 * v_delta_quant;
			v_delta_cost = -1 * v_delta_cost;
								
		END IF;
		
		v_loop_rg_period = CALC_DATE_TIME;--rg_period('material'::reg_types,NEW.date_time);
		v_calc_interval = rg_calc_interval('material'::reg_types);
		LOOP
			UPDATE rg_materials
			SET
			quant = quant + v_delta_quant,cost = cost + v_delta_cost
			WHERE 
				date_time=v_loop_rg_period
				
				AND store_id = NEW.store_id
				AND material_id = NEW.material_id;
			IF NOT FOUND THEN
				BEGIN
					INSERT INTO rg_materials (date_time
					
					,store_id
					,material_id
					,quant
					,cost)				
					VALUES (v_loop_rg_period
					
					,NEW.store_id
					,NEW.material_id
					,v_delta_quant
					,v_delta_cost);
				EXCEPTION WHEN OTHERS THEN
					UPDATE rg_materials
					SET
					quant = quant + v_delta_quant,cost = cost + v_delta_cost
					WHERE date_time = v_loop_rg_period
					
					AND store_id = NEW.store_id
					AND material_id = NEW.material_id;
				END;
			END IF;

			v_loop_rg_period = v_loop_rg_period + v_calc_interval;
			IF v_loop_rg_period > CALC_DATE_TIME THEN
				EXIT;  -- exit loop
			END IF;
		END LOOP;

		--Current balance
		CURRENT_BALANCE_DATE_TIME = reg_current_balance_time();
		UPDATE rg_materials
		SET
		quant = quant + v_delta_quant,cost = cost + v_delta_cost
		WHERE 
			date_time=CURRENT_BALANCE_DATE_TIME
			
			AND store_id = NEW.store_id
			AND material_id = NEW.material_id;
		IF NOT FOUND THEN
			BEGIN
				INSERT INTO rg_materials (date_time
				
				,store_id
				,material_id
				,quant
				,cost)				
				VALUES (CURRENT_BALANCE_DATE_TIME
				
				,NEW.store_id
				,NEW.material_id
				,v_delta_quant
				,v_delta_cost);
			EXCEPTION WHEN OTHERS THEN
				UPDATE rg_materials
				SET
				quant = quant + v_delta_quant,cost = cost + v_delta_cost
				WHERE 
					date_time=CURRENT_BALANCE_DATE_TIME
					
					AND store_id = NEW.store_id
					AND material_id = NEW.material_id;
			END;
		END IF;
		
		RETURN NEW;					
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN					
		RETURN OLD;
	ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
		
		CALC_DATE_TIME = rg_calc_period('material'::reg_types);
		
		IF (CALC_DATE_TIME IS NULL) OR (OLD.date_time::date > rg_period_balance('material'::reg_types, CALC_DATE_TIME)) THEN
			--RAISE EXCEPTION 'На период % итоги не расчитаны!',date8_descr(NEW.date_time::date);						
			CALC_DATE_TIME = rg_period('material'::reg_types,OLD.date_time);
			PERFORM rg_materials_set_period(CALC_DATE_TIME);						
		END IF;
		
		v_delta_quant = OLD.quant;
		v_delta_cost = OLD.cost;
							
		IF OLD.deb THEN
			v_delta_quant = -1*v_delta_quant;					
			v_delta_cost = -1*v_delta_cost;					
			
		END IF;
		
		v_loop_rg_period = CALC_DATE_TIME;--rg_period('material'::reg_types,OLD.date_time);
		v_calc_interval = rg_calc_interval('material'::reg_types);
		LOOP
			UPDATE rg_materials
			SET
			quant = quant + v_delta_quant,cost = cost + v_delta_cost
			WHERE 
				date_time=v_loop_rg_period
				
				AND store_id = OLD.store_id
				AND material_id = OLD.material_id;
			IF NOT FOUND THEN
				BEGIN
					INSERT INTO rg_materials (date_time
					
					,store_id
					,material_id
					,quant
					,cost)				
					VALUES (v_loop_rg_period
					
					,OLD.store_id
					,OLD.material_id
					,v_delta_quant
					,v_delta_cost);
				EXCEPTION WHEN OTHERS THEN
					UPDATE rg_materials
					SET
					quant = quant + v_delta_quant,cost = cost + v_delta_cost
					WHERE date_time = v_loop_rg_period
					
					AND store_id = OLD.store_id
					AND material_id = OLD.material_id;
				END;
			END IF;

			v_loop_rg_period = v_loop_rg_period + v_calc_interval;
			IF v_loop_rg_period > CALC_DATE_TIME THEN
				EXIT;  -- exit loop
			END IF;
		END LOOP;

		--Current balance
		CURRENT_BALANCE_DATE_TIME = reg_current_balance_time();
		UPDATE rg_materials
		SET
		quant = quant + v_delta_quant,cost = cost + v_delta_cost
		WHERE 
			date_time=CURRENT_BALANCE_DATE_TIME
			
			AND store_id = OLD.store_id
			AND material_id = OLD.material_id;
		IF NOT FOUND THEN
			BEGIN
				INSERT INTO rg_materials (date_time
				
				,store_id
				,material_id
				,quant
				,cost)				
				VALUES (CURRENT_BALANCE_DATE_TIME
				
				,OLD.store_id
				,OLD.material_id
				,v_delta_quant
				,v_delta_cost);
			EXCEPTION WHEN OTHERS THEN
				UPDATE rg_materials
				SET
				quant = quant + v_delta_quant,cost = cost + v_delta_cost
				WHERE 
					date_time=CURRENT_BALANCE_DATE_TIME
					
					AND store_id = OLD.store_id
					AND material_id = OLD.material_id;
			END;
		END IF;					
		RETURN OLD;					
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION ra_materials_process()
  OWNER TO bellagio;

