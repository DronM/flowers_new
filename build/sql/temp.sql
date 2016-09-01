--SELECT * FROM material_procurement_plan('2013-12-13',ARRAY[1,1,1,1,1.2,1,1])
/* Function: material_procurement_plan(
	IN in_date_time timestamp without time zone,
	IN in_day_turnover_ar integer[],
	in_stock_day_count int
)
*/
/*
DROP FUNCTION material_procurement_plan(
	IN in_date_time timestamp without time zone,
	IN in_day_turnover_ar integer[],
	in_stock_day_count int
);
*/
CREATE OR REPLACE FUNCTION material_procurement_plan(
	IN in_date_time timestamp without time zone,
	IN in_day_turnover_ar numeric[],
	in_stock_day_count int
	)
  RETURNS TABLE(
	material_descr text,
	quant_norm numeric,
	quant_balance_begin numeric,
	quant_on_products numeric,
	quant_balance_end numeric,
	quant_procur_day1 numeric,
	quant_flow_day1 numeric,
	quant_bal_day1 numeric,
	quant_order_day1 numeric,
	quant_need_day1 numeric,
	
	quant_procur_day2 numeric,
	quant_flow_day2 numeric,
	quant_bal_day2 numeric,
	quant_order_day2 numeric,
	quant_need_day2 numeric,
	
	quant_procur_day3 numeric,
	quant_flow_day3 numeric,
	quant_bal_day3 numeric,
	quant_order_day3 numeric,
	quant_need_day3 numeric,

	quant_procur_day4 numeric,
	quant_flow_day4 numeric,
	quant_bal_day4 numeric,
	quant_order_day4 numeric,
	quant_need_day4 numeric,
	
	quant_procur_day5 numeric,
	quant_flow_day5 numeric,
	quant_bal_day5 numeric,
	quant_order_day5 numeric,
	quant_need_day5 numeric,
	
	quant_procur_day6 numeric,
	quant_flow_day6 numeric,
	quant_bal_day6 numeric,
	quant_order_day6 numeric,
	quant_need_day6 numeric,
	
	quant_procur_day7 numeric,
	quant_flow_day7 numeric,
	quant_bal_day7 numeric,
	quant_order_day7 numeric,
	quant_need_day7 numeric
	
  ) AS
$BODY$
DECLARE
	date_time_day1 date;
	date_time_day2 date;
	date_time_day3 date;
	date_time_day4 date;
	date_time_day5 date;
	date_time_day6 date;
	date_time_day7 date;
	date_time_begin timestamp without time zone;
	date_time_end timestamp without time zone;
	day_turnover_ar numeric[7];
	i integer;
