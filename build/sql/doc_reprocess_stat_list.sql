-- VIEW: doc_reprocess_stat_list

DROP VIEW doc_reprocess_stat_list;

CREATE OR REPLACE VIEW doc_reprocess_stat_list AS
	/*
	SELECT
		d.*,
		s.doc_log_date_time,
		s.date_time,
		s.reprocessing,
		
		CASE WHEN d.count_total IS NOT NULL AND d.count_total>0 THEN
			(d.count_done/d.count_total*100)::int
		ELSE 0::int
		END
		AS done_percent
		 
	FROM doc_reprocess_stat d
	FULL JOIN seq_violations AS s ON s.doc_sequence = d.doc_sequence
	;
	*/
	SELECT
		seq.doc_sequence,
		
		array_agg(seq.doc_type) AS seq_contents,
		array_agg(get_doc_types_descr(seq.doc_type)) AS seq_contents_descrs,
		
		stat.start_time AS stat_start_time,
		stat.update_time AS stat_update_time,
		stat.end_time AS stat_end_time,
		
		CASE WHEN stat.count_total IS NOT NULL AND stat.count_total>0 THEN
			(stat.count_done/stat.count_total*100)::int
		ELSE 0::int
		END
		AS done_percent,
		
		stat.time_to_go AS stat_time_to_go,
		stat.doc_id AS stat_doc_id,
		stat.doc_type AS stat_doc_type,
		stat.error_message AS stat_error_message,
		stat.res AS stat_res,
		stat.user_id AS stat_user_id,
		u.name AS stat_user_descr,
		
		(sv.doc_sequence IS NOT NULL) AS violated,
		sv.date_time AS viol_date_time,
		/*
		CASE
			WHEN sv.doc_type='' THEN
		END AS viol_doc_descr
		*/
		sv.reprocessing AS viol_reprocessing
		
	FROM seq_contents AS seq
	LEFT JOIN seq_violations AS sv ON sv.doc_sequence = seq.doc_sequence
	LEFT JOIN doc_reprocess_stat AS stat ON stat.doc_sequence = seq.doc_sequence
	LEFT JOIN users AS u ON u.id = stat.user_id
	LEFT JOIN doc_log AS dlog ON dlog.date_time = sv.doc_log_date_time
	
	--ALL DOCUMNETS
	
	
	GROUP BY
		seq.doc_sequence,
		stat.start_time,
		stat.update_time,
		stat.end_time,
		stat.count_done,
		stat.count_total,
		stat.time_to_go,
		stat.doc_id,
		stat.doc_type,
		stat.error_message,
		stat.res,
		stat.user_id,
		u.name,
		sv.date_time,
		sv.reprocessing,
		sv.doc_sequence	
	;
		
ALTER VIEW doc_reprocess_stat_list OWNER TO bellagio;

