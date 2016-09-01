--Function rep_balance(timestamp,timestamp,integer)

--DROP FUNCTION rep_balance(timestamp,timestamp,integer);

CREATE OR REPLACE FUNCTION rep_balance(date_from timestamp,date_to timestamp,store_id integer)
RETURNS table(
	period date,
	mon text,
	expence_type_id integer,
	expence_type_descr text,
	total_expences numeric,
	total_sales numeric,
	total_mat_disp numeric,
	total_mat_cost numeric
	) AS
$BODY$
	SELECT
		sub.dt AS period,
		get_month_str(sub.dt)::text||' '||EXTRACT(YEAR FROM sub.dt)::text AS mon,
		sub.expence_type_id,
		sub.expence_type_descr::text,
		sum(sub.total_expences) AS total_expences,
		sum(sub.total_sales) AS total_sales,
		sum(sub.total_mat_disp) AS total_mat_disp,
		sum(sub.total_mat_cost) AS total_mat_cost
	FROM
	(
		(SELECT
			date_trunc('month', exp_t.expence_date)::date AS dt,
			exp_t.expence_type_id AS expence_type_id,
			exp.name::text AS expence_type_descr,
			sum(exp_t.total) AS total_expences,
			0::numeric AS total_sales,
			0::numeric AS total_mat_disp,
			0::numeric AS total_mat_cost
			
		FROM doc_expences_t_expence_types AS exp_t
		LEFT JOIN doc_expences AS exp_h ON exp_h.id=exp_t.doc_id
		LEFT JOIN expence_types AS exp ON exp.id=exp_t.expence_type_id
		WHERE exp_t.expence_date BETWEEN $1 AND $2
			AND ($3=0 OR $3 IS NULL OR ($3=exp_h.store_id))
		GROUP BY
			date_trunc('month', exp_t.expence_date),
			exp_t.expence_type_id,
			exp.name
		)

		UNION ALL

		(SELECT
			date_trunc('month', s.date_time)::date AS dt,
			NULL AS expence_type_id,
			NULL AS expence_type_descr,
			0::numeric AS total_expences,
			sum(s.total) AS total_sales,
			0::numeric AS total_mat_disp,
			0::numeric AS total_mat_cost
			
		FROM doc_sales AS s
		WHERE s.date_time BETWEEN $1 AND $2
			AND ($3=0 OR $3 IS NULL OR ($3=s.store_id))
		GROUP BY date_trunc('month', s.date_time)
		)

		UNION ALL
		
		--продажа материалов
		(SELECT
			date_trunc('month', ra.date_time)::date AS dt,

			NULL AS expence_type_id,
			NULL AS expence_type_descr,
			0::numeric AS total_expences,
			0::numeric AS total_sales,
			0::numeric AS total_mat_disp,
			SUM(ra.cost) total_mat_cost
		FROM ra_materials ra
		WHERE ra.doc_type='sale'
			AND ra.date_time BETWEEN $1 AND $2
			AND ($3=0 OR $3 IS NULL OR ($3=ra.store_id))
		GROUP BY date_trunc('month', ra.date_time)::date
		)
		
		UNION ALL

		--списание материалов
		(SELECT
			date_trunc('month', ra.date_time)::date AS dt,

			NULL AS expence_type_id,
			NULL AS expence_type_descr,
			0::numeric AS total_expences,
			0::numeric AS total_sales,
			SUM(ra.cost) AS total_mat_disp,
			0::numeric AS total_mat_cost
		FROM ra_materials ra
		WHERE ra.doc_type='material_disposal'
			AND ra.date_time BETWEEN $1 AND $2
			AND ($3=0 OR $3 IS NULL OR ($3=ra.store_id))
		GROUP BY date_trunc('month', ra.date_time)::date
		)
		
		UNION ALL
		
		--продажа букетов
		(SELECT
			date_trunc('month', p.date_time)::date AS dt,

			NULL AS expence_type_id,
			NULL AS expence_type_descr,
			0::numeric AS total_expences,
			0::numeric AS total_sales,
			0::numeric AS total_mat_disp,
			SUM(ra.cost) total_mat_cost
		FROM ra_products AS p
		LEFT JOIN (
			SELECT
				ra.doc_id,
				SUM(ra.cost) AS cost
			FROM ra_materials ra
			WHERE ra.doc_type='production'
			GROUP BY ra.doc_id
		) AS ra ON ra.doc_id=p.doc_production_id
		WHERE p.date_time BETWEEN $1 AND $2
			AND p.doc_type='production'
			AND ($3=0 OR $3 IS NULL OR ($3=p.store_id))
		GROUP BY date_trunc('month', p.date_time)::date		
		)
		
		
		/*
		(SELECT
			date_trunc('month', ra.date_time)::date AS dt,
			
			NULL AS expence_type_id,
			NULL AS expence_type_descr,
			0::numeric AS total_expences,
			0::numeric AS total_sales,
				
			sum(CASE
				WHEN ra.doc_type='material_disposal' THEN ra.cost
				ELSE 0
			END) AS total_mat_disp,

			sum(CASE
				WHEN ra.doc_type<>'material_disposal'
					--IN ('production','sale')
					THEN ra.cost
				ELSE 0
			END) AS total_mat_cost
			
		FROM ra_materials AS ra
		WHERE ra.deb=FALSE
			AND ra.date_time BETWEEN $1 AND $2
			AND ($3=0 OR $3 IS NULL OR ($3=ra.store_id))
		GROUP BY date_trunc('month', ra.date_time)
		)
		*/
		
	) AS sub
	GROUP BY
		sub.dt,
		get_month_str(sub.dt),
		sub.expence_type_id,
		sub.expence_type_descr
	ORDER BY sub.dt	
;
$BODY$  
LANGUAGE sql VOLATILE COST 100;
ALTER FUNCTION rep_balance(timestamp,timestamp,integer)
OWNER TO bellagio;
