-- Function: materials_avg_price(timestamp,timestamp,integer, integer)

DROP FUNCTION materials_avg_price(timestamp,timestamp,integer, integer);

CREATE OR REPLACE FUNCTION materials_avg_price(
	IN in_date_time_from timestamp,
	IN in_date_time_to timestamp,
	IN in_store_id integer,
	IN in_group_id integer)
  RETURNS TABLE(
	material_id integer,
	material_descr text,
	material_margin_percent integer,
	price numeric,
	procur_quant numeric,
	procur_cost numeric,
	procur_price numeric,	
	recom_price numeric,
	balance numeric
	) AS
$BODY$
	SELECT
		m.id AS material_id,
		m.name::text AS material_descr,
		m.margin_percent AS material_margin_percent,
		
		COALESCE(m.price,0) AS price,
		
		COALESCE(procur.quant,0) AS procur_quant,
		
		COALESCE(procur.cost,0) AS procur_cost,
		
		CASE
			WHEN COALESCE(procur.cost,0)=0 THEN 0
			ELSE
				ROUND(COALESCE(procur.cost,0)/COALESCE(procur.quant,0),2)
		END AS procur_price,
		
		CASE
			WHEN COALESCE(procur.cost,0)=0 THEN 0
			ELSE
				ROUND(
				ROUND(COALESCE(procur.cost,0)/COALESCE(procur.quant,0),2)+
				ROUND(COALESCE(procur.cost,0)/COALESCE(procur.quant,0),2)*m.margin_percent/100
				,2)
		END AS recom_price,

		CASE
			WHEN COALESCE(procur.cost,0)=0 THEN 0
			ELSE
				COALESCE(m.price,0)-				
				(
				ROUND(
				ROUND(COALESCE(procur.cost,0)/COALESCE(procur.quant,0),2)+
				ROUND(COALESCE(procur.cost,0)/COALESCE(procur.quant,0),2)*m.margin_percent/100
				,2))
		END AS balance
		
		
	FROM materials AS m
	LEFT JOIN (
		SELECT
			ra.material_id,
			sum(ra.quant) AS quant,
			sum(ra.cost) AS cost
		FROM ra_materials AS ra
		LEFT JOIN materials AS sb_m ON sb_m.id=ra.material_id
		WHERE
			ra.date_time BETWEEN $1 AND $2
			AND ra.store_id=$3
			AND ($4 IS NULL
				OR $4=0
				OR (sb_m.material_group_id=$4)
			)
			AND ra.deb=TRUE
			AND ra.doc_type='material_procurement'::doc_types
		GROUP BY ra.material_id
	) As procur ON procur.material_id=m.id
	WHERE
		$4 IS NULL
		OR $4=0
		OR (m.material_group_id=$4)		
	ORDER BY m.name
$BODY$
  LANGUAGE sql VOLATILE
  CALLED ON NULL INPUT
  COST 100
  ROWS 1000;
ALTER FUNCTION materials_avg_price(timestamp,timestamp,integer, integer)
  OWNER TO bellagio;
