-- VIEW: discounts_list

--DROP VIEW discounts_list;

CREATE OR REPLACE VIEW discounts_list AS
	SELECT
		id,
		format('%s (%s %%)',name,percent) As descr
	FROM discounts
	ORDER BY percent
	;
	
ALTER VIEW discounts_list OWNER TO bellagio;
