-- Function: doc_productions_act(in_doc_id int)

-- DROP FUNCTION doc_productions_act(in_doc_id int);

-- DROP FUNCTION doc_productions_act(in_doc_id int);
 
CREATE OR REPLACE FUNCTION doc_productions_act(in_doc_id integer)
  RETURNS void AS
$$
DECLARE
	v_store_id integer;
	v_date_time timestamp without time zone;
	v_quant numeric;
	v_price numeric;
	v_product_id integer;
	v_processed bool;
	v_doc_operative_processing bool;
BEGIN
	--******************************
	PERFORM doc_productions_del_act(in_doc_id);	
	--******************************
	
	--HEAD
	SELECT
		store_id,
		date_time,
		quant,
		price,
		product_id,
		processed
	INTO 
		v_store_id,
		v_date_time,
		v_quant,
		v_price,
		v_product_id,
		v_processed
	FROM doc_productions WHERE id=in_doc_id;
		

	IF v_processed THEN
		v_doc_operative_processing = doc_operative_processing('production'::doc_types,in_doc_id);
		
		IF v_doc_operative_processing THEN
			-- Списание материалов 
			INSERT INTO ra_materials (
				date_time,
				deb,
				doc_type,
				doc_id,
				store_id,
				material_id,
				quant,
				cost)
			(SELECT
				v_date_time,
				FALSE,
				'production'::doc_types,
				in_doc_id,
				v_store_id,
				mat.material_id,
				mat.quant,
				CASE
					WHEN coalesce(b.quant,0)=mat.quant THEN b.cost
					WHEN coalesce(b.quant,0)>0 THEN b.cost/b.quant*mat.quant
				ELSE 0
				END
			FROM doc_productions_t_materials AS mat
			LEFT JOIN (
				SELECT
					bl.material_id,
					SUM(bl.quant) AS quant,
					SUM(bl.cost) AS cost
				FROM rg_materials_balance(
					ARRAY[v_store_id],
					ARRAY(SELECT t.material_id
						FROM doc_productions_t_materials t
						WHERE t.doc_id=in_doc_id
					)
				) AS bl
				GROUP BY bl.material_id					
			) AS b
			ON b.material_id=mat.material_id
			WHERE mat.doc_id=in_doc_id);
		ELSE
			INSERT INTO ra_materials (
				date_time,
				deb,
				doc_type,
				doc_id,
				store_id,
				material_id,
				quant,
				cost)
			(SELECT
				v_date_time,
				FALSE,
				'production'::doc_types,
				in_doc_id,
				v_store_id,
				mat.material_id,
				mat.quant,
				CASE
					WHEN coalesce(b.quant,0)=mat.quant THEN b.cost
					WHEN coalesce(b.quant,0)>0 THEN b.cost/b.quant*mat.quant
				ELSE 0
				END
			FROM doc_productions_t_materials AS mat
			LEFT JOIN (
				SELECT
					bl.material_id,
					SUM(bl.quant) AS quant,
					SUM(bl.cost) AS cost
				FROM rg_materials_balance(
					'production',
					in_doc_id,
					ARRAY[v_store_id],
					ARRAY(SELECT t.material_id
						FROM doc_productions_t_materials t
						WHERE t.doc_id=in_doc_id
					)
				) AS bl
				GROUP BY bl.material_id					
			) AS b
			ON b.material_id=mat.material_id
			WHERE mat.doc_id=in_doc_id);
	
		END IF;
		
		--CHECK MATERIAL BALANCE
		IF const_negat_material_balance_restrict_val()=TRUE THEN
			PERFORM process_material_check(
				in_doc_id,
				'production'::doc_types,	
				v_store_id,
				v_doc_operative_processing
			);				
		END IF;
		
		--********  ADD NEW Product ******************
		INSERT INTO ra_products (
			date_time,
			deb,
			doc_type,
			doc_id,
			store_id,
			product_id,
			doc_production_id,
			quant,cost)
		VALUES(
			v_date_time,
			TRUE,
			'production',
			in_doc_id,
			v_store_id,
			v_product_id,
			in_doc_id,
			v_quant,
			v_price*v_quant
		);
	
		--********  ADD NEW Product ******************

		--ИТОГИ
		UPDATE doc_productions
		SET
			material_cost = ra.cost,
			material_retail_cost =  ra.retail_cost
		FROM
		(SELECT
			t.cost AS cost,
			m.price*t.quant AS retail_cost
		FROM ra_materials t
		LEFT JOIN materials m ON m.id=t.material_id
		WHERE t.doc_id = in_doc_id AND t.doc_type='production'
		) AS ra
		WHERE doc_productions.id = in_doc_id;
	
	END IF;
END;	
$$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_productions_act(in_doc_id int) OWNER TO bellagio;
