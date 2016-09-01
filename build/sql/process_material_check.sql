/*Function process_material_check(
		integer,
		doc_types,
		integer,
		boolean
	)
*/
/*
DROP FUNCTION proces_material_deduct(
		integer,
		doc_types,
		integer,
		boolean
);
*/
CREATE OR REPLACE FUNCTION process_material_check(	
	in_doc_id integer,
	in_doc_type doc_types,	
	in_store_id integer,
	in_operative_processing boolean
	)
  RETURNS void AS
$BODY$
DECLARE
	item_row RECORD;
	v_sql text;
	v_error text;
	v_material_table text;
BEGIN
	v_material_table = doc_table(in_doc_type)||'_t_materials';
	IF in_operative_processing THEN
		v_sql = 
		'SELECT
			doct.material_id,
			doct.quant,
			m.name,
			coalesce(b.balance,0) AS balance
		FROM doc_sales_t_materials AS doct
		LEFT JOIN (SELECT
					subb.material_id,
					SUM(subb.quant) AS balance
				FROM rg_materials_balance(
					ARRAY['|| in_store_id ||'],
					ARRAY[''main''::stock_types],
					ARRAY(SELECT t.material_id
						FROM '|| v_material_table ||' t
						WHERE t.doc_id='|| in_doc_id ||'
					),
					''{}''
				) AS subb
				GROUP BY subb.material_id					
			) AS b
			ON b.material_id=doct.material_id
		LEFT JOIN materials AS m ON m.id=doct.material_id
		WHERE doct.doc_id='|| in_doc_id ||' AND coalesce(b.balance,0)-doct.quant<0';			
	ELSE
		v_sql = 
		'SELECT
			doct.material_id,
			doct.quant,
			m.name,
			coalesce(b.balance,0) AS balance
		FROM doc_sales_t_materials AS doct
		LEFT JOIN (SELECT
					subb.material_id,
					SUM(subb.quant) AS balance
				FROM rg_materials_balance(
					'''||in_doc_type||'''::doc_types,
					'|| in_doc_id ||',
					ARRAY['|| in_store_id ||'],
					ARRAY[''main''::stock_types],
					ARRAY(SELECT t.material_id
						FROM '|| v_material_table ||' t
						WHERE t.doc_id='|| in_doc_id ||'
					),
					''{}''
				) AS subb
				GROUP BY subb.material_id					
			) AS b
			ON b.material_id=doct.material_id
		LEFT JOIN materials AS m ON m.id=doct.material_id
		WHERE doct.doc_id='|| in_doc_id ||' AND coalesce(b.balance,0)-doct.quant<0';					
	END IF;
	
	FOR item_row IN EXECUTE v_sql LOOP
		IF v_error<>'' THEN
			v_error = v_error || ', ';
		END IF;
		v_error = v_error || 'материал: ' || item_row.name || ' остаток: ' || item_row.balance || ' затребовано ' || item_row.quant;
	END LOOP;
	
	IF v_error<>'' THEN
		RAISE EXCEPTION '%',v_error;
	END IF;	
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION process_material_check(
		integer,
		doc_types,
		integer,
		boolean
)
  OWNER TO bellagio;
