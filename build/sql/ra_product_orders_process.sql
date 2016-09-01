-- Function: ra_product_orders_process()

-- DROP FUNCTION ra_product_orders_process();

CREATE OR REPLACE FUNCTION ra_product_orders_process()
  RETURNS trigger AS
$BODY$
			DECLARE
				v_delta_quant  numeric(19,3) DEFAULT 0;
				
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
					SELECT date_time INTO CALC_DATE_TIME FROM rg_calc_periods WHERE reg_type='material'::reg_types;
					IF (CALC_DATE_TIME IS NULL) OR ((CALC_DATE_TIME+'1 month') <= NEW.date_time) THEN
						--RAISE EXCEPTION 'На период % итоги не расчитаны!',date8_descr(NEW.date_time::date);
						CALC_DATE_TIME = rg_calc_period_start('product_order'::reg_types,NEW.date_time);
						PERFORM reg_product_order_set_custom_period(CALC_DATE_TIME);
					END IF;
					
					IF TG_OP='UPDATE' THEN
						v_delta_quant = OLD.quant;
					ELSE
						v_delta_quant = 0;
					END IF;
					v_delta_quant = NEW.quant - v_delta_quant;
					
					IF NOT NEW.deb THEN
						v_delta_quant = -1 * v_delta_quant;
											
					END IF;
					
					v_loop_rg_period = rg_period('product_order'::reg_types,NEW.date_time);
					v_calc_interval = rg_calc_interval('product_order'::reg_types);
					LOOP
						UPDATE rg_product_orders
						SET
						quant = quant + v_delta_quant
						WHERE 
							date_time=v_loop_rg_period
							
							AND store_id = NEW.store_id
							AND product_order_type = NEW.product_order_type
							AND product_id = NEW.product_id;
						IF NOT FOUND THEN
							BEGIN
								INSERT INTO rg_product_orders (date_time
								
								,store_id
								,product_order_type
								,product_id
								,quant)				
								VALUES (v_loop_rg_period
								
								,NEW.store_id
								,NEW.product_order_type
								,NEW.product_id
								,v_delta_quant);
							EXCEPTION WHEN OTHERS THEN
								UPDATE rg_product_orders
								SET
								quant = quant + v_delta_quant
								WHERE date_time = v_loop_rg_period
								
								AND store_id = NEW.store_id
								AND product_order_type = NEW.product_order_type
								AND product_id = NEW.product_id;
							END;
						END IF;

						v_loop_rg_period = v_loop_rg_period + v_calc_interval;
						IF v_loop_rg_period > CALC_DATE_TIME THEN
							EXIT;  -- exit loop
						END IF;
					END LOOP;

					--Current balance
					CURRENT_BALANCE_DATE_TIME = reg_current_balance_time();
					UPDATE rg_product_orders
					SET
					quant = quant + v_delta_quant
					WHERE 
						date_time=CURRENT_BALANCE_DATE_TIME
						
						AND store_id = NEW.store_id
						AND product_order_type = NEW.product_order_type
						AND product_id = NEW.product_id;
					IF NOT FOUND THEN
						BEGIN
							INSERT INTO rg_product_orders (date_time
							
							,store_id
							,product_order_type
							,product_id
							,quant)				
							VALUES (CURRENT_BALANCE_DATE_TIME
							
							,NEW.store_id
							,NEW.product_order_type
							,NEW.product_id
							,v_delta_quant);
						EXCEPTION WHEN OTHERS THEN
							UPDATE rg_product_orders
							SET
							quant = quant + v_delta_quant
							WHERE 
								date_time=CURRENT_BALANCE_DATE_TIME
								
								AND store_id = NEW.store_id
								AND product_order_type = NEW.product_order_type
								AND product_id = NEW.product_id;
						END;
					END IF;
					
					RETURN NEW;					
				ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
					RETURN OLD;
				ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
					SELECT date_time INTO CALC_DATE_TIME FROM rg_calc_periods WHERE reg_type='material'::reg_types;
					IF CALC_DATE_TIME < OLD.date_time THEN
						--RAISE EXCEPTION 'На период % итоги не расчитаны!',date8_descr(OLD.date_time::date);
						CALC_DATE_TIME = rg_calc_period_start('product_order'::reg_types,OLD.date_time);
						PERFORM reg_product_order_set_custom_period(CALC_DATE_TIME);						
					END IF;
					
					v_delta_quant = OLD.quant;
										
					IF OLD.deb THEN
						v_delta_quant = -1*v_delta_quant;					
						
					END IF;
					
					v_loop_rg_period = rg_period('product_order'::reg_types,OLD.date_time);
					v_calc_interval = rg_calc_interval('product_order'::reg_types);
					LOOP
						UPDATE rg_product_orders
						SET
						quant = quant + v_delta_quant
						WHERE 
							date_time=v_loop_rg_period
							
							AND store_id = OLD.store_id
							AND product_order_type = OLD.product_order_type
							AND product_id = OLD.product_id;
						IF NOT FOUND THEN
							BEGIN
								INSERT INTO rg_product_orders (date_time
								
								,store_id
								,product_order_type
								,product_id
								,quant)				
								VALUES (v_loop_rg_period
								
								,OLD.store_id
								,OLD.product_order_type
								,OLD.product_id
								,v_delta_quant);
							EXCEPTION WHEN OTHERS THEN
								UPDATE rg_product_orders
								SET
								quant = quant + v_delta_quant
								WHERE date_time = v_loop_rg_period
								
								AND store_id = OLD.store_id
								AND product_order_type = OLD.product_order_type
								AND product_id = OLD.product_id;
							END;
						END IF;

						v_loop_rg_period = v_loop_rg_period + v_calc_interval;
						IF v_loop_rg_period > CALC_DATE_TIME THEN
							EXIT;  -- exit loop
						END IF;
					END LOOP;

					--Current balance
					CURRENT_BALANCE_DATE_TIME = reg_current_balance_time();
					UPDATE rg_product_orders
					SET
					quant = quant + v_delta_quant
					WHERE 
						date_time=CURRENT_BALANCE_DATE_TIME
						
						AND store_id = OLD.store_id
						AND product_order_type = OLD.product_order_type
						AND product_id = OLD.product_id;
					IF NOT FOUND THEN
						BEGIN
							INSERT INTO rg_product_orders (date_time
							
							,store_id
							,product_order_type
							,product_id
							,quant)				
							VALUES (CURRENT_BALANCE_DATE_TIME
							
							,OLD.store_id
							,OLD.product_order_type
							,OLD.product_id
							,v_delta_quant);
						EXCEPTION WHEN OTHERS THEN
							UPDATE rg_product_orders
							SET
							quant = quant + v_delta_quant
							WHERE 
								date_time=CURRENT_BALANCE_DATE_TIME
								
								AND store_id = OLD.store_id
								AND product_order_type = OLD.product_order_type
								AND product_id = OLD.product_id;
						END;
					END IF;					
					RETURN OLD;					
				END IF;
			END;
			$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION ra_product_orders_process()
  OWNER TO bellagio;
