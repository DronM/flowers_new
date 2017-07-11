


-- ******************* update 25/11/2016 22:48:58 ******************

					ALTER TYPE reg_types ADD VALUE 'client_order';
					
		CREATE TABLE rg_client_orders
		(id serial,date_time timestamp NOT NULL,store_id int REFERENCES stores(id),doc_client_order_id int REFERENCES doc_client_orders(id),total  numeric(19,3),CONSTRAINT rg_client_orders_pkey PRIMARY KEY (id));
		
	CREATE INDEX rg_client_orders_date_time_idx
	ON rg_client_orders
	(date_time);

	CREATE INDEX rg_client_orders_store_id_idx
	ON rg_client_orders
	(store_id);

	CREATE INDEX rg_client_orders_doc_client_order_id_idx
	ON rg_client_orders
	(doc_client_order_id);

		ALTER TABLE rg_client_orders OWNER TO bellagio;
	
--virtual tables

CREATE OR REPLACE FUNCTION rg_client_orders_balance(in_date_time timestamp without time zone,
	
	IN in_store_id_ar int[]
	,
	IN in_doc_client_order_id_ar int[]
					
	)

  RETURNS TABLE(
	store_id int,doc_client_order_id int
	,
	total  numeric(19,3)				
	) AS
$BODY$
DECLARE
	v_cur_per timestamp;
	v_act_direct boolean;
	v_act_direct_sgn int;
	v_calc_interval interval;
BEGIN
	v_cur_per = rg_period('client_order'::reg_types, in_date_time);
	v_calc_interval = rg_calc_interval('client_order'::reg_types);
	v_act_direct = ( (rg_calc_period_end('material'::reg_types,v_cur_per)-in_date_time)>(in_date_time - v_cur_per) );
	IF v_act_direct THEN
		v_act_direct_sgn = 1;
	ELSE
		v_act_direct_sgn = -1;
	END IF;
	RETURN QUERY 
	SELECT 
	
	sub.store_id,
	sub.doc_client_order_id
	,SUM(sub.total) AS total				
	FROM(
		SELECT
		
		b.store_id,
		b.doc_client_order_id
		,b.total				
		FROM rg_client_orders AS b
		WHERE (v_act_direct AND b.date_time = (v_cur_per-v_calc_interval)) OR (NOT v_act_direct AND b.date_time = v_cur_per)
		
		AND (ARRAY_LENGTH(in_store_id_ar,1) IS NULL OR (b.store_id=ANY(in_store_id_ar)))
		
		AND (ARRAY_LENGTH(in_doc_client_order_id_ar,1) IS NULL OR (b.doc_client_order_id=ANY(in_doc_client_order_id_ar)))
		
		AND (
		b.total<>0
		)
		
		UNION ALL
		
		(SELECT
		
		act.store_id,
		act.doc_client_order_id
		,CASE act.deb
			WHEN TRUE THEN act.total*v_act_direct_sgn
			ELSE -act.total*v_act_direct_sgn
		END AS quant
										
		FROM doc_log
		LEFT JOIN ra_client_orders AS act ON act.doc_type=doc_log.doc_type AND act.doc_id=doc_log.doc_id
		WHERE (v_act_direct AND (doc_log.date_time>=v_cur_per AND doc_log.date_time<in_date_time) )
			OR (NOT v_act_direct AND (doc_log.date_time<(v_cur_per+v_calc_interval) AND doc_log.date_time>=in_date_time) )
		
		AND (ARRAY_LENGTH(in_store_id_ar,1) IS NULL OR (act.store_id=ANY(in_store_id_ar)))
		
		AND (ARRAY_LENGTH(in_doc_client_order_id_ar,1) IS NULL OR (act.doc_client_order_id=ANY(in_doc_client_order_id_ar)))
		
		AND (
		
		act.total<>0
		)
		ORDER BY doc_log.date_time,doc_log.id)
	) AS sub
	WHERE
	 (ARRAY_LENGTH(in_store_id_ar,1) IS NULL OR (sub.store_id=ANY(in_store_id_ar)))
	AND (ARRAY_LENGTH(in_doc_client_order_id_ar,1) IS NULL OR (sub.doc_client_order_id=ANY(in_doc_client_order_id_ar)))
		
	GROUP BY
		
		sub.store_id,
		sub.doc_client_order_id
	HAVING
		
		SUM(sub.total)<>0
						
	ORDER BY
		
		sub.store_id,
		sub.doc_client_order_id;
