-- Function: doc_sales_act(in_doc_id int)

-- DROP FUNCTION doc_sales_act(in_doc_id int);

-- DROP FUNCTION doc_sales_act(in_doc_id int);
 
CREATE OR REPLACE FUNCTION doc_sales_act(in_doc_id integer)
  RETURNS void AS
$$
DECLARE
	v_store_id integer;
	v_date_time timestamp without time zone;
	v_doc_operative_processing bool;
	v_processed bool;
BEGIN
	--******************************
	PERFORM doc_sales_del_act(in_doc_id);
	--******************************
	
	--HEAD
	SELECT
		store_id,
		date_time,
		processed
	INTO 
		v_store_id,
		v_date_time,
		v_processed
	FROM doc_sales WHERE id=in_doc_id;
	
	IF v_processed THEN
		v_doc_operative_processing = doc_operative_processing('sale'::doc_types,in_doc_id);			

		-- Списание материалов 
		IF v_doc_operative_processing THEN
			INSERT INTO ra_materials (
				date_time,
				deb,
				doc_type,
				doc_id,
				store_id,
				material_id,
				quant,
				cost,
				retail_cost)
			(SELECT
				v_date_time,
				FALSE,
				'sale'::doc_types,
				in_doc_id,
				v_store_id,
				mat.material_id,
				mat.quant,
				CASE
					WHEN coalesce(b.quant,0)=mat.quant THEN b.cost
					WHEN coalesce(b.quant,0)>0 THEN b.cost/b.quant*mat.quant
				ELSE 0
				END,
				mat.total
			FROM doc_sales_t_materials AS mat
			LEFT JOIN (
				SELECT
					bl.material_id,
					SUM(bl.quant) AS quant,
					SUM(bl.cost) AS cost
				FROM rg_materials_balance(
					ARRAY[v_store_id],
					ARRAY(SELECT t.material_id
						FROM doc_sales_t_materials t
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
				cost,
				retail_cost)
			(SELECT
				v_date_time,
				FALSE,
				'sale'::doc_types,
				in_doc_id,
				v_store_id,
				mat.material_id,
				mat.quant,
				CASE
					WHEN coalesce(b.quant,0)=mat.quant THEN b.cost
					WHEN coalesce(b.quant,0)>0 THEN b.cost/b.quant*mat.quant
				ELSE 0
				END,
				mat.total
			FROM doc_sales_t_materials AS mat
			LEFT JOIN (
				SELECT
					bl.material_id,
					SUM(bl.quant) AS quant,
					SUM(bl.cost) AS cost
				FROM rg_materials_balance(
					'sale',
					in_doc_id,
					ARRAY[v_store_id],
					ARRAY(SELECT t.material_id
						FROM doc_sales_t_materials t
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
				'sale'::doc_types,	
				v_store_id,
				v_doc_operative_processing
			);				
		END IF;
	

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
		(SELECT
			v_date_time,
			FALSE,'sale'::doc_types,
			in_doc_id,
			v_store_id,
			t.product_id,
			t.doc_production_id,
			t.quant,
			SUM(ra_m.cost) AS cost
		FROM doc_sales_t_products AS t
		LEFT JOIN doc_productions AS d_p ON d_p.id=t.doc_production_id
		LEFT JOIN ra_materials AS ra_m ON
			ra_m.doc_id=t.doc_production_id
			AND ra_m.doc_type='production'			
		WHERE t.doc_id=in_doc_id AND t.quant>0
		GROUP BY
			t.product_id,
			t.doc_production_id,
			t.quant			
		);			
		--*************** DEDUCT Products ***************************
	
	
		--CHECK Product BALANCE
		IF const_negat_product_balance_restrict_val()=TRUE THEN
			PERFORM process_product_check(
				in_doc_id,
				'sale'::doc_types,	
				v_store_id,
				ARRAY(SELECT t.product_id
					FROM doc_sales_t_products AS t
					WHERE t.doc_id=in_doc_id
				),
				ARRAY(SELECT t.doc_production_id
					FROM doc_sales_t_products AS t
					WHERE t.doc_id=in_doc_id
				),				
				v_doc_operative_processing
			);		
		END IF;
	
		--calc total
		
		UPDATE doc_sales
		SET
			total = (SELECT coalesce(SUM(t1.total),0)::numeric(15,2) FROM doc_sales_t_products t1 WHERE t1.doc_id=in_doc_id) + 
				(SELECT coalesce(SUM(t2.total),0)::numeric(15,2) FROM doc_sales_t_materials t2 WHERE t2.doc_id=in_doc_id)
		WHERE id=in_doc_id;
		
	END IF;	
END;	
$$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_sales_act(in_doc_id int) OWNER TO bellagio;