BEGIN
	date_time_day1 = in_date_time::date;
	date_time_day2 = date_time_day1+'1 day'::interval;
	date_time_day3 = date_time_day2+'1 day'::interval;
	date_time_day4 = date_time_day3+'1 day'::interval;
	date_time_day5 = date_time_day4+'1 day'::interval;
	date_time_day6 = date_time_day5+'1 day'::interval;
	date_time_day7 = date_time_day6+'1 day'::interval;

	date_time_begin = date_time_day1 + '00:00:00'::interval;
	date_time_end = date_time_day7 + '23:59:59.999'::interval;
	
	FOR i IN 1..7 LOOP
		day_turnover_ar[i] = in_day_turnover_ar[EXTRACT(DOW FROM in_date_time+(i||' days')::interval-'1 day '::interval)+1];
	END LOOP;
	
	RETURN QUERY
	WITH
	mat_bal_from_specif AS (
		SELECT sp.material_id, SUM(b.quant) AS quant
		FROM rg_products_balance(in_date_time, ARRAY[1],'{}','{}') AS b
		LEFT JOIN specifications AS sp ON sp.product_id=b.product_id
		GROUP BY sp.material_id
		),
		
	mat_list AS (
		/*
			material list consists of
				1) all materials from specifications of products which have balance
				2) all materials from specifications of products for sale
			
		*/
		SELECT material_id FROM mat_bal_from_specif
		UNION
		SELECT material_id
		FROM specifications AS sp
		LEFT JOIN products AS p ON p.id=sp.product_id
		WHERE p.for_sale
		 ),
	mat_procur AS (
		SELECT t.material_id, t.date_time::date AS date, SUM(t.quant) AS quant
		FROM ra_materials AS t
		WHERE t.material_id IN (SELECT material_id FROM mat_list) AND (t.date_time BETWEEN date_time_begin AND date_time_end) AND t.deb
		GROUP BY t.material_id,t.date_time
		ORDER BY t.material_id,t.date_time
		 ),
		 
	mat_flow AS (
		SELECT t.material_id, t.date_time::date AS date, SUM(t.quant) AS quant
		FROM ra_materials AS t
		WHERE t.material_id IN (SELECT material_id FROM mat_list) AND (t.date_time BETWEEN date_time_begin AND date_time_end) AND NOT t.deb
		GROUP BY t.material_id,t.date_time
		ORDER BY t.material_id,t.date_time
		 ),

	mat_order AS (
		SELECT t.material_id, h.date_time::date AS date, SUM(t.quant) AS quant
		FROM doc_material_orders_t_materials AS t
		LEFT JOIN doc_material_orders AS h ON h.id=t.doc_id
		WHERE t.material_id IN (SELECT material_id FROM mat_list) AND (h.date_time BETWEEN date_time_begin AND date_time_end)
		GROUP BY t.material_id,h.date_time
		ORDER BY t.material_id,h.date_time
		 )     


	SELECT
		/* ***************** BALANCE *******************/
		m.name::text AS material_descr,
		sp.material_quant*sp.product_quant*in_stock_day_count AS quant_norm,
		bal.quant AS quant_balance_begin,
		mat_bal_from_specif.quant AS quant_on_products,
		bal.quant + mat_bal_from_specif.quant - (sp.material_quant*sp.product_quant)*4 AS quant_balance_end,
		/* **************************************** */

		/* ************** DAY 1 ********************/
		--1 procurement
		mat_procur_day1.quant AS quant_procur_day1,

		--2 flow
		CASE 
			WHEN CURRENT_DATE>=date_time_day1 THEN mat_flow_day1.quant*day_turnover_ar[1]
			ELSE sp.material_quant*sp.product_quant*day_turnover_ar[1]
		END AS quant_flow_day1,

		--3 balance
		bal.quant + mat_procur_day1.quant - 
			CASE 
				WHEN CURRENT_DATE>=date_time_day1 THEN mat_flow_day1.quant*day_turnover_ar[1]
				ELSE sp.material_quant*sp.product_quant*day_turnover_ar[1]
			END
		AS quant_bal_day1,

		--4 order
		mat_order_day1.quant-mat_procur_day1.quant AS quant_order_day1,

		--5 need
		0::numeric AS quant_need_day1,
		/* ********************************** */

		/* ************ DAY 2 *************** */
		--1 procurement
		mat_procur_day2.quant AS quant_procur_day2,

		--2 flow
		CASE 
			WHEN CURRENT_DATE>=date_time_day2 THEN mat_flow_day2.quant*day_turnover_ar[2]
			ELSE sp.material_quant*sp.product_quant*day_turnover_ar[2]
		END AS quant_flow_day2,

		--3 balance
		(
		bal.quant + mat_procur_day1.quant - 
			CASE 
				WHEN CURRENT_DATE>=date_time_day1 THEN mat_flow_day1.quant*day_turnover_ar[1]
				ELSE sp.material_quant*sp.product_quant*day_turnover_ar[1]
			END	
		) + mat_procur_day2.quant - 
			CASE 
				WHEN CURRENT_DATE>=date_time_day2 THEN mat_flow_day2.quant*day_turnover_ar[2]
				ELSE sp.material_quant*sp.product_quant*day_turnover_ar[2]
			END
		AS quant_bal_day2,	

		--4 order
		mat_order_day2.quant-mat_procur_day2.quant AS quant_order_day2,

		--5 need
		(
		bal.quant + mat_procur_day1.quant - 
			CASE 
				WHEN CURRENT_DATE>=date_time_day1 THEN mat_flow_day1.quant*day_turnover_ar[1]
				ELSE sp.material_quant*sp.product_quant*day_turnover_ar[1]
			END
		)
		-
		(CASE 
			WHEN CURRENT_DATE>=date_time_day2 THEN mat_flow_day2.quant*day_turnover_ar[2]
			ELSE sp.material_quant*sp.product_quant*day_turnover_ar[2]
		END)
		+ (mat_order_day2.quant - mat_procur_day2.quant)
		AS quant_need_day2,
		/* ******************************************** */


		/* ***************** DAY 3 *********************/
		--1 procurement
		mat_procur_day3.quant AS quant_procur_day3,

		--2 flow
		CASE 
			WHEN CURRENT_DATE>=date_time_day3 THEN mat_flow_day3.quant*day_turnover_ar[3]
			ELSE sp.material_quant*sp.product_quant*day_turnover_ar[3]
		END AS quant_flow_day3,

		--3 balance
		(
			(
			bal.quant + mat_procur_day1.quant - 
				CASE 
					WHEN CURRENT_DATE>=date_time_day1 THEN mat_flow_day1.quant*day_turnover_ar[1]
					ELSE sp.material_quant*sp.product_quant*day_turnover_ar[1]
				END	
			) + mat_procur_day2.quant - 
				CASE 
					WHEN CURRENT_DATE>=date_time_day2 THEN mat_flow_day2.quant*day_turnover_ar[2]
					ELSE sp.material_quant*sp.product_quant*day_turnover_ar[2]
				END
		)+ mat_procur_day3.quant - 
				CASE 
					WHEN CURRENT_DATE>=date_time_day3 THEN mat_flow_day3.quant*day_turnover_ar[3]
					ELSE sp.material_quant*sp.product_quant*day_turnover_ar[3]
				END
		AS quant_bal_day3,	

		--4 order
		mat_order_day3.quant - mat_procur_day3.quant AS quant_order_day3,

		--5 need
		(                     
			(
			bal.quant + mat_procur_day1.quant - 
				CASE 
					WHEN CURRENT_DATE>=date_time_day1 THEN mat_flow_day1.quant*day_turnover_ar[1]
					ELSE sp.material_quant*sp.product_quant*day_turnover_ar[1]
				END	
			) + mat_procur_day2.quant - 
				CASE 
					WHEN CURRENT_DATE>=date_time_day2 THEN mat_flow_day2.quant*day_turnover_ar[2]
					ELSE sp.material_quant*sp.product_quant*day_turnover_ar[2]
				END	
		)
		-
		(CASE 
			WHEN CURRENT_DATE>=date_time_day3 THEN mat_flow_day3.quant*day_turnover_ar[3]
			ELSE sp.material_quant*sp.product_quant*day_turnover_ar[3]
		END)
		+
		(mat_order_day3.quant-mat_procur_day3.quant) AS quant_order_day5,
		/* ************************************** */


		/* ****************** DAY 4 *********************************/
		--1 procurement
		mat_procur_day4.quant AS quant_procur_day4,

		--2 flow
		CASE 
			WHEN CURRENT_DATE>=date_time_day4 THEN mat_flow_day4.quant*day_turnover_ar[4]
			ELSE sp.material_quant*sp.product_quant*day_turnover_ar[4]
		END AS quant_flow_day4,

		--3 balance
		(
			(
				(
				bal.quant + mat_procur_day1.quant - 
					CASE 
						WHEN CURRENT_DATE>=date_time_day1 THEN mat_flow_day1.quant*day_turnover_ar[1]
						ELSE sp.material_quant*sp.product_quant*day_turnover_ar[1]
					END	
				) + mat_procur_day2.quant - 
					CASE 
						WHEN CURRENT_DATE>=date_time_day2 THEN mat_flow_day2.quant*day_turnover_ar[2]
						ELSE sp.material_quant*sp.product_quant*day_turnover_ar[2]
					END
			)+ mat_procur_day3.quant - 
					CASE 
						WHEN CURRENT_DATE>=date_time_day3 THEN mat_flow_day3.quant*day_turnover_ar[3]
						ELSE sp.material_quant*sp.product_quant*day_turnover_ar[3]
					END
		)+ mat_procur_day4.quant - 
					CASE 
						WHEN CURRENT_DATE>=date_time_day4 THEN mat_flow_day4.quant*day_turnover_ar[4]
						ELSE sp.material_quant*sp.product_quant*day_turnover_ar[4]
					END
		AS quant_bal_day4,	

		--4 order
		mat_order_day4.quant - mat_procur_day4.quant AS quant_order_day4,

		--5 need
		(
			(
				(
				bal.quant + mat_procur_day1.quant - 
					CASE 
						WHEN CURRENT_DATE>=date_time_day1 THEN mat_flow_day1.quant*day_turnover_ar[1]
						ELSE sp.material_quant*sp.product_quant*day_turnover_ar[1]
					END	
				) + mat_procur_day2.quant - 
					CASE 
						WHEN CURRENT_DATE>=date_time_day2 THEN mat_flow_day2.quant*day_turnover_ar[2]
						ELSE sp.material_quant*sp.product_quant*day_turnover_ar[2]
					END
			)+ mat_procur_day3.quant - 
					CASE 
						WHEN CURRENT_DATE>=date_time_day3 THEN mat_flow_day3.quant*day_turnover_ar[3]
						ELSE sp.material_quant*sp.product_quant*day_turnover_ar[3]
					END		
		)
		-
		(CASE 
			WHEN CURRENT_DATE>=date_time_day4 THEN mat_flow_day4.quant*day_turnover_ar[4]
			ELSE sp.material_quant*sp.product_quant*day_turnover_ar[4]
		END)
		+
		(mat_order_day4.quant - mat_procur_day4.quant)
		AS quant_need_day_4,
		/* *********************************************** */


		/* ********************** DAY 5 ********************/
		--1 procurement
		mat_procur_day5.quant AS quant_procur_day5,

		--2 flow
		CASE 
			WHEN CURRENT_DATE>=date_time_day5 THEN mat_flow_day5.quant*day_turnover_ar[5]
			ELSE sp.material_quant*sp.product_quant*day_turnover_ar[5]
		END AS quant_flow_day5,

		--3 balance
		(
			(
				(
					(
					bal.quant + mat_procur_day1.quant - 
						CASE 
							WHEN CURRENT_DATE>=date_time_day1 THEN mat_flow_day1.quant*day_turnover_ar[1]
							ELSE sp.material_quant*sp.product_quant*day_turnover_ar[1]
						END	
					) + mat_procur_day2.quant - 
						CASE 
							WHEN CURRENT_DATE>=date_time_day2 THEN mat_flow_day2.quant*day_turnover_ar[2]
							ELSE sp.material_quant*sp.product_quant*day_turnover_ar[2]
						END
				)+ mat_procur_day3.quant - 
						CASE 
							WHEN CURRENT_DATE>=date_time_day3 THEN mat_flow_day3.quant*day_turnover_ar[3]
							ELSE sp.material_quant*sp.product_quant*day_turnover_ar[3]
						END
			)+ mat_procur_day4.quant - 
						CASE 
							WHEN CURRENT_DATE>=date_time_day4 THEN mat_flow_day4.quant*day_turnover_ar[4]
							ELSE sp.material_quant*sp.product_quant*day_turnover_ar[4]
						END
		)+ mat_procur_day5.quant - 
						CASE 
							WHEN CURRENT_DATE>=date_time_day5 THEN mat_flow_day5.quant*day_turnover_ar[5]
							ELSE sp.material_quant*sp.product_quant*day_turnover_ar[5]
						END
		AS quant_bal_day5,	

		--4 order
		mat_order_day5.quant - mat_procur_day5.quant AS quant_order_day5,

		--5 need
		(
			(
				(
					(
					bal.quant + mat_procur_day1.quant - 
						CASE 
							WHEN CURRENT_DATE>=date_time_day1 THEN mat_flow_day1.quant*day_turnover_ar[1]
							ELSE sp.material_quant*sp.product_quant*day_turnover_ar[1]
						END	
					) + mat_procur_day2.quant - 
						CASE 
							WHEN CURRENT_DATE>=date_time_day2 THEN mat_flow_day2.quant*day_turnover_ar[2]
							ELSE sp.material_quant*sp.product_quant*day_turnover_ar[2]
						END
				)+ mat_procur_day3.quant - 
						CASE 
							WHEN CURRENT_DATE>=date_time_day3 THEN mat_flow_day3.quant*day_turnover_ar[3]
							ELSE sp.material_quant*sp.product_quant*day_turnover_ar[3]
						END
			)+ mat_procur_day4.quant - 
						CASE 
							WHEN CURRENT_DATE>=date_time_day4 THEN mat_flow_day4.quant*day_turnover_ar[4]
							ELSE sp.material_quant*sp.product_quant*day_turnover_ar[4]
						END
		)
		-
		(CASE 
			WHEN CURRENT_DATE>=date_time_day5 THEN mat_flow_day5.quant*day_turnover_ar[5]
			ELSE sp.material_quant*sp.product_quant*day_turnover_ar[5]
		END)
		+
		(mat_order_day5.quant - mat_procur_day5.quant)
		AS quant_need_day5,
		/* ************************************************* */


		/* *********************** DAY 6 ***************************/
		--1 procurement
		mat_procur_day6.quant AS quant_procur_day6,

		--2 flow
		CASE 
			WHEN CURRENT_DATE>=date_time_day6 THEN mat_flow_day6.quant*day_turnover_ar[6]
			ELSE sp.material_quant*sp.product_quant*day_turnover_ar[6]
		END AS quant_flow_day6,

		--3 balance
		(
			(
				(
					(
						(
						bal.quant + mat_procur_day1.quant - 
							CASE 
								WHEN CURRENT_DATE>=date_time_day1 THEN mat_flow_day1.quant*day_turnover_ar[1]
								ELSE sp.material_quant*sp.product_quant*day_turnover_ar[1]
							END	
						) + mat_procur_day2.quant - 
							CASE 
								WHEN CURRENT_DATE>=date_time_day2 THEN mat_flow_day2.quant*day_turnover_ar[2]
								ELSE sp.material_quant*sp.product_quant*day_turnover_ar[2]
							END
					)+ mat_procur_day3.quant - 
							CASE 
								WHEN CURRENT_DATE>=date_time_day3 THEN mat_flow_day3.quant*day_turnover_ar[3]
								ELSE sp.material_quant*sp.product_quant*day_turnover_ar[3]
							END
				)+ mat_procur_day4.quant - 
							CASE 
								WHEN CURRENT_DATE>=date_time_day4 THEN mat_flow_day4.quant*day_turnover_ar[4]
								ELSE sp.material_quant*sp.product_quant*day_turnover_ar[4]
							END
			)+ mat_procur_day5.quant - 
							CASE 
								WHEN CURRENT_DATE>=date_time_day5 THEN mat_flow_day5.quant*day_turnover_ar[5]
								ELSE sp.material_quant*sp.product_quant*day_turnover_ar[5]
							END
		)+ mat_procur_day6.quant - 
							CASE 
								WHEN CURRENT_DATE>=date_time_day6 THEN mat_flow_day6.quant*day_turnover_ar[6]
								ELSE sp.material_quant*sp.product_quant*day_turnover_ar[6]
							END
		AS quant_bal_day6,	

		--4 order
		mat_order_day6.quant - mat_procur_day6.quant AS quant_order_day6,

		--5 need
		(
			(
				(
					(
						(
						bal.quant + mat_procur_day1.quant - 
							CASE 
								WHEN CURRENT_DATE>=date_time_day1 THEN mat_flow_day1.quant*day_turnover_ar[1]
								ELSE sp.material_quant*sp.product_quant*day_turnover_ar[1]
							END	
						) + mat_procur_day2.quant - 
							CASE 
								WHEN CURRENT_DATE>=date_time_day2 THEN mat_flow_day2.quant*day_turnover_ar[2]
								ELSE sp.material_quant*sp.product_quant*day_turnover_ar[2]
							END
					)+ mat_procur_day3.quant - 
							CASE 
								WHEN CURRENT_DATE>=date_time_day3 THEN mat_flow_day3.quant*day_turnover_ar[3]
								ELSE sp.material_quant*sp.product_quant*day_turnover_ar[3]
							END
				)+ mat_procur_day4.quant - 
							CASE 
								WHEN CURRENT_DATE>=date_time_day4 THEN mat_flow_day4.quant*day_turnover_ar[4]
								ELSE sp.material_quant*sp.product_quant*day_turnover_ar[4]
							END
			)+ mat_procur_day5.quant - 
							CASE 
								WHEN CURRENT_DATE>=date_time_day5 THEN mat_flow_day5.quant*day_turnover_ar[5]
								ELSE sp.material_quant*sp.product_quant*day_turnover_ar[5]
							END
		)
		-
		(CASE 
			WHEN CURRENT_DATE>=date_time_day6 THEN mat_flow_day6.quant*day_turnover_ar[6]
			ELSE sp.material_quant*sp.product_quant*day_turnover_ar[6]
		END)
		+
		(mat_order_day6.quant - mat_procur_day6.quant)
		AS quant_need_day6,
		/* ************************************************************** */


		/* **************************** DAY 7 ****************************/
		--1 procurement
		mat_procur_day7.quant AS quant_procur_day7,

		--2 flow
		CASE 
			WHEN CURRENT_DATE>=date_time_day7 THEN mat_flow_day7.quant*day_turnover_ar[7]
			ELSE sp.material_quant*sp.product_quant*day_turnover_ar[7]
		END AS quant_flow_day7,

		--3 balance
		(
			(
				(
					(
						(
							(
							bal.quant + mat_procur_day1.quant - 
								CASE 
									WHEN CURRENT_DATE>=date_time_day1 THEN mat_flow_day1.quant*day_turnover_ar[1]
									ELSE sp.material_quant*sp.product_quant*day_turnover_ar[1]
								END	
							) + mat_procur_day2.quant - 
								CASE 
									WHEN CURRENT_DATE>=date_time_day2 THEN mat_flow_day2.quant*day_turnover_ar[2]
									ELSE sp.material_quant*sp.product_quant*day_turnover_ar[2]
								END
						)+ mat_procur_day3.quant - 
								CASE 
									WHEN CURRENT_DATE>=date_time_day3 THEN mat_flow_day3.quant*day_turnover_ar[3]
									ELSE sp.material_quant*sp.product_quant*day_turnover_ar[3]
								END
					)+ mat_procur_day4.quant - 
								CASE 
									WHEN CURRENT_DATE>=date_time_day4 THEN mat_flow_day4.quant*day_turnover_ar[4]
									ELSE sp.material_quant*sp.product_quant*day_turnover_ar[4]
								END
				)+ mat_procur_day5.quant - 
								CASE 
									WHEN CURRENT_DATE>=date_time_day5 THEN mat_flow_day5.quant*day_turnover_ar[5]
									ELSE sp.material_quant*sp.product_quant*day_turnover_ar[5]
								END
			)+ mat_procur_day6.quant - 
								CASE 
									WHEN CURRENT_DATE>=date_time_day6 THEN mat_flow_day6.quant*day_turnover_ar[6]
									ELSE sp.material_quant*sp.product_quant*day_turnover_ar[6]
								END
		)+ mat_procur_day7.quant - 
								CASE 
									WHEN CURRENT_DATE>=date_time_day7 THEN mat_flow_day7.quant*day_turnover_ar[7]
									ELSE sp.material_quant*sp.product_quant*day_turnover_ar[7]
								END
		AS quant_bal_day7,

		--4 order
		mat_order_day7.quant - mat_procur_day7.quant AS quant_order_day7,

		--5 balance
		(
			(
				(
					(
						(
							(
							bal.quant + mat_procur_day1.quant - 
								CASE 
									WHEN CURRENT_DATE>=date_time_day1 THEN mat_flow_day1.quant*day_turnover_ar[1]
									ELSE sp.material_quant*sp.product_quant*day_turnover_ar[1]
								END	
							) + mat_procur_day2.quant - 
								CASE 
									WHEN CURRENT_DATE>=date_time_day2 THEN mat_flow_day2.quant*day_turnover_ar[2]
									ELSE sp.material_quant*sp.product_quant*day_turnover_ar[2]
								END
						)+ mat_procur_day3.quant - 
								CASE 
									WHEN CURRENT_DATE>=date_time_day3 THEN mat_flow_day3.quant*day_turnover_ar[3]
									ELSE sp.material_quant*sp.product_quant*day_turnover_ar[3]
								END
					)+ mat_procur_day4.quant - 
								CASE 
									WHEN CURRENT_DATE>=date_time_day4 THEN mat_flow_day4.quant*day_turnover_ar[4]
									ELSE sp.material_quant*sp.product_quant*day_turnover_ar[4]
								END
				)+ mat_procur_day5.quant - 
								CASE 
									WHEN CURRENT_DATE>=date_time_day5 THEN mat_flow_day5.quant*day_turnover_ar[5]
									ELSE sp.material_quant*sp.product_quant*day_turnover_ar[5]
								END
			)+ mat_procur_day6.quant - 
								CASE 
									WHEN CURRENT_DATE>=date_time_day6 THEN mat_flow_day6.quant*day_turnover_ar[6]
									ELSE sp.material_quant*sp.product_quant*day_turnover_ar[6]
								END
		)
		-
		(CASE 
			WHEN CURRENT_DATE>=date_time_day7 THEN mat_flow_day7.quant*day_turnover_ar[7]
			ELSE sp.material_quant*sp.product_quant*day_turnover_ar[7]
		END)
		+
		(mat_order_day7.quant-mat_procur_day7.quant)
		AS quant_need_day7
		/* ********************************************************* */
		
		
	FROM mat_list
	LEFT JOIN materials AS m ON m.id=mat_list.material_id
	LEFT JOIN specifications AS sp ON sp.material_id=mat_list.material_id

	--balance on begining
	LEFT JOIN 
	   (
		SELECT material_id, SUM(quant) AS quant
		FROM rg_materials_balance(
			in_date_time,
			ARRAY[1],
			'{}',
			ARRAY(SELECT material_id FROM mat_list),
			'{}'
		)
		GROUP BY material_id
	   ) AS bal ON bal.material_id=mat_list.material_id

	LEFT JOIN mat_bal_from_specif ON mat_bal_from_specif.material_id=mat_list.material_id

	--procurement
	LEFT JOIN mat_procur AS mat_procur_day1 ON mat_procur_day1.material_id=mat_list.material_id AND mat_procur_day1.date=date_time_day1
	LEFT JOIN mat_procur AS mat_procur_day2 ON mat_procur_day2.material_id=mat_list.material_id AND mat_procur_day2.date=date_time_day2
	LEFT JOIN mat_procur AS mat_procur_day3 ON mat_procur_day3.material_id=mat_list.material_id AND mat_procur_day3.date=date_time_day3
	LEFT JOIN mat_procur AS mat_procur_day4 ON mat_procur_day4.material_id=mat_list.material_id AND mat_procur_day4.date=date_time_day4
	LEFT JOIN mat_procur AS mat_procur_day5 ON mat_procur_day5.material_id=mat_list.material_id AND mat_procur_day5.date=date_time_day5
	LEFT JOIN mat_procur AS mat_procur_day6 ON mat_procur_day6.material_id=mat_list.material_id AND mat_procur_day6.date=date_time_day6
	LEFT JOIN mat_procur AS mat_procur_day7 ON mat_procur_day7.material_id=mat_list.material_id AND mat_procur_day6.date=date_time_day7

	--flow (sales + disposals)
	LEFT JOIN mat_flow AS mat_flow_day1 ON mat_flow_day1.material_id=mat_list.material_id AND mat_flow_day1.date=date_time_day1
	LEFT JOIN mat_flow AS mat_flow_day2 ON mat_flow_day2.material_id=mat_list.material_id AND mat_flow_day2.date=date_time_day2
	LEFT JOIN mat_flow AS mat_flow_day3 ON mat_flow_day3.material_id=mat_list.material_id AND mat_flow_day3.date=date_time_day3
	LEFT JOIN mat_flow AS mat_flow_day4 ON mat_flow_day4.material_id=mat_list.material_id AND mat_flow_day4.date=date_time_day4
	LEFT JOIN mat_flow AS mat_flow_day5 ON mat_flow_day5.material_id=mat_list.material_id AND mat_flow_day5.date=date_time_day5
	LEFT JOIN mat_flow AS mat_flow_day6 ON mat_flow_day6.material_id=mat_list.material_id AND mat_flow_day6.date=date_time_day6
	LEFT JOIN mat_flow AS mat_flow_day7 ON mat_flow_day7.material_id=mat_list.material_id AND mat_flow_day7.date=date_time_day7

	--order
	LEFT JOIN mat_order AS mat_order_day1 ON mat_order_day1.material_id=mat_list.material_id AND mat_order_day1.date=date_time_day1
	LEFT JOIN mat_order AS mat_order_day2 ON mat_order_day2.material_id=mat_list.material_id AND mat_order_day2.date=date_time_day2
	LEFT JOIN mat_order AS mat_order_day3 ON mat_order_day3.material_id=mat_list.material_id AND mat_order_day3.date=date_time_day3
	LEFT JOIN mat_order AS mat_order_day4 ON mat_order_day4.material_id=mat_list.material_id AND mat_order_day4.date=date_time_day4
	LEFT JOIN mat_order AS mat_order_day5 ON mat_order_day5.material_id=mat_list.material_id AND mat_order_day5.date=date_time_day5
	LEFT JOIN mat_order AS mat_order_day6 ON mat_order_day6.material_id=mat_list.material_id AND mat_order_day6.date=date_time_day6
	LEFT JOIN mat_order AS mat_order_day7 ON mat_order_day7.material_id=mat_list.material_id AND mat_order_day7.date=date_time_day7
	   
	ORDER BY m.name;
END;			
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100 ROWS 1000;
ALTER FUNCTION material_procurement_plan(
	IN in_date_time timestamp without time zone,
	IN in_day_turnover_ar numeric[],
	in_stock_day_count int
) OWNER TO bellagio;
