--DROP FUNCTION calc_total(in_total_no_disc numeric,in_disc_percent numeric)

CREATE OR REPLACE FUNCTION calc_total(in_total_no_disc numeric,in_disc_percent numeric)
  RETURNS numeric AS
$BODY$
	SELECT in_total_no_disc - ROUND(in_total_no_disc*in_disc_percent/100,2);
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION calc_total(in_total_no_disc numeric,in_disc_percent numeric)
OWNER TO bellagio;