END;			
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100;

ALTER FUNCTION rg_client_orders_balance(in_date_time timestamp without time zone,
	
	IN in_store_id_ar int[]
	,
	IN in_doc_client_order_id_ar int[]
					
	)
 OWNER TO bellagio;

--balance on doc

CREATE OR REPLACE FUNCTION rg_client_orders_balance(in_doc_type doc_types, in_doc_id int,
	
	IN in_store_id_ar int[]
	,
	IN in_doc_client_order_id_ar int[]
					
	)

  RETURNS TABLE(
	store_id int,doc_client_order_id int
	,
	total  numeric(19,3)				
	) AS
$BODY$
DECLARE
	v_doc_date_time timestamp without time zone;
	v_cur_per timestamp;
	v_act_direct boolean;
	v_act_direct_sgn int;
	v_calc_interval interval;
BEGIN
	SELECT date_time INTO v_doc_date_time FROM doc_log WHERE doc_type=in_doc_type AND doc_id=in_doc_id;
	v_cur_per = rg_period('client_order'::reg_types, v_doc_date_time);
	v_calc_interval = rg_calc_interval('client_order'::reg_types);
	v_act_direct = ( (rg_calc_period_end('material'::reg_types,v_cur_per)-v_doc_date_time)>(v_doc_date_time - v_cur_per) );
	IF v_act_direct THEN
		v_act_direct_sgn = 1;
	ELSE
		v_act_direct_sgn = -1;
	END IF;

	RETURN QUERY 
	SELECT 
	
	sub.store_id,
	sub.doc_client_order_id
	,SUM(sub.total) AS total				
	FROM(
	SELECT
	
	b.store_id,
	b.doc_client_order_id
	,b.total				
	FROM rg_client_orders AS b
	WHERE (v_act_direct AND b.date_time = (v_cur_per-v_calc_interval)) OR (NOT v_act_direct AND b.date_time = v_cur_per)
	
	AND (ARRAY_LENGTH(in_store_id_ar,1) IS NULL OR (b.store_id=ANY(in_store_id_ar)))
	
	AND (ARRAY_LENGTH(in_doc_client_order_id_ar,1) IS NULL OR (b.doc_client_order_id=ANY(in_doc_client_order_id_ar)))
	
	AND(
	b.total<>0
	)
	
	UNION ALL
	
	(SELECT
	
	act.store_id,
	act.doc_client_order_id
	,
	CASE act.deb
		WHEN TRUE THEN act.total*v_act_direct_sgn
		ELSE -act.total*v_act_direct_sgn
	END AS total								
	FROM doc_log
	LEFT JOIN ra_client_orders AS act ON act.doc_type=doc_log.doc_type AND act.doc_id=doc_log.doc_id
	WHERE (v_act_direct AND (doc_log.date_time>=v_cur_per AND doc_log.date_time<v_doc_date_time) )
		OR (NOT v_act_direct AND (doc_log.date_time<(v_cur_per+v_calc_interval) AND doc_log.date_time>=v_doc_date_time) )				
	
	AND (ARRAY_LENGTH(in_store_id_ar,1) IS NULL OR (act.store_id=ANY(in_store_id_ar)))
	
	AND (ARRAY_LENGTH(in_doc_client_order_id_ar,1) IS NULL OR (act.doc_client_order_id=ANY(in_doc_client_order_id_ar)))
	
	AND (
	
	act.total<>0
	)
	ORDER BY doc_log.date_time,doc_log.id)
	) AS sub
	WHERE
	 (ARRAY_LENGTH(in_store_id_ar,1) IS NULL OR (sub.store_id=ANY(in_store_id_ar)))
	AND (ARRAY_LENGTH(in_doc_client_order_id_ar,1) IS NULL OR (sub.doc_client_order_id=ANY(in_doc_client_order_id_ar)))
			
	GROUP BY
	
	sub.store_id,
	sub.doc_client_order_id
	HAVING
	
	SUM(sub.total)<>0
					
	ORDER BY
	
	sub.store_id,
	sub.doc_client_order_id;
END;			
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100;

ALTER FUNCTION rg_client_orders_balance(in_doc_type doc_types, in_doc_id int,
	
	IN in_store_id_ar int[]
	,
	IN in_doc_client_order_id_ar int[]
					
	)
 OWNER TO bellagio;

