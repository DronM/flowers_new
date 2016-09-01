-- DROP FUNCTION product_current_cost(integer, integer);

CREATE OR REPLACE FUNCTION product_current_cost(in_store_id integer, in_product_id integer)
  RETURNS numeric AS
$BODY$
DECLARE res numeric(15,2);
BEGIN
	IF (in_product_id IS NULL OR in_product_id=0) THEN
		RAISE EXCEPTION 'Не задан букет!';
	END IF;
	IF (in_store_id IS NULL OR in_store_id=0) THEN
		RAISE EXCEPTION 'Не задан салон!';
	END IF;
	
	SELECT
		SUM( 
		CASE 
			WHEN rg.quant=0 THEN 0
			ELSE rg.cost/rg.quant*sp.material_quant*sp.product_quant
		END) INTO res
	FROM specifications AS sp
	LEFT JOIN rg_material_costs AS rg ON rg.store_id=in_store_id AND rg.material_id=sp.material_id AND rg.date_time=reg_current_balance_time()
	WHERE sp.product_id=in_product_id;

	RETURN res;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION product_current_cost(integer, integer)
  OWNER TO postgres;
