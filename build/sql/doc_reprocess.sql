-- Function doc_reprocess(timestamp,timestamp)

-- DROP FUNCTION doc_reprocess(IN in_doc_id integer, in_doc_type doc_types)

CREATE OR REPLACE FUNCTION doc_reprocess(timestamp,timestamp)
  RETURNS void AS
$BODY$
DECLARE
	doc_list RECORD;
BEGIN

	DELETE FROM doc_reprocess_stat;
	
	INSERT INTO doc_reprocess_stat
		(start_time,update_time,count_total,count_done)
		VALUES
		(now(),now(),
			(SELECT count(*) FROM doc_log t
			WHERE (($1 IS NULL) OR ($1 IS NOT NULL AND t.date_time>=$1)) AND (($2 IS NULL) OR ($2 IS NOT NULL AND t.date_time<=$2))						
			)
		,0)
	;			
	
	FOR doc_list IN
		SELECT 
			doc_log.date_time,
			doc_log.doc_type,
			doc_log.doc_id			
		FROM doc_log
		WHERE
			(
				($1 IS NULL) OR ($1 IS NOT NULL AND doc_log.date_time>=$1)
			)
			AND
			(
				($2 IS NULL) OR ($2 IS NOT NULL AND doc_log.date_time<=$2)
			)			
		ORDER BY doc_log.date_time,doc_log.id
	LOOP

		IF doc_list.doc_type = 'sale' THEN
			PERFORM doc_sales_act(doc_list.doc_id);
		ELSIF doc_list.doc_type = 'production' THEN
			PERFORM doc_productions_act(doc_list.doc_id);
		ELSIF doc_list.doc_type = 'material_disposal' THEN
			PERFORM doc_material_disposals_act(doc_list.doc_id);
		ELSIF doc_list.doc_type = 'product_disposal' THEN
			PERFORM doc_product_disposals_act(doc_list.doc_id);
		ELSIF doc_list.doc_type = 'material_procurement' THEN
			PERFORM doc_material_procurements_act(doc_list.doc_id);
		ELSIF doc_list.doc_type = 'expence' THEN
		END IF;
		
		/*
		UPDATE doc_reprocess_stat
		SET
			time_to_go = ( ((count_total-count_done-1)*EXTRACT(epoch FROM now()-update_time)) || ' seconds')::interval,
			update_time	= now(),
			count_done	= count_done + 1,
			doc_id		= doc_list.doc_id,
			doc_type	= doc_list.doc_type
		;
		*/		
		--RAISE NOTICE 'Перепроведен документ: %',doc_list.date_time;
	END LOOP;
	
	UPDATE doc_reprocess_stat
	SET
		end_time = now(),
		count_done=count_total
	;			
	
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  CALLED ON NULL INPUT
  COST 100;
ALTER FUNCTION doc_reprocess(timestamp,timestamp)
  OWNER TO bellagio;

--SELECT doc_reprocess(116, 'sale',ARRAY[116,175,180,55]);
