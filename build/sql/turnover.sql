CREATE OR REPLACE FUNCTION rg_material_sales_turnover(IN in_date_time_from timestamp without time zone, IN in_date_time_to timestamp without time zone, IN in_store_id_ar integer[], IN in_material_id_ar integer[])
  RETURNS TABLE(store_id int, material_id int, quant numeric, total numeric(15,2),cost numeric(15,2)) AS
$BODY$
DECLARE
	v_cur_per timestamp;
	v_prev_per timestamp;			
BEGIN
	v_cur_per = rg_period('material_sale'::reg_types, in_date_time_from::timestamp without time zone);
	v_prev_per = v_cur_per-rg_calc_interval('material_sale'::reg_types);

	RETURN QUERY
		SELECT
		store_id,material_id,SUM(quant) AS quant,SUM(total) AS total,SUM(cost) AS cost
		FROM rg_material_sales
		WHERE date_time = v_prev_per;
END;		
$BODY$
LANGUAGE plpgsql VOLATILE STRICT
  COST 100
  ROWS 1000;
ALTER FUNCTION rg_material_sales_turnover(IN in_date_time_from timestamp without time zone, IN in_date_time_to timestamp without time zone, IN in_store_id_ar integer[], IN in_material_id_ar integer[])
  OWNER TO bellagio;
