-- View: delivery_hours_list

--DROP VIEW delivery_hours_list;

CREATE OR REPLACE VIEW delivery_hours_list AS 
	SELECT
		dh.id,
		dh.h_from,
		dh.h_to,
		dh.h_from||'-'||dh.h_to AS descr
	FROM delivery_hours AS dh
	ORDER BY dh.h_from;

ALTER TABLE delivery_hours_list OWNER TO bellagio;