--TA balance

CREATE OR REPLACE FUNCTION rg_client_orders_balance(
	
	IN in_store_id_ar int[]
	,
	IN in_doc_client_order_id_ar int[]
					
	)

  RETURNS TABLE(
	store_id int,doc_client_order_id int
	,
	total  numeric(19,3)				
	) AS
$BODY$
BEGIN
	RETURN QUERY 
	SELECT
		
		b.store_id,
		b.doc_client_order_id
		,b.total AS total				
	FROM rg_client_orders AS b
	WHERE b.date_time=reg_current_balance_time()
		
		AND (ARRAY_LENGTH(in_store_id_ar,1) IS NULL OR (b.store_id=ANY(in_store_id_ar)))
		
		AND (ARRAY_LENGTH(in_doc_client_order_id_ar,1) IS NULL OR (b.doc_client_order_id=ANY(in_doc_client_order_id_ar)))
		
		AND(
		b.total<>0
		)
	ORDER BY
		
		b.store_id,
		b.doc_client_order_id;
END;			
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100;

ALTER FUNCTION rg_client_orders_balance(
	
	IN in_store_id_ar int[]
	,
	IN in_doc_client_order_id_ar int[]
					
	)
 OWNER TO bellagio;

CREATE OR REPLACE FUNCTION reg_client_order_set_custom_period(IN in_new_period timestamp without time zone)
  RETURNS void AS
$BODY$
DECLARE
	NEW_PERIOD timestamp without time zone;
	v_prev_current_period timestamp without time zone;
	v_current_period timestamp without time zone;
	CURRENT_PERIOD timestamp without time zone;
	TA_PERIOD timestamp without time zone;
	REG_INTERVAL interval;
BEGIN
	NEW_PERIOD = rg_calc_period_start('client_order'::reg_types, in_new_period);
	SELECT date_time INTO CURRENT_PERIOD FROM rg_calc_periods WHERE reg_type = 'client_order'::reg_types;
	TA_PERIOD = reg_current_balance_time();
	--iterate through all periods between CURRENT_PERIOD and NEW_PERIOD
	REG_INTERVAL = rg_calc_interval('client_order'::reg_types);
	v_prev_current_period = CURRENT_PERIOD;		
	LOOP
		v_current_period = v_prev_current_period + REG_INTERVAL;
		IF v_current_period > NEW_PERIOD THEN
			EXIT;  -- exit loop
		END IF;
		
		--clear period
		DELETE FROM rg_client_orders
		WHERE date_time = v_current_period;
		
		--new data
		INSERT INTO rg_client_orders
		(date_time
		
		,store_id
		,doc_client_order_id
		,total						
		)
		(SELECT
				v_current_period
				
				,rg.store_id
				,rg.doc_client_order_id
				,rg.total				
			FROM rg_client_orders As rg
			WHERE (
			
			rg.total<>0
										
			)
			AND (rg.date_time=v_prev_current_period)
		);

		v_prev_current_period = v_current_period;
	END LOOP;

	--new TA data
	DELETE FROM rg_client_orders
	WHERE date_time=TA_PERIOD;
	INSERT INTO rg_client_orders
	(date_time,store_id,stock_type,material_id,doc_procurement_id,quant,cost)
	(SELECT
			TA_PERIOD
		
		,store_id
		,doc_client_order_id
		,total
		FROM rg_materials AS rg
		WHERE (
		
		rg.total<>0
											
		)
		AND (rg.date_time=NEW_PERIOD)
	);

	DELETE FROM rg_materials WHERE (date_time>NEW_PERIOD)
	AND (date_time<>TA_PERIOD);

	--set new period
	UPDATE rg_calc_periods SET date_time = NEW_PERIOD
	WHERE reg_type='client_order'::reg_types;		
END
$BODY$
LANGUAGE plpgsql VOLATILE COST 100;

