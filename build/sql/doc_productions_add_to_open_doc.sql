-- Function: doc_productions_add_to_open_doc(in_login_id int,in_product_id int,in_material_id int)

--DROP FUNCTION doc_productions_add_to_open_doc(in_login_id int,in_product_id int,in_material_id int);

CREATE OR REPLACE FUNCTION doc_productions_add_to_open_doc(in_login_id int,in_product_id int,in_material_id int)
  RETURNS VOID AS
$BODY$
BEGIN
	UPDATE doc_productions_t_tmp_materials
		SET quant = quant + 1
	WHERE login_id=in_login_id AND material_id=in_material_id;
	
	IF NOT FOUND THEN		
		WITH mat_on_norm AS (
			SELECT
				material_quant*product_quant AS quant
			FROM specifications
			WHERE product_id=in_product_id AND material_id=in_material_id
			)
		INSERT INTO doc_productions_t_tmp_materials
		(login_id,material_id,quant_norm,quant,quant_waste)
		VALUES (in_login_id,in_material_id,COALESCE((SELECT quant FROM mat_on_norm),0),
			COALESCE(
			(SELECT CASE
					WHEN quant=0 THEN 1
					ELSE quant
				END
			FROM mat_on_norm
			),1),
			0);
	END IF;
END
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
ALTER FUNCTION doc_productions_add_to_open_doc(in_login_id int,in_product_id int,in_material_id int)
  OWNER TO bellagio;
