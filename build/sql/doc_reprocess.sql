-- Function doc_reprocess(timestamp,timestamp)

-- DROP FUNCTION doc_reprocess(IN in_doc_id integer, in_doc_type doc_types)

CREATE OR REPLACE FUNCTION doc_reprocess(
	timestamp,timestamp)
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
		WHERE (
			($1 IS NULL)
			OR ($1 IS NOT NULL AND doc_log.date_time>=$1)
			)
			AND
			(
			($2 IS NULL)
			OR ($2 IS NOT NULL AND doc_log.date_time<=$2)
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
			--UPDATE doc_material_procurements SET processed=true WHERE id=doc_list.doc_id;
		END IF;
		
		--RAISE NOTICE 'Перепроведен документ: %',doc_list.date_time;
	END LOOP;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  CALLED ON NULL INPUT
  COST 100;
ALTER FUNCTION doc_reprocess(timestamp,timestamp)
  OWNER TO bellagio;

--SELECT doc_reprocess(116, 'sale',ARRAY[116,175,180,55]);