ALTER FUNCTION reg_client_order_set_custom_period(IN in_new_period timestamp without time zone) OWNER TO bellagio;

		CREATE TABLE ra_client_orders
		(id serial,date_time timestamp,doc_type doc_types,doc_id int,deb bool,store_id int REFERENCES stores(id),doc_client_order_id int REFERENCES doc_client_orders(id),total  numeric(19,3),CONSTRAINT ra_client_orders_pkey PRIMARY KEY (id));
		
	CREATE INDEX ra_client_orders_store_id_idx
	ON ra_client_orders
	(store_id);

	CREATE INDEX ra_client_orders_client_order_id_idx
	ON ra_client_orders
	(doc_client_order_id);

	CREATE INDEX ra_client_orders_date_time_idx
	ON ra_client_orders
	(date_time);

		ALTER TABLE ra_client_orders OWNER TO bellagio;
					
			
			--process function
			CREATE OR REPLACE FUNCTION ra_client_orders_process()
			  RETURNS trigger AS
			$BODY$
			DECLARE
				v_delta_total  numeric(19,3) DEFAULT 0;
				
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
					IF (CALC_DATE_TIME IS NULL) OR (CALC_DATE_TIME < NEW.date_time) THEN
						--RAISE EXCEPTION 'На период % итоги не расчитаны!',date8_descr(NEW.date_time::date);
						CALC_DATE_TIME = rg_calc_period_start(''::reg_types,NEW.date_time);
						PERFORM reg__set_custom_period(CALC_DATE_TIME);
					END IF;
					
					IF TG_OP='UPDATE' THEN
						v_delta_total = OLD.total;
						
					ELSE
						v_delta_total = 0;
											
					END IF;
					v_delta_total = NEW.total - v_delta_total;
					
					IF NOT NEW.deb THEN
						v_delta_total = -1 * v_delta_total;
											
					END IF;
					
					v_loop_rg_period = rg_period('client_order'::reg_types,NEW.date_time);
					v_calc_interval = rg_calc_interval('client_order'::reg_types);
					LOOP
						UPDATE rg_client_orders
						SET
						total = total + v_delta_total
						WHERE 
							date_time=v_loop_rg_period
							
							AND store_id = NEW.store_id
							AND doc_client_order_id = NEW.doc_client_order_id;
						IF NOT FOUND THEN
							BEGIN
								INSERT INTO rg_client_orders (date_time
								
								,store_id
								,doc_client_order_id
								,total)				
								VALUES (v_loop_rg_period
								
								,NEW.store_id
								,NEW.doc_client_order_id
								,v_delta_total);
							EXCEPTION WHEN OTHERS THEN
								UPDATE rg_client_orders
								SET
								total = total + v_delta_total
								WHERE date_time = v_loop_rg_period
								
								AND store_id = NEW.store_id
								AND doc_client_order_id = NEW.doc_client_order_id;
							END;
						END IF;

						v_loop_rg_period = v_loop_rg_period + v_calc_interval;
						IF v_loop_rg_period > CALC_DATE_TIME THEN
							EXIT;  -- exit loop
						END IF;
					END LOOP;

					--Current balance
					CURRENT_BALANCE_DATE_TIME = reg_current_balance_time();
					UPDATE rg_client_orders
					SET
					total = total + v_delta_total
					WHERE 
						date_time=CURRENT_BALANCE_DATE_TIME
						
						AND store_id = NEW.store_id
						AND doc_client_order_id = NEW.doc_client_order_id;
					IF NOT FOUND THEN
						BEGIN
							INSERT INTO rg_client_orders (date_time
							
							,store_id
							,doc_client_order_id
							,total)				
							VALUES (CURRENT_BALANCE_DATE_TIME
							
							,NEW.store_id
							,NEW.doc_client_order_id
							,v_delta_total);
						EXCEPTION WHEN OTHERS THEN
							UPDATE rg_client_orders
							SET
							total = total + v_delta_total
							WHERE 
								date_time=CURRENT_BALANCE_DATE_TIME
								
								AND store_id = NEW.store_id
								AND doc_client_order_id = NEW.doc_client_order_id;
						END;
					END IF;
					
					RETURN NEW;					
				ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN
					RETURN OLD;
				ELSIF (TG_WHEN='AFTER' AND TG_OP='DELETE') THEN
					SELECT date_time INTO CALC_DATE_TIME FROM rg_calc_periods WHERE reg_type='material'::reg_types;
					IF CALC_DATE_TIME < OLD.date_time THEN
						--RAISE EXCEPTION 'На период % итоги не расчитаны!',date8_descr(OLD.date_time::date);
						CALC_DATE_TIME = rg_calc_period_start(''::reg_types,OLD.date_time);
						PERFORM reg__set_custom_period(CALC_DATE_TIME);						
					END IF;
					
					v_delta_total = OLD.total;
										
					IF OLD.deb THEN
						v_delta_total = -1*v_delta_total;					
						
					END IF;
					
					v_loop_rg_period = rg_period('client_order'::reg_types,OLD.date_time);
					v_calc_interval = rg_calc_interval('client_order'::reg_types);
					LOOP
						UPDATE rg_client_orders
						SET
						total = total + v_delta_total
						WHERE 
							date_time=v_loop_rg_period
							
							AND store_id = OLD.store_id
							AND doc_client_order_id = OLD.doc_client_order_id;
						IF NOT FOUND THEN
							BEGIN
								INSERT INTO rg_client_orders (date_time
								
								,store_id
								,doc_client_order_id
								,total)				
								VALUES (v_loop_rg_period
								
								,OLD.store_id
								,OLD.doc_client_order_id
								,v_delta_total);
							EXCEPTION WHEN OTHERS THEN
								UPDATE rg_client_orders
								SET
								total = total + v_delta_total
								WHERE date_time = v_loop_rg_period
								
								AND store_id = OLD.store_id
								AND doc_client_order_id = OLD.doc_client_order_id;
							END;
						END IF;

						v_loop_rg_period = v_loop_rg_period + v_calc_interval;
						IF v_loop_rg_period > CALC_DATE_TIME THEN
							EXIT;  -- exit loop
						END IF;
					END LOOP;

					--Current balance
					CURRENT_BALANCE_DATE_TIME = reg_current_balance_time();
					UPDATE rg_client_orders
					SET
					total = total + v_delta_total
					WHERE 
						date_time=CURRENT_BALANCE_DATE_TIME
						
						AND store_id = OLD.store_id
						AND doc_client_order_id = OLD.doc_client_order_id;
					IF NOT FOUND THEN
						BEGIN
							INSERT INTO rg_client_orders (date_time
							
							,store_id
							,doc_client_order_id
							,total)				
							VALUES (CURRENT_BALANCE_DATE_TIME
							
							,OLD.store_id
							,OLD.doc_client_order_id
							,v_delta_total);
						EXCEPTION WHEN OTHERS THEN
							UPDATE rg_client_orders
							SET
							total = total + v_delta_total
							WHERE 
								date_time=CURRENT_BALANCE_DATE_TIME
								
								AND store_id = OLD.store_id
								AND doc_client_order_id = OLD.doc_client_order_id;
						END;
					END IF;					
					RETURN OLD;					
				END IF;
			END;
			$BODY$
			  LANGUAGE plpgsql VOLATILE COST 100;
			
			ALTER FUNCTION ra_client_orders_process() OWNER TO bellagio;
			
			-- before trigger
			CREATE TRIGGER ra_client_orders_before
				BEFORE INSERT OR UPDATE OR DELETE ON ra_client_orders
				FOR EACH ROW EXECUTE PROCEDURE ra_client_orders_process();
			-- after trigger
			CREATE TRIGGER ra_client_orders_after
				AFTER INSERT OR UPDATE OR DELETE ON ra_client_orders
				FOR EACH ROW EXECUTE PROCEDURE ra_client_orders_process();
				
			-- register actions
			
			-- ADD
			CREATE OR REPLACE FUNCTION ra_client_orders_add_act(reg_act ra_client_orders)
			RETURNS void AS
			$BODY$
				INSERT INTO ra_client_orders
				(date_time,doc_type,doc_id
				,deb
				,store_id
				,doc_client_order_id
				,total				
				)
				VALUES (
				$1.date_time,$1.doc_type,$1.doc_id
				,$1.deb
				,$1.store_id
				,$1.doc_client_order_id
				,$1.total				
				);
			$BODY$
			LANGUAGE sql VOLATILE STRICT COST 100;
			
			ALTER FUNCTION ra_client_orders_add_act(reg_act ra_client_orders) OWNER TO bellagio;
			
			-- REMOVE
			CREATE OR REPLACE FUNCTION ra_client_orders_remove_acts(in_doc_type doc_types,in_doc_id int)
			RETURNS void AS
			$BODY$
				DELETE FROM ra_client_orders
				WHERE doc_type=$1 AND doc_id=$2;
			$BODY$
			LANGUAGE sql VOLATILE STRICT COST 100;
			
			ALTER FUNCTION ra_client_orders_remove_acts(in_doc_type doc_types,in_doc_id int) OWNER TO bellagio;
			
			
			--virtual tables
			
			--DROP VIEW ra_client_orders_list_view;
			CREATE OR REPLACE VIEW ra_client_orders_list_view AS
			SELECT
			ra_client_orders.id,
			ra_client_orders.date_time,
			ra_client_orders.deb,
			ra_client_orders.doc_type,
			ra_client_orders.doc_id,
			doc_descr('doc_client_order'::doc_types, doc1.number::text, doc1.date_time) AS doc_descr
			FROM ra_client_orders
			ORDER BY date_time
			;
			
			ALTER TABLE ra_client_orders_list_view OWNER TO bellagio;
			
		CREATE OR REPLACE FUNCTION rg_period(in_reg_type reg_types, in_date_time timestamp without time zone) RETURNS timestamp without time zone
			LANGUAGE plpgsql
			AS
		$BODY$
		BEGIN
			--START_DATE = '2000-01-01';
			--reg_interval = register_interval(in_reg_id);
			RETURN date_trunc('MONTH', in_date_time)::timestamp without time zone;
		END;
		$BODY$
		LANGUAGE plpgsql VOLATILE COST 100;
		ALTER FUNCTION rg_period(in_reg_type reg_types, in_date_time timestamp without time zone) OWNER TO <xsl:value-of select="/metadata/@owner"/>;
		
		CREATE OR REPLACE FUNCTION reg_current_balance_time()
		  RETURNS timestamp without time zone AS
		$BODY$
			SELECT '3000-01-01 00:00:00'::timestamp without time zone;
		$BODY$
		  LANGUAGE sql VOLATILE COST 100;
		ALTER FUNCTION reg_current_balance_time() OWNER TO bellagio;
		
		CREATE OR REPLACE FUNCTION rg_calc_interval(in_reg_type reg_types)
		  RETURNS interval AS
		$BODY$
			SELECT
				CASE $1
								
				WHEN 'material'::reg_types THEN '1 month'::interval
								
				WHEN 'product'::reg_types THEN '1 month'::interval
								
				WHEN 'client_order'::reg_types THEN '1 month'::interval
				
				END;
		$BODY$
		  LANGUAGE sql VOLATILE COST 100;
		ALTER FUNCTION rg_calc_interval(reg_types) OWNER TO bellagio;
	
		CREATE TABLE IF NOT EXISTS rg_calc_periods(
		  reg_type reg_types NOT NULL,
		  date_time timestamp NOT NULL,
		  CONSTRAINT rg_calc_periods_pkey PRIMARY KEY (reg_type)
		);
		ALTER TABLE rg_calc_periods OWNER TO bellagio;
		INSERT INTO rg_calc_periods VALUES
		
			('client_order'::reg_types,'2014-01-01 00:00:00'::timestamp without time zone)
		;
	
			
			
		
			
				
			
			
			
			
			
		
			
			
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
			
						
		
			
			
			
			
		
			
			
			
		
			
			
			
			
			
			
		
			
			
			
			
			
			
			
		
			
			
			
			
		
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
		
			
			
			
			
		
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
			
						
			
			
			
			
			
			
			
			
			
			
						
			
			
			
			
			
		
			
			
						
			
			
			
		
			
			
			
			
			
		
			
			
			
			
			
									
			
			
			
			
			
			
						
			
			
		
			
			
			
						
			
			
			
			
			
			
						
			
			
						
			
		
			
			
			
			
			
			
			
						
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
						
			
			
			
			
						
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
			
			
			
						
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
						
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
						
			
			
			
			
			
		
			
			
			
			
			
									
			
			
			
			
			
			
			
			
			
		
						
			
			
			
			
			
		
			
			
			
						
			
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
			
		
			
			
			
			
			
						
			
						
			
			
			
			
			
						
						
						
						
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
			
			
		
						
			
			
						
			
			
			
			
			
									
		
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
			
			
		
			
			
		
			
			
			
						
			
			
			
			
			
			
			
			
			
		
			
			
			
			
						
			
			
			
			
			
		
			
			
			
			
			
			
			
			
		
			
			
			
					
		
			
			
			
			
			
						
			
			
			
						
			
		
			
			
			
						
			
			
			
			
			
			
		
			
			
			
			
		
			
			
			
			
			
			
			
			
		
			
			
		
