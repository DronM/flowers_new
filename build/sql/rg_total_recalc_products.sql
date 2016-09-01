-- Function: rg_total_recalc_products(timestamp)

--DROP FUNCTION rg_total_recalc_products(timestamp);

CREATE OR REPLACE FUNCTION rg_total_recalc_products(timestamp)
  RETURNS void AS
$BODY$  
	DELETE FROM rg_products
	WHERE
		$1 IS NULL
		OR ($1 IS NOT NULL AND date_time>=$1);
		
	INSERT INTO rg_products
	(date_time,store_id,product_id,doc_production_id,
	quant)
	(
		WITH
		--ДОДЕЛАТЬ: добавить остатки до $1
		acts AS(
			SELECT
				rg_calc_period_start('product',ra.date_time) AS period,
				ra.store_id,
				ra.product_id,
				ra.doc_production_id,
				SUM(CASE WHEN ra.deb THEN 1 ELSE -1 END*ra.quant) AS quant
			FROM ra_products AS ra
			WHERE $1 IS NULL OR ($1 IS NOT NULL AND ra.date_time>=$1)
			GROUP BY
				rg_calc_period_start('product',ra.date_time),
				ra.store_id,
				ra.product_id,
				ra.doc_production_id
			HAVING SUM(CASE WHEN ra.deb THEN 1 ELSE -1 END*ra.quant)<>0
			--ORDER BY period,ra.store_id,ra.product_id
		)
		SELECT qm.*
		FROM	
			((SELECT
				q.period,
				q.store_id,
				q.product_id,
				q.doc_production_id,

				COALESCE(
				(SELECT sub.quant
				FROM acts AS sub
				WHERE sub.period<q.period AND sub.store_id=q.store_id AND sub.product_id=q.product_id AND sub.doc_production_id=q.doc_production_id
				),0) + q.quant AS quant
			FROM acts AS q)
			
			UNION ALL
			
			--актуальные итоги
			(SELECT
				reg_current_balance_time(),
				q2.store_id,
				q2.product_id,
				q2.doc_production_id,
				SUM(q2.quant) AS quant
			FROM acts AS q2
			GROUP BY
				reg_current_balance_time(),
				q2.store_id,
				q2.product_id,
				q2.doc_production_id
			HAVING SUM(q2.quant)<>0
			)
			) AS qm
		WHERE qm.quant<>0	
	);
$BODY$
  LANGUAGE sql VOLATILE CALLED ON NULL INPUT
  COST 100;
ALTER FUNCTION rg_total_recalc_products(timestamp)
  OWNER TO bellagio;
