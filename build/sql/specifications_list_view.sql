-- View: specifications_list_view

DROP VIEW specifications_list_view;

CREATE OR REPLACE VIEW specifications_list_view AS 
 SELECT sp.id, sp.product_id, p.name AS product_descr, sp.material_id, 
    m.name AS material_descr, sp.product_quant, sp.material_quant,
    format_money(m.price) AS price_unit,
    format_money(m.price*sp.material_quant*sp.product_quant) AS price_all
    /*
    format_money(
	(SELECT
		SUM(
			CASE 
				WHEN rg_material_costs.quant IS NULL OR rg_material_costs.quant=0 THEN 0
				ELSE
					ROUND(rg_material_costs.cost/rg_material_costs.quant,2)
			END
		
		)
	FROM rg_material_costs
	WHERE rg_material_costs.date_time=reg_current_balance_time() AND rg_material_costs.material_id=sp.material_id
	)
    ) AS cost_unit,
    
    format_money(
	(SELECT
		SUM(
			CASE 
				WHEN rg_material_costs.quant IS NULL OR rg_material_costs.quant=0 THEN 0
				ELSE
					ROUND(rg_material_costs.cost/rg_material_costs.quant,2)
			END
		
		)
	FROM rg_material_costs
	WHERE rg_material_costs.date_time=reg_current_balance_time() AND rg_material_costs.material_id=sp.material_id
	) * sp.product_quant * sp.material_quant
    ) AS cost_all
   */ 
   FROM specifications sp
   LEFT JOIN products p ON p.id = sp.product_id
   LEFT JOIN materials m ON m.id = sp.material_id
  ORDER BY sp.product_id, m.name;

ALTER TABLE specifications_list_view
  OWNER TO bellagio;

