-- Function: rg_total_recalc_materials()

-- DROP FUNCTION rg_total_recalc_materials();

CREATE OR REPLACE FUNCTION rg_total_recalc_materials()
  RETURNS void AS
$BODY$  
DECLARE
	period_row RECORD;
	v_act_date_time timestamp without time zone;
	v_cur_period timestamp without time zone;
	
	CALC_DATE_TIME timestamp;
	ACT_DATE_TIME timestamp;
	v_loop_rg_period timestamp;
	v_loop_rg_period_prev timestamp;
	v_calc_interval interval;			  				
BEGIN
	ACT_DATE_TIME = reg_current_balance_time();
	
	--Текущий расчетный период
	SELECT date_time INTO CALC_DATE_TIME
	FROM rg_calc_periods
	WHERE reg_type='material'::reg_types;
	
	--Самый старый период
	v_loop_rg_period = rg_period('material'::reg_types,
		(SELECT date_time FROM ra_materials ORDER BY date_time LIMIT 1));	
	-- интервал регистра
	v_calc_interval = rg_calc_interval('material'::reg_types);
	v_loop_rg_period_prev = v_loop_rg_period-v_calc_interval;
	
	--очистим остатки
	DELETE FROM rg_materials;	
	LOOP				
		--Расчет новых остатков
		
		INSERT INTO rg_materials
		(date_time,
		store_id,
		stock_type,
		material_id,
		doc_procurement_id,
		quant,
		cost
		)
		(
		SELECT 
			v_loop_rg_period,
			sb.store_id,
			sb.stock_type,
			sb.material_id,
			sb.doc_procurement_id,
			sum(sb.quant) AS quant,
			sum(sb.cost) AS cost
		FROM(
			(
			SELECT
				rg.store_id,
				rg.stock_type,
				rg.material_id,
				rg.doc_procurement_id,
				rg.quant AS quant,
				rg.cost As cost
			FROM rg_materials AS rg
			WHERE rg.date_time=v_loop_rg_period_prev
			)
			UNION
			(SELECT
				ra.store_id,
				ra.stock_type,
				ra.material_id,
				ra.doc_procurement_id,
				sum(
				CASE ra.deb
					WHEN TRUE THEN ra.quant
					ELSE ra.quant*(-1)
				END
				) AS quant,
				sum(
				CASE ra.deb
					WHEN TRUE THEN ra.cost
					ELSE ra.cost*(-1)
				END
				) AS cost
			FROM ra_materials AS ra
			WHERE ra.date_time<v_loop_rg_period+v_calc_interval
				AND ra.date_time>=v_loop_rg_period
			GROUP BY
				ra.store_id,
				ra.stock_type,
				ra.material_id,
				ra.doc_procurement_id		
			)
		) AS sb		
		GROUP BY
			v_loop_rg_period,
			sb.store_id,
			sb.stock_type,
			sb.material_id,
			sb.doc_procurement_id		
		HAVING sum(sb.quant)<>0 OR sum(sb.cost)<>0
		);
		
		v_loop_rg_period_prev = v_loop_rg_period;
		v_loop_rg_period = v_loop_rg_period + v_calc_interval;
		IF v_loop_rg_period > ACT_DATE_TIME THEN
			EXIT;  -- exit loop
		ELSIF v_loop_rg_period > CALC_DATE_TIME THEN
			--АКТУАЛЬНЫЕ ИТОГИ
			v_loop_rg_period = ACT_DATE_TIME;
		END IF;
		
		--RAISE 'Завершили период %',v_loop_rg_period;
	END LOOP;
END;	
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION rg_total_recalc_materials()
  OWNER TO bellagio;
