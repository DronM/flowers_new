-- Function: rg_total_recalc()

-- DROP FUNCTION rg_total_recalc();

CREATE OR REPLACE FUNCTION rg_total_recalc()
  RETURNS void AS
$BODY$  
	SELECT rg_total_recalc_materials();
	SELECT rg_total_recalc_products();
	SELECT rg_total_recalc_product_orders();
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION rg_total_recalc()
  OWNER TO bellagio;
