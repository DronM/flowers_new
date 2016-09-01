-- Function seq_materials_reprocess(IN in_doc_id integer, in_doc_type doc_types)

-- DROP FUNCTION seq_materials_reprocess(IN in_doc_id integer, in_doc_type doc_types)

CREATE OR REPLACE FUNCTION seq_materials_reprocess(
	IN in_doc_id integer,
	in_doc_type doc_types,
	id_material_ids int[])
  RETURNS void AS
$BODY$
DECLARE
	doc_list RECORD;
BEGIN
	FOR doc_list IN
		SELECT DISTINCT
			doc_log.date_time,
			doc_log.doc_type,
			doc_log.doc_id			
		FROM doc_log
		LEFT JOIN ra_materials AS ra
			ON ra.doc_type=doc_log.doc_type AND ra.doc_id=doc_log.doc_id		
		WHERE 
			(
				(in_doc_id IS NULL OR in_doc_id=0 OR in_doc_type IS NULL)
				OR (doc_log.date_time>
					(SELECT
						sb.date_time
					FROM doc_log AS sb
					WHERE sb.doc_id=in_doc_id
						AND sb.doc_type=in_doc_type
					)
				)
			)
			AND (ra.doc_type IN ('production',
					'material_disposal',
					--'product_disposal',
					'sale'))
			AND
			(
				(id_material_ids IS NULL)
				OR (ARRAY_LENGTH(id_material_ids,1) IS NULL)
				OR (ra.material_id = ANY(id_material_ids))
			)			
		ORDER BY doc_log.date_time
	LOOP

		IF doc_list.doc_type = 'sale' THEN
			UPDATE doc_sales SET processed=true WHERE id=doc_list.doc_id;
		ELSIF doc_list.doc_type = 'production' THEN
			UPDATE doc_productions SET processed=true WHERE id=doc_list.doc_id;
		ELSIF doc_list.doc_type = 'material_disposal' THEN
			UPDATE doc_material_disposals SET processed=true WHERE id=doc_list.doc_id;
		ELSIF doc_list.doc_type = 'product_disposal' THEN
			UPDATE doc_product_disposals SET processed=true WHERE id=doc_list.doc_id;			
		ELSIF doc_list.doc_type = 'material_procurement' THEN
			UPDATE doc_material_procurements SET processed=true WHERE id=doc_list.doc_id;
		END IF;
		
		--RAISE NOTICE 'Перепроведен документ: %',doc_list.date_time;
	END LOOP;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  CALLED ON NULL INPUT
  COST 100;
ALTER FUNCTION seq_materials_reprocess(IN in_doc_id integer, in_doc_type doc_types, id_material_ids int[])
  OWNER TO bellagio;

--SELECT seq_materials_reprocess(116, 'sale',ARRAY[116,175,180,55]);