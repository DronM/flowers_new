-- View: product_list_view

--DROP VIEW product_list_view;

CREATE OR REPLACE VIEW product_list_view AS 
	SELECT
		products.id,
		products.name,
		products.price,
		products.for_sale
	FROM products
	ORDER BY products.name
	;

ALTER TABLE product_list_view OWNER TO bellagio;

