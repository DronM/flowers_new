-- Function: reg_material_set_custom_period(IN in_new_period timestamp without time zone)

--DROP FUNCTION reg_material_set_custom_period(IN in_new_period timestamp without time zone)

CREATE OR REPLACE FUNCTION reg_material_set_custom_period(IN in_new_period timestamp without time zone)
  RETURNS void AS
$BODY$
DECLARE
	v_prev_current_period timestamp without time zone;
	v_current_period timestamp without time zone;
	CURRENT_PERIOD timestamp without time zone;
	TA_PERIOD timestamp without time zone;
	REG_INTERVAL interval;
BEGIN
	SELECT date_time INTO CURRENT_PERIOD FROM rg_calc_periods WHERE reg_type = 'material'::reg_types;
	TA_PERIOD = reg_current_balance_time();
	--iterate through all periods between CURRENT_PERIOD and in_new_period
	REG_INTERVAL = rg_calc_interval('material'::reg_types);
	v_prev_current_period = CURRENT_PERIOD;		
	LOOP
		v_current_period = v_prev_current_period + REG_INTERVAL;
		IF v_current_period > in_new_period THEN
			EXIT;  -- exit loop
		END IF;
		
		--clear period
		DELETE FROM rg_materials WHERE date_time = v_current_period;
		
		--new data
		INSERT INTO rg_materials
		(date_time,store_id,stock_type,material_id,doc_procurement_id,quant,cost)
		(SELECT
				v_current_period,
				rg.store_id,
				rg.stock_type,
				rg.material_id,
				rg.doc_procurement_id,
				rg.quant,
				rg.cost
			FROM rg_materials As rg
			WHERE (rg.quant<>0 OR rg.cost<>0) AND (rg.date_time=v_prev_current_period)
		);

		v_prev_current_period = v_current_period;
	END LOOP;

	--new TA data
	DELETE FROM rg_materials WHERE date_time=TA_PERIOD;
	INSERT INTO rg_materials
	(date_time,store_id,stock_type,material_id,doc_procurement_id,quant,cost)
	(SELECT
			TA_PERIOD,
			rg.store_id,
			rg.stock_type,
			rg.material_id,
			rg.doc_procurement_id,
			rg.quant,
			rg.cost
		FROM rg_materials As rg
		WHERE (rg.quant<>0 OR rg.cost<>0) AND (rg.date_time=in_new_period)
	);

	DELETE FROM rg_materials WHERE (date_time>in_new_period) AND (date_time<>TA_PERIOD);

	--set new period
	UPDATE rg_calc_periods SET date_time = in_new_period WHERE reg_type='material'::reg_types;		
END
$BODY$
LANGUAGE plpgsql VOLATILE COST 100;
ALTER FUNCTION reg_material_set_custom_period(IN in_new_period timestamp without time zone) OWNER TO bellagio;
