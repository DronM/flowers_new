/*Function process_product_check(
		integer,
		doc_types,
		integer,
		int[],
		boolean
	)
*/
/*
DROP FUNCTION proces_material_deduct(
		integer,
		doc_types,
		integer,
		int[],
		int[],
		boolean
);
*/
CREATE OR REPLACE FUNCTION process_product_check(	
	in_doc_id integer,
	in_doc_type doc_types,	
	in_store_id integer,
	in_product_ids int[],
	in_doc_production_ids int[],
	in_operative_processing boolean
	)
  RETURNS void AS
$BODY$
DECLARE
	item_row RECORD;
	v_sql text;
	v_error text;
BEGIN
	IF in_operative_processing THEN
		v_sql = 
		'SELECT
			doct.product_id,
			doct.quant,
			p.name,
			coalesce(b.balance,0) AS balance
		FROM doc_sales_t_products AS doct
		LEFT JOIN (SELECT
					subb.product_id,
					SUM(subb.quant) AS balance,
					subb.doc_production_id
				FROM rg_products_balance(
					ARRAY['|| in_store_id ||'],
					''{'|| array_to_string(in_product_ids,',') ||'}'',
					''{'|| array_to_string(in_doc_production_ids,',') ||'}''
				) AS subb
				GROUP BY subb.product_id,
					subb.doc_production_id
			) AS b
			ON b.product_id=doct.product_id
		LEFT JOIN products AS p ON p.id=doct.product_id
		WHERE doct.doc_id='|| in_doc_id ||' AND coalesce(b.balance,0)-doct.quant<0';			
	ELSE
		v_sql = 
		'SELECT
			doct.product_id,
			doct.quant,
			p.name,
			coalesce(b.balance,0) AS balance
		FROM doc_sales_t_products AS doct
		LEFT JOIN (SELECT
					subb.product_id,
					SUM(subb.quant) AS balance,
					subb.doc_production_id
				FROM rg_products_balance(
					'''|| in_doc_type ||'''::doc_types,
					'|| in_doc_id ||',
					ARRAY['|| in_store_id ||'],
					''{'|| array_to_string(in_product_ids,',') ||'}'',
					''{'|| array_to_string(in_doc_production_ids,',') ||'}''				
				) AS subb
				GROUP BY subb.product_id,subb.doc_production_id
			) AS b
			ON b.product_id=doct.product_id
		LEFT JOIN products AS p ON p.id=doct.product_id
		WHERE doct.doc_id='|| in_doc_id ||' AND coalesce(b.balance,0)-doct.quant<0';					
	END IF;
	
	FOR item_row IN EXECUTE v_sql LOOP
		IF v_error<>'' THEN
			v_error = v_error || ', ';
		END IF;
		v_error = v_error || 'букет: ' || item_row.name || ' остаток: ' || item_row.balance || ' затребовано ' || item_row.quant;
	END LOOP;

	IF v_error<>'' THEN
		RAISE EXCEPTION '%',v_error;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION process_product_check(
		integer,
		doc_types,
		integer,
		int[],
		int[],
		boolean
)
  OWNER TO bellagio;
