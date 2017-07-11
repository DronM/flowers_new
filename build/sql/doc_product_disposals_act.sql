-- Function: doc_product_disposals_act(in_doc_id int)

-- DROP FUNCTION doc_product_disposals_act(in_doc_id int);

-- DROP FUNCTION doc_product_disposals_act(in_doc_id int);
 
CREATE OR REPLACE FUNCTION doc_product_disposals_act(in_doc_id integer)
  RETURNS void AS
$$
DECLARE
	v_store_id integer;
	v_date_time timestamp without time zone;
	v_doc_production_id integer;
	v_product_id integer;
	v_price numeric;
	v_production_quant numeric;
	v_processed bool;
	v_doc_operative_processing bool;
BEGIN
	--******************************
	PERFORM doc_product_disposals_del_act(in_doc_id);
	--******************************
	
	--HEAD
	SELECT
		t.store_id,
		t.date_time,
		t.doc_production_id,
		d_p.product_id,
		d_p.price,
		d_p.quant,
		t.processed
	INTO 
		v_store_id,
		v_date_time,
		v_doc_production_id,
		v_product_id,
		v_price,
		v_production_quant,
		v_processed
	FROM doc_product_disposals AS t
	LEFT JOIN doc_productions d_p ON d_p.id=t.doc_production_id
	WHERE t.id=in_doc_id;
	
	IF v_processed THEN
	
		v_doc_operative_processing = doc_operative_processing('product_disposal'::doc_types,in_doc_id);
		
		--*************** DEDUCT Products ***************************
		INSERT INTO ra_products (
			date_time,
			deb,
			doc_type,
			doc_id,
			store_id,
			product_id,
			doc_production_id,
			quant,
			cost)
		VALUES (v_date_time,
			FALSE,
			'product_disposal'::doc_types,
			in_doc_id,
			v_store_id,
			v_product_id,
			v_doc_production_id,
			1,
			v_price
		);			
		--*************** DEDUCT Products ***************************
	
	
		--CHECK Product BALANCE
		IF const_negat_product_balance_restrict_val()=TRUE THEN
			PERFORM process_product_check(
				in_doc_id,
				'product_disposal'::doc_types,	
				v_store_id,
				ARRAY[v_product_id],
				ARRAY[v_doc_production_id],				
				v_doc_operative_processing
			);		
		END IF;

		--********************* MATERIALS **************************
		INSERT INTO ra_materials (
			date_time,
			deb,
			doc_type,
			doc_id,
			store_id,
			material_id,
			quant,cost)
		(SELECT
			v_date_time,
			TRUE,
			'product_disposal'::doc_types,
			in_doc_id,
			v_store_id,
			ra.material_id,
			ra.quant/v_production_quant*1,
			ra.cost/v_production_quant*1
		FROM ra_materials AS ra
		WHERE ra.doc_type='production' AND ra.doc_id=v_doc_production_id
		);
	END IF;	
END;	
$$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_product_disposals_act(in_doc_id int) OWNER TO bellagio;
