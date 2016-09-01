/*Function process_material_deduct(
		integer,
		timestamp,
		doc_types,
		integer,
		boolean
	)
*/
/*
DROP FUNCTION proces_material_deduct(
		integer,
		timestamp,
		doc_types,
		integer,
		boolean
);
*/
CREATE OR REPLACE FUNCTION process_material_deduct(	
	in_doc_id integer,
	in_doc_date_time timestamp,
	in_doc_type doc_types,	
	in_store_id integer,
	in_operative_processing boolean
	)
  RETURNS void AS
$BODY$
DECLARE
	v_sql text;
	v_material_table text;
BEGIN
	v_material_table = doc_table(in_doc_type)||'_t_materials';
	v_sql='
		INSERT INTO ra_materials
		(   date_time,
			deb,
			doc_type,
			doc_id,
			store_id,
			stock_type,
			material_id,
			doc_procurement_id,
			quant,
			cost
		)
		(
		WITH d AS (SELECT '||in_doc_id||' AS doc)
		SELECT
			'''||in_doc_date_time||''',
			FALSE,
			'''||in_doc_type||''',
			'||in_doc_id||',
			'||in_store_id||',
			''main''::stock_types,
			fifo.material_id,
			fifo.proc_id,
			fifo.quant_to_move,
			fifo.cost_to_move
		FROM 
		(
		SELECT
			sub.material_id,
			sub.proc_date_time,
			sub.proc_id,
			--sub.quant,
			--sub.cost,
			CASE
				WHEN sum(sub.quant) OVER (PARTITION BY sub.material_id ORDER BY sub.proc_date_time)<0 THEN sub.quant
				WHEN sub.quant>sum(sub.quant) OVER (PARTITION BY sub.material_id ORDER BY sub.proc_date_time) THEN 
					sub.quant-sum(sub.quant) OVER (PARTITION BY sub.material_id ORDER BY sub.proc_date_time)
				ELSE
					0
			END AS quant_to_move,

			CASE
			WHEN sub.quant=
				CASE
					WHEN sum(sub.quant) OVER (PARTITION BY sub.material_id ORDER BY sub.proc_date_time)<0 THEN sub.quant
					WHEN sub.quant>sum(sub.quant) OVER (PARTITION BY sub.material_id ORDER BY sub.proc_date_time) THEN 
						sub.quant-sum(sub.quant) OVER (PARTITION BY sub.material_id ORDER BY sub.proc_date_time)
					ELSE
						0
				END
			THEN sub.cost
			ELSE
				ROUND(sub.cost/sub.quant*
				CASE
					WHEN sum(sub.quant) OVER (PARTITION BY sub.material_id ORDER BY sub.proc_date_time)<0 THEN sub.quant
					WHEN sub.quant>sum(sub.quant) OVER (PARTITION BY sub.material_id ORDER BY sub.proc_date_time) THEN 
						sub.quant-sum(sub.quant) OVER (PARTITION BY sub.material_id ORDER BY sub.proc_date_time)
					ELSE
						0
				END
				,2)
			END
			AS cost_to_move
			
		FROM
		(
		(SELECT
					b.material_id,
					b.doc_procurement_id AS proc_id,
					dp.date_time AS proc_date_time,
					b.quant AS quant,
					b.cost AS cost,
					CASE
						WHEN b.quant<>0 THEN ROUND(b.cost/b.quant,2)
						ELSE 0
					END AS price
					
				FROM rg_materials_balance(
					'''||in_doc_type||''',
					(SELECT doc FROM d),
					ARRAY[1],
					ARRAY[''main''::stock_types],
					ARRAY(SELECT material_id FROM '||v_material_table||' WHERE doc_id=(SELECT doc FROM d)),
					''{}''
					) AS b
				LEFT JOIN doc_material_procurements AS dp ON dp.id=b.doc_procurement_id
		)	
		UNION

		(SELECT
			t.material_id,
			0 AS proc_id,
			''1990-01-01'' AS proc_date_time,
			-t.quant AS bal_quant,
			0 AS cost,
			0 AS price
			
		FROM '||v_material_table||' AS t 
		WHERE t.doc_id=(SELECT doc FROM d)
		)

		) AS sub
		) fifo
		WHERE fifo.proc_id>0 AND (fifo.quant_to_move<>0)
		ORDER BY fifo.material_id,fifo.proc_date_time	
		)
	';
	--RAISE 'v_sql=%',v_sql;
	EXECUTE v_sql;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION process_material_deduct(
		integer,
		timestamp,
		doc_types,
		integer,
		boolean
)
  OWNER TO bellagio;
