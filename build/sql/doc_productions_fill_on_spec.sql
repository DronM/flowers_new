-- Function: doc_productions_fill_on_spec(integer, integer, integer, numeric)

-- DROP FUNCTION doc_productions_fill_on_spec(integer, integer, integer, numeric);

CREATE OR REPLACE FUNCTION doc_productions_fill_on_spec(in_login_id integer, in_store_id integer, in_product_id integer, in_product_quant numeric)
  RETURNS void AS
$BODY$
BEGIN	
	DELETE FROM doc_productions_t_tmp_materials WHERE login_id = in_login_id;
	INSERT INTO doc_productions_t_tmp_materials (login_id,material_id,quant,quant_waste, quant_norm)
		(
		SELECT
			in_login_id,
			sp.material_id,
			CASE 
				WHEN (in_product_quant*sp.material_quant/sp.product_quant)>coalesce(b_main.quant,0) THEN b_main.quant
				ELSE in_product_quant*sp.material_quant/sp.product_quant
			END AS quant,
			
			CASE 
				WHEN (in_product_quant*sp.material_quant/sp.product_quant)>coalesce(b_main.quant,0) AND ((in_product_quant*sp.material_quant/sp.product_quant)-coalesce(b_main.quant,0))>coalesce(b_waste.quant,0)
					THEN b_waste.quant
				WHEN (in_product_quant*sp.material_quant/sp.product_quant)>b_main.quant AND ((in_product_quant*sp.material_quant/sp.product_quant)-coalesce(b_main.quant,0))<coalesce(b_waste.quant,0)
					THEN coalesce(b_waste.quant,0) - ((in_product_quant*sp.material_quant/sp.product_quant)-coalesce(b_main.quant,0))
				ELSE 0
			END AS quant_waste,

			in_product_quant*sp.material_quant/sp.product_quant AS quant_norm
			
		FROM specifications AS sp
		LEFT JOIN 
			(SELECT rg_main.material_id, SUM(rg_main.quant) AS quant
			FROM rg_materials_balance(ARRAY[in_store_id],ARRAY['main'::stock_types],ARRAY(SELECT material_id FROM specifications WHERE product_id=in_product_id),'{}') AS rg_main
			GROUP BY rg_main.material_id
			) AS b_main
			ON b_main.material_id=sp.material_id
		LEFT JOIN 
			(SELECT rg_waste.material_id, SUM(rg_waste.quant) AS quant
			FROM rg_materials_balance(ARRAY[in_store_id],ARRAY['waste'::stock_types],ARRAY(SELECT material_id FROM specifications WHERE product_id=in_product_id),'{}') AS rg_waste
			GROUP BY rg_waste.material_id
			) AS b_waste
			ON b_waste.material_id=sp.material_id	
		WHERE sp.product_id=in_product_id
		);
	
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_productions_fill_on_spec(integer, integer, integer, numeric)
  OWNER TO bellagio;
