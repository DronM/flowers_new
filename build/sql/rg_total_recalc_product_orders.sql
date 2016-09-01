-- Function: rg_total_recalc_product_orders()

-- DROP FUNCTION rg_total_recalc_product_orders();

CREATE OR REPLACE FUNCTION rg_total_recalc_product_orders()
  RETURNS void AS
$BODY$  
DECLARE
	period_row RECORD;
	v_act_date_time timestamp without time zone;
	v_cur_period timestamp without time zone;
BEGIN	
	v_act_date_time = reg_current_balance_time();
	SELECT date_time INTO v_cur_period
	FROM rg_calc_periods WHERE reg_type='product_order'::reg_types;
	
	FOR period_row IN
		WITH
		periods AS (
			(SELECT
				DISTINCT date_trunc('month', date_time) AS d,
				store_id,
				product_order_type,
				product_id
			FROM ra_products)
			UNION		
			(SELECT
				date_time AS d,
				store_id,
				product_order_type,				
				product_id
			FROM rg_products WHERE date_time<=v_cur_period
			)
			ORDER BY d			
		)
		SELECT
			sub.d,
			sub.store_id,
			sub.product_order_type,
			sub.product_id,
			sub.balance_fact,
			sub.balance_paper
		FROM
		(
		SELECT
			periods.d,
			periods.store_id,
			periods.product_order_type,
			periods.product_id,
			COALESCE((
				SELECT SUM(CASE WHEN deb THEN quant ELSE 0 END)-SUM(CASE WHEN NOT deb THEN quant ELSE 0 END)
				FROM ra_products AS ra
				WHERE ra.date_time <= last_month_day(periods.d::date)+'23:59:59'::interval
				AND ra.store_id=periods.store_id
				AND ra.product_order_type=periods.product_order_type
				AND ra.product_id=periods.product_id
			),0) AS balance_fact,
			
			(
			SELECT SUM(quant) FROM rg_products
			WHERE date_time=periods.d
				AND store_id=periods.store_id
				AND product_order_type=periods.product_order_type
				AND product_id=periods.product_id				
			) AS balance_paper
			
		FROM periods
		) AS sub
		WHERE sub.balance_fact<>sub.balance_paper
		ORDER BY sub.d	
	LOOP
		
		UPDATE rg_products AS rg
		SET quant = period_row.balance_fact
		WHERE rg.date_time=period_row.d
		AND rg.store_id=period_row.store_id
		AND rg.product_order_type=period_row.product_order_type
		AND rg.product_id=period_row.product_id						
		;
		
		IF NOT FOUND THEN
			INSERT INTO rg_products (
				date_time,
				store_id,
				product_order_type,
				product_id,
				quant)
			VALUES (
				period_row.d,
				period_row.store_id,
				period_row.product_order_type,
				period_row.product_id,
				period_row.balance_fact);
		END IF;
	END LOOP;

	--АКТУАЛЬНЫЕ ИТОГИ
	DELETE FROM rg_products WHERE date_time>v_cur_period;
	
	INSERT INTO rg_products (
		date_time,
		store_id,
		product_order_type,
		product_id,
		quant)
	(
	SELECT
		v_act_date_time,
		rg.store_id,
		rg.product_order_type,
		rg.product_id,
		COALESCE(rg.quant,0) +
		COALESCE((
		SELECT sum(ra.quant) FROM
		ra_products AS ra
		WHERE ra.date_time BETWEEN v_cur_period AND last_month_day(v_cur_period::date)+'23:59:59'::interval
			AND ra.store_id=rg.store_id
			AND ra.product_order_type=rg.product_order_type
			AND ra.product_id=rg.product_id
			AND ra.deb=TRUE
		),0) - 
		COALESCE((
		SELECT sum(ra.quant) FROM
		ra_products AS ra
		WHERE ra.date_time BETWEEN v_cur_period AND last_month_day(v_cur_period::date)+'23:59:59'::interval
			AND ra.store_id=rg.store_id
			AND ra.product_order_type=rg.product_order_type
			AND ra.product_id=rg.product_id			
			AND ra.deb=FALSE
		),0)
		
	FROM rg_products AS rg
	WHERE date_time=(v_cur_period-'1 month'::interval)
	);	
END;	
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION rg_total_recalc_product_orders()
  OWNER TO bellagio;
