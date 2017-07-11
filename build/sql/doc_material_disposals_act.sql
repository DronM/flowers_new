-- Function: doc_material_disposals_act(in_doc_id int)

-- DROP FUNCTION doc_material_disposals_act(in_doc_id int);

-- DROP FUNCTION doc_material_disposals_act(in_doc_id int);
 
CREATE OR REPLACE FUNCTION doc_material_disposals_act(in_doc_id integer)
  RETURNS void AS
$$
DECLARE
	v_store_id integer;
	v_date_time timestamp without time zone;
	v_operative_processing bool;
	v_processed bool;
BEGIN
	PERFORM doc_material_disposals_del_act(in_doc_id);

	v_operative_processing = doc_operative_processing('material_disposal'::doc_types,in_doc_id);

	SELECT
		store_id,
		date_time,
		processed
	INTO 
		v_store_id,
		v_date_time,
		v_processed
	FROM doc_material_disposals WHERE id=in_doc_id;

	IF v_processed THEN
		-- Списание материалов 
		IF v_operative_processing THEN
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
				'material_disposal'::doc_types,
				in_doc_id,
				v_store_id,
				mat.material_id,
				mat.quant,
				CASE
					WHEN coalesce(b.quant,0)=mat.quant THEN b.cost
					WHEN coalesce(b.quant,0)>0 THEN b.cost/b.quant*mat.quant
				ELSE 0
				END
			FROM doc_material_disposals_t_materials AS mat
			LEFT JOIN (
				SELECT
					bl.material_id,
					SUM(bl.quant) AS quant,
					SUM(bl.cost) AS cost
				FROM rg_materials_balance(
					ARRAY[v_store_id],
					ARRAY(SELECT t.material_id
						FROM doc_material_disposals_t_materials t
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
				'material_disposal'::doc_types,
				in_doc_id,
				v_store_id,
				mat.material_id,
				mat.quant,
				CASE
					WHEN coalesce(b.quant,0)=mat.quant THEN b.cost
					WHEN coalesce(b.quant,0)>0 THEN b.cost/b.quant*mat.quant
				ELSE 0
				END
			FROM doc_material_disposals_t_materials AS mat
			LEFT JOIN (
				SELECT
					bl.material_id,
					SUM(bl.quant) AS quant,
					SUM(bl.cost) AS cost
				FROM rg_materials_balance(
					'material_disposal',
					in_doc_id,
					ARRAY[v_store_id],
					ARRAY(SELECT t.material_id
						FROM doc_material_disposals_t_materials t
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
				'material_disposal'::doc_types,	
				v_store_id,
				v_operative_processing
			);				
		END IF;
	END IF;
END;	
$$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_material_disposals_act(in_doc_id int) OWNER TO bellagio;
