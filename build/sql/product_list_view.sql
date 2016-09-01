-- View: product_list_view

--DROP VIEW product_list_view;

CREATE OR REPLACE VIEW product_list_view AS 
	SELECT
		products.id,
		products.name,
		products.price AS price_num,
		format_money(products.price) AS price, 
		products.for_sale, 
        CASE products.for_sale
            WHEN true THEN 'Да'::text
            ELSE 'Нет'::text
        END AS for_sale_descr    
	FROM products
	;

ALTER TABLE product_list_view OWNER TO bellagio;

