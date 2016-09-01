
			
			
		
			
				
			
			
			
			
			
		
			
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
						
		
			
			
			
		
			
			
			
			
		
			
			
			
			
			
		
			
			
			
			
			
			
			
			
		
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
		
			
			
			
			
		
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
			
			
			
			
		
			
			
			
			
			
									
			
			
			
			
			
			
						
			
			
		
			
			
			
						
			
			
			
			
			
			
						
			
			
						
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
						
			
			
			
			
						
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
						
			
			
			
			
						
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
			
			
			
						
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
						
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
						
			
			
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
						
			
			
			
			
		
			
			
			
			
			
									
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
						
						
						
						
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
			
			
									
		
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
			
			
		
			
			
		
			
			
			
						
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
						
			
		
			
			
			
			
			
			
		
			
			
			
					
		
			
			
			
						
			
			
			
			
			
			
		
			
			
			
			
		
CREATE OR REPLACE VIEW doc_productions_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_productions_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_productions_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_productions_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_product_disposals_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_product_disposals_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_product_disposals_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_product_disposals_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_procurements_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_procurements_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_procurements_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_procurement'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_procurements_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_to_wastes_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_to_wastes_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_to_wastes_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_to_waste'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_to_wastes_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_disposals_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_disposals_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_disposals_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_disposal'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_disposals_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_sales_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material_sale'::text AS reg_id,
	get_reg_types_descr('material_sale'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_sale'::text AS reg_id,
	get_reg_types_descr('product_sale'::reg_types)::text AS reg_name
;

ALTER VIEW doc_sales_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_sales_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material_sale'::text AS reg_id,
	get_reg_types_descr('material_sale'::reg_types)::text AS reg_name,
	
	TRUE AS deb,
	stores.name||chr(13)||chr(10)||materials.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_material_sales.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_material_sales.cost,0)::text
	 AS facts
	FROM ra_material_sales	
	LEFT JOIN stores ON stores.id=ra_material_sales.store_id	
	LEFT JOIN materials ON materials.id=ra_material_sales.material_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_sale'::text AS reg_id,
	get_reg_types_descr('product_sale'::reg_types)::text AS reg_name,
	
	TRUE AS deb,
	stores.name||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_sales.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_product_sales.cost,0)::text
	 AS facts
	FROM ra_product_sales	
	LEFT JOIN stores ON stores.id=ra_product_sales.store_id	
	LEFT JOIN products ON products.id=ra_product_sales.product_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_sales_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_expences_register_list AS 
;

ALTER VIEW doc_expences_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_expences_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_expences_get_actions(IN in_doc_id int) OWNER TO bellagio;;



-- ******************* update 01/09/2016 16:31:51 ******************

			
			
		
			
				
			
			
			
			
			
		
			
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
						
		
			
			
			
		
			
			
			
			
		
			
			
			
			
			
		
			
			
			
			
			
			
			
			
		
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
		
			
			
			
			
		
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
			
			
			
			
		
			
			
			
			
			
									
			
			
			
			
			
			
						
			
			
		
			
			
			
						
			
			
			
			
			
			
						
			
			
						
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
						
			
			
			
			
						
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
						
			
			
			
			
						
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
			
			
			
						
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
						
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
						
			
			
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
						
			
			
			
			
		
			
			
			
			
			
									
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
						
						
						
						
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
			
			
									
		
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
			
			
		
			
			
		
			
			
			
						
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
						
			
		
			
			
			
			
			
			
		
			
			
			
					
		
			
			
			
						
			
			
			
			
			
			
		
			
			
			
			
		
CREATE OR REPLACE VIEW doc_productions_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_productions_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_productions_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_productions_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_product_disposals_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_product_disposals_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_product_disposals_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_product_disposals_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_procurements_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_procurements_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_procurements_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_procurement'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_procurements_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_to_wastes_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_to_wastes_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_to_wastes_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_to_waste'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_to_wastes_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_disposals_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_disposals_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_disposals_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_disposal'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_disposals_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_sales_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material_sale'::text AS reg_id,
	get_reg_types_descr('material_sale'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_sale'::text AS reg_id,
	get_reg_types_descr('product_sale'::reg_types)::text AS reg_name
;

ALTER VIEW doc_sales_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_sales_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material_sale'::text AS reg_id,
	get_reg_types_descr('material_sale'::reg_types)::text AS reg_name,
	
	TRUE AS deb,
	stores.name||chr(13)||chr(10)||materials.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_material_sales.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_material_sales.cost,0)::text
	 AS facts
	FROM ra_material_sales	
	LEFT JOIN stores ON stores.id=ra_material_sales.store_id	
	LEFT JOIN materials ON materials.id=ra_material_sales.material_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_sale'::text AS reg_id,
	get_reg_types_descr('product_sale'::reg_types)::text AS reg_name,
	
	TRUE AS deb,
	stores.name||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_sales.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_product_sales.cost,0)::text
	 AS facts
	FROM ra_product_sales	
	LEFT JOIN stores ON stores.id=ra_product_sales.store_id	
	LEFT JOIN products ON products.id=ra_product_sales.product_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_sales_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_expences_register_list AS 
;

ALTER VIEW doc_expences_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_expences_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_expences_get_actions(IN in_doc_id int) OWNER TO bellagio;;



-- ******************* update 01/09/2016 16:36:46 ******************

			
			
		
			
				
			
			
			
			
			
		
			
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
						
		
			
			
			
		
			
			
			
			
		
			
			
			
			
			
		
			
			
			
			
			
			
			
			
		
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
		
			
			
			
			
		
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
			
			
			
			
		
			
			
			
			
			
									
			
			
			
			
			
			
						
			
			
		
			
			
			
						
			
			
			
			
			
			
						
			
			
						
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
						
			
			
			
			
						
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
						
			
			
			
			
						
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
			
			
			
						
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
						
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
						
			
			
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
						
			
			
			
			
		
			
			
			
			
			
									
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
						
						
						
						
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
			
			
									
		
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
			
			
		
			
			
		
			
			
			
						
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
						
			
		
			
			
			
			
			
			
		
			
			
			
					
		
			
			
			
						
			
			
			
			
			
			
		
			
			
			
			
		
CREATE OR REPLACE VIEW doc_productions_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_productions_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_productions_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_productions_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_product_disposals_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_product_disposals_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_product_disposals_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_product_disposals_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_procurements_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_procurements_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_procurements_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_procurement'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_procurements_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_to_wastes_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_to_wastes_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_to_wastes_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_to_waste'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_to_wastes_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_disposals_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_disposals_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_disposals_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_disposal'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_disposals_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_sales_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material_sale'::text AS reg_id,
	get_reg_types_descr('material_sale'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_sale'::text AS reg_id,
	get_reg_types_descr('product_sale'::reg_types)::text AS reg_name
;

ALTER VIEW doc_sales_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_sales_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material_sale'::text AS reg_id,
	get_reg_types_descr('material_sale'::reg_types)::text AS reg_name,
	
	TRUE AS deb,
	stores.name||chr(13)||chr(10)||materials.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_material_sales.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_material_sales.cost,0)::text
	 AS facts
	FROM ra_material_sales	
	LEFT JOIN stores ON stores.id=ra_material_sales.store_id	
	LEFT JOIN materials ON materials.id=ra_material_sales.material_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_sale'::text AS reg_id,
	get_reg_types_descr('product_sale'::reg_types)::text AS reg_name,
	
	TRUE AS deb,
	stores.name||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_sales.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_product_sales.cost,0)::text
	 AS facts
	FROM ra_product_sales	
	LEFT JOIN stores ON stores.id=ra_product_sales.store_id	
	LEFT JOIN products ON products.id=ra_product_sales.product_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_sales_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_expences_register_list AS 
;

ALTER VIEW doc_expences_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_expences_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_expences_get_actions(IN in_doc_id int) OWNER TO bellagio;;



-- ******************* update 01/09/2016 16:39:29 ******************

			
			
		
			
				
			
			
			
			
			
		
			
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
						
		
			
			
			
		
			
			
			
			
		
			
			
			
			
			
		
			
			
			
			
			
			
			
			
		
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
		
			
			
			
			
		
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
			
			
			
			
		
			
			
			
			
			
									
			
			
			
			
			
			
						
			
			
		
			
			
			
						
			
			
			
			
			
			
						
			
			
						
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
						
			
			
			
			
						
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
						
			
			
			
			
						
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
			
			
			
						
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
						
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
						
			
			
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
						
			
			
			
			
		
			
			
			
			
			
									
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
						
						
						
						
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
			
			
									
		
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
			
			
		
			
			
		
			
			
			
						
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
						
			
		
			
			
			
			
			
			
		
			
			
			
					
		
			
			
			
						
			
			
			
			
			
			
		
			
			
			
			
		
CREATE OR REPLACE VIEW doc_productions_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_productions_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_productions_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_productions_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_product_disposals_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_product_disposals_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_product_disposals_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_product_disposals_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_procurements_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_procurements_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_procurements_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_procurement'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_procurements_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_to_wastes_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_to_wastes_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_to_wastes_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_to_waste'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_to_wastes_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_disposals_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_disposals_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_disposals_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_disposal'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_disposals_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_sales_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material_sale'::text AS reg_id,
	get_reg_types_descr('material_sale'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_sale'::text AS reg_id,
	get_reg_types_descr('product_sale'::reg_types)::text AS reg_name
;

ALTER VIEW doc_sales_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_sales_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material_sale'::text AS reg_id,
	get_reg_types_descr('material_sale'::reg_types)::text AS reg_name,
	
	TRUE AS deb,
	stores.name||chr(13)||chr(10)||materials.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_material_sales.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_material_sales.cost,0)::text
	 AS facts
	FROM ra_material_sales	
	LEFT JOIN stores ON stores.id=ra_material_sales.store_id	
	LEFT JOIN materials ON materials.id=ra_material_sales.material_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_sale'::text AS reg_id,
	get_reg_types_descr('product_sale'::reg_types)::text AS reg_name,
	
	TRUE AS deb,
	stores.name||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_sales.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_product_sales.cost,0)::text
	 AS facts
	FROM ra_product_sales	
	LEFT JOIN stores ON stores.id=ra_product_sales.store_id	
	LEFT JOIN products ON products.id=ra_product_sales.product_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_sales_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_expences_register_list AS 
;

ALTER VIEW doc_expences_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_expences_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_expences_get_actions(IN in_doc_id int) OWNER TO bellagio;;



-- ******************* update 01/09/2016 16:40:26 ******************

			
			
		
			
				
			
			
			
			
			
		
			
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
						
		
			
			
			
		
			
			
			
			
		
			
			
			
			
			
		
			
			
			
			
			
			
			
			
		
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
		
			
			
			
			
		
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
			
			
			
			
		
			
			
			
			
			
									
			
			
			
			
			
			
						
			
			
		
			
			
			
						
			
			
			
			
			
			
						
			
			
						
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
						
			
			
			
			
						
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
						
			
			
			
			
						
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
			
			
			
						
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
						
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
						
			
			
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
						
			
			
			
			
		
			
			
			
			
			
									
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
						
						
						
						
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
			
			
									
		
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
			
			
		
			
			
		
			
			
			
						
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
						
			
		
			
			
			
			
			
			
		
			
			
			
					
		
			
			
			
						
			
			
			
			
			
			
		
			
			
			
			
		
CREATE OR REPLACE VIEW doc_productions_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_productions_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_productions_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_productions_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_product_disposals_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_product_disposals_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_product_disposals_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_product_disposals_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_procurements_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_procurements_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_procurements_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_procurement'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_procurements_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_to_wastes_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_to_wastes_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_to_wastes_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_to_waste'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_to_wastes_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_disposals_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_disposals_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_disposals_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_disposal'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_disposals_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_sales_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material_sale'::text AS reg_id,
	get_reg_types_descr('material_sale'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_sale'::text AS reg_id,
	get_reg_types_descr('product_sale'::reg_types)::text AS reg_name
;

ALTER VIEW doc_sales_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_sales_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material_sale'::text AS reg_id,
	get_reg_types_descr('material_sale'::reg_types)::text AS reg_name,
	
	TRUE AS deb,
	stores.name||chr(13)||chr(10)||materials.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_material_sales.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_material_sales.cost,0)::text
	 AS facts
	FROM ra_material_sales	
	LEFT JOIN stores ON stores.id=ra_material_sales.store_id	
	LEFT JOIN materials ON materials.id=ra_material_sales.material_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_sale'::text AS reg_id,
	get_reg_types_descr('product_sale'::reg_types)::text AS reg_name,
	
	TRUE AS deb,
	stores.name||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_sales.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_product_sales.cost,0)::text
	 AS facts
	FROM ra_product_sales	
	LEFT JOIN stores ON stores.id=ra_product_sales.store_id	
	LEFT JOIN products ON products.id=ra_product_sales.product_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_sales_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_expences_register_list AS 
;

ALTER VIEW doc_expences_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_expences_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_expences_get_actions(IN in_doc_id int) OWNER TO bellagio;;



-- ******************* update 01/09/2016 16:44:58 ******************

			
			
		
			
				
			
			
			
			
			
		
			
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
						
		
			
			
			
		
			
			
			
			
		
			
			
			
			
			
		
			
			
			
			
			
			
			
			
		
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
		
			
			
			
			
		
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
			
			
			
			
		
			
			
			
			
			
									
			
			
			
			
			
			
						
			
			
		
			
			
			
						
			
			
			
			
			
			
						
			
			
						
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
						
			
			
			
			
						
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
						
			
			
			
			
						
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
			
			
			
						
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
						
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
						
			
			
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
						
			
			
			
			
		
			
			
			
			
			
									
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
						
						
						
						
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
			
			
									
		
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
			
			
		
			
			
		
			
			
			
						
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
						
			
		
			
			
			
			
			
			
		
			
			
			
					
		
			
			
			
						
			
			
			
			
			
			
		
			
			
			
			
		
CREATE OR REPLACE VIEW doc_productions_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_productions_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_productions_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_productions_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_product_disposals_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_product_disposals_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_product_disposals_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_product_disposals_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_procurements_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_procurements_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_procurements_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_procurement'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_procurements_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_to_wastes_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_to_wastes_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_to_wastes_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_to_waste'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_to_wastes_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_disposals_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_disposals_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_disposals_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_disposal'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_disposals_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_sales_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material_sale'::text AS reg_id,
	get_reg_types_descr('material_sale'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_sale'::text AS reg_id,
	get_reg_types_descr('product_sale'::reg_types)::text AS reg_name
;

ALTER VIEW doc_sales_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_sales_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material_sale'::text AS reg_id,
	get_reg_types_descr('material_sale'::reg_types)::text AS reg_name,
	
	TRUE AS deb,
	stores.name||chr(13)||chr(10)||materials.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_material_sales.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_material_sales.cost,0)::text
	 AS facts
	FROM ra_material_sales	
	LEFT JOIN stores ON stores.id=ra_material_sales.store_id	
	LEFT JOIN materials ON materials.id=ra_material_sales.material_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_sale'::text AS reg_id,
	get_reg_types_descr('product_sale'::reg_types)::text AS reg_name,
	
	TRUE AS deb,
	stores.name||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_sales.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_product_sales.cost,0)::text
	 AS facts
	FROM ra_product_sales	
	LEFT JOIN stores ON stores.id=ra_product_sales.store_id	
	LEFT JOIN products ON products.id=ra_product_sales.product_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_sales_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_expences_register_list AS 
;

ALTER VIEW doc_expences_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_expences_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_expences_get_actions(IN in_doc_id int) OWNER TO bellagio;;



-- ******************* update 01/09/2016 16:58:56 ******************

			
			
		
			
				
			
			
			
			
			
		
			
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
						
		
			
			
			
		
			
			
			
			
		
			
			
			
			
			
		
			
			
			
			
			
			
			
			
		
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
		
			
			
			
			
		
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
			
			
			
			
		
			
			
			
			
			
									
			
			
			
			
			
			
						
			
			
		
			
			
			
						
			
			
			
			
			
			
						
			
			
						
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
						
			
			
			
			
						
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
						
			
			
			
			
						
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
			
			
			
						
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
						
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
						
			
			
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
						
			
			
			
			
		
			
			
			
			
			
									
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
						
						
						
						
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
			
			
									
		
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
			
			
		
			
			
		
			
			
			
						
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
						
			
		
			
			
			
			
			
			
		
			
			
			
					
		
			
			
			
						
			
			
			
			
			
			
		
			
			
			
			
		
CREATE OR REPLACE VIEW doc_productions_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_productions_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_productions_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_productions_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_product_disposals_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_product_disposals_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_product_disposals_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_product_disposals_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_procurements_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_procurements_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_procurements_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_procurement'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_procurements_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_to_wastes_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_to_wastes_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_to_wastes_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_to_waste'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_to_wastes_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_disposals_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_disposals_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_disposals_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_disposal'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_disposals_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_sales_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material_sale'::text AS reg_id,
	get_reg_types_descr('material_sale'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_sale'::text AS reg_id,
	get_reg_types_descr('product_sale'::reg_types)::text AS reg_name
;

ALTER VIEW doc_sales_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_sales_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material_sale'::text AS reg_id,
	get_reg_types_descr('material_sale'::reg_types)::text AS reg_name,
	
	TRUE AS deb,
	stores.name||chr(13)||chr(10)||materials.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_material_sales.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_material_sales.cost,0)::text
	 AS facts
	FROM ra_material_sales	
	LEFT JOIN stores ON stores.id=ra_material_sales.store_id	
	LEFT JOIN materials ON materials.id=ra_material_sales.material_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_sale'::text AS reg_id,
	get_reg_types_descr('product_sale'::reg_types)::text AS reg_name,
	
	TRUE AS deb,
	stores.name||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_sales.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_product_sales.cost,0)::text
	 AS facts
	FROM ra_product_sales	
	LEFT JOIN stores ON stores.id=ra_product_sales.store_id	
	LEFT JOIN products ON products.id=ra_product_sales.product_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_sales_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_expences_register_list AS 
;

ALTER VIEW doc_expences_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_expences_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_expences_get_actions(IN in_doc_id int) OWNER TO bellagio;;



-- ******************* update 01/09/2016 17:09:13 ******************

			
			
		
			
				
			
			
			
			
			
		
			
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
						
		
			
			
			
		
			
			
			
			
		
			
			
			
			
			
		
			
			
			
			
			
			
			
			
		
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
		
			
			
			
			
		
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
			
			
			
			
		
			
			
			
			
			
									
			
			
			
			
			
			
						
			
			
		
			
			
			
						
			
			
			
			
			
			
						
			
			
						
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
						
			
			
			
			
						
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
						
			
			
			
			
						
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
			
			
			
						
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
						
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
						
			
			
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
						
			
			
			
			
		
			
			
			
			
			
									
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
						
						
						
						
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
			
			
									
		
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
			
			
		
			
			
		
			
			
			
						
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
						
			
		
			
			
			
			
			
			
		
			
			
			
					
		
			
			
			
						
			
			
			
			
			
			
		
			
			
			
			
		
CREATE OR REPLACE VIEW doc_productions_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_productions_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_productions_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_productions_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_product_disposals_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_product_disposals_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_product_disposals_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_product_disposals_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_procurements_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_procurements_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_procurements_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_procurement'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_procurements_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_to_wastes_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_to_wastes_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_to_wastes_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_to_waste'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_to_wastes_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_disposals_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_disposals_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_disposals_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_disposal'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_disposals_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_sales_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material_sale'::text AS reg_id,
	get_reg_types_descr('material_sale'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_sale'::text AS reg_id,
	get_reg_types_descr('product_sale'::reg_types)::text AS reg_name
;

ALTER VIEW doc_sales_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_sales_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material_sale'::text AS reg_id,
	get_reg_types_descr('material_sale'::reg_types)::text AS reg_name,
	
	TRUE AS deb,
	stores.name||chr(13)||chr(10)||materials.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_material_sales.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_material_sales.cost,0)::text
	 AS facts
	FROM ra_material_sales	
	LEFT JOIN stores ON stores.id=ra_material_sales.store_id	
	LEFT JOIN materials ON materials.id=ra_material_sales.material_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_sale'::text AS reg_id,
	get_reg_types_descr('product_sale'::reg_types)::text AS reg_name,
	
	TRUE AS deb,
	stores.name||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_sales.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_product_sales.cost,0)::text
	 AS facts
	FROM ra_product_sales	
	LEFT JOIN stores ON stores.id=ra_product_sales.store_id	
	LEFT JOIN products ON products.id=ra_product_sales.product_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_sales_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_expences_register_list AS 
;

ALTER VIEW doc_expences_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_expences_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_expences_get_actions(IN in_doc_id int) OWNER TO bellagio;;



-- ******************* update 01/09/2016 17:13:58 ******************

			
			
		
			
				
			
			
			
			
			
		
			
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
						
		
			
			
			
		
			
			
			
			
		
			
			
			
			
			
		
			
			
			
			
			
			
			
			
		
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
		
			
			
			
			
		
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
			
			
			
			
		
			
			
			
			
			
									
			
			
			
			
			
			
						
			
			
		
			
			
			
						
			
			
			
			
			
			
						
			
			
						
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
						
			
			
			
			
						
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
						
			
			
			
			
						
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
			
			
			
						
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
						
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
						
			
			
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
						
			
			
			
			
		
			
			
			
			
			
									
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
						
						
						
						
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
			
			
									
		
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
			
			
		
			
			
		
			
			
			
						
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
						
			
		
			
			
			
			
			
			
		
			
			
			
					
		
			
			
			
						
			
			
			
			
			
			
		
			
			
			
			
		
CREATE OR REPLACE VIEW doc_productions_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_productions_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_productions_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_productions_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_product_disposals_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_product_disposals_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_product_disposals_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_product_disposals_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_procurements_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_procurements_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_procurements_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_procurement'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_procurements_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_to_wastes_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_to_wastes_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_to_wastes_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_to_waste'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_to_wastes_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_disposals_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_disposals_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_disposals_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_disposal'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_disposals_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_sales_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material_sale'::text AS reg_id,
	get_reg_types_descr('material_sale'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_sale'::text AS reg_id,
	get_reg_types_descr('product_sale'::reg_types)::text AS reg_name
;

ALTER VIEW doc_sales_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_sales_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material_sale'::text AS reg_id,
	get_reg_types_descr('material_sale'::reg_types)::text AS reg_name,
	
	TRUE AS deb,
	stores.name||chr(13)||chr(10)||materials.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_material_sales.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_material_sales.cost,0)::text
	 AS facts
	FROM ra_material_sales	
	LEFT JOIN stores ON stores.id=ra_material_sales.store_id	
	LEFT JOIN materials ON materials.id=ra_material_sales.material_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_sale'::text AS reg_id,
	get_reg_types_descr('product_sale'::reg_types)::text AS reg_name,
	
	TRUE AS deb,
	stores.name||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_sales.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_product_sales.cost,0)::text
	 AS facts
	FROM ra_product_sales	
	LEFT JOIN stores ON stores.id=ra_product_sales.store_id	
	LEFT JOIN products ON products.id=ra_product_sales.product_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_sales_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_expences_register_list AS 
;

ALTER VIEW doc_expences_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_expences_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_expences_get_actions(IN in_doc_id int) OWNER TO bellagio;;



-- ******************* update 01/09/2016 17:19:17 ******************

			
			
		
			
				
			
			
			
			
			
		
			
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
						
		
			
			
			
		
			
			
			
			
		
			
			
			
			
			
		
			
			
			
			
			
			
			
			
		
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
		
			
			
			
			
		
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
			
			
			
			
		
			
			
			
			
			
									
			
			
			
			
			
			
						
			
			
		
			
			
			
						
			
			
			
			
			
			
						
			
			
						
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
						
			
			
			
			
						
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
						
			
			
			
			
						
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
			
			
			
						
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
						
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
						
			
			
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
						
			
			
			
			
		
			
			
			
			
			
									
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
						
						
						
						
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
			
			
									
		
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
			
			
		
			
			
		
			
			
			
						
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
						
			
		
			
			
			
			
			
			
		
			
			
			
					
		
			
			
			
						
			
			
			
			
			
			
		
			
			
			
			
		
CREATE OR REPLACE VIEW doc_productions_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_productions_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_productions_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_productions_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_product_disposals_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_product_disposals_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_product_disposals_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_product_disposals_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_procurements_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_procurements_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_procurements_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_procurement'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_procurements_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_to_wastes_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_to_wastes_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_to_wastes_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_to_waste'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_to_wastes_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_disposals_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_disposals_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_disposals_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_disposal'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_disposals_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_sales_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material_sale'::text AS reg_id,
	get_reg_types_descr('material_sale'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_sale'::text AS reg_id,
	get_reg_types_descr('product_sale'::reg_types)::text AS reg_name
;

ALTER VIEW doc_sales_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_sales_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material_sale'::text AS reg_id,
	get_reg_types_descr('material_sale'::reg_types)::text AS reg_name,
	
	TRUE AS deb,
	stores.name||chr(13)||chr(10)||materials.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_material_sales.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_material_sales.cost,0)::text
	 AS facts
	FROM ra_material_sales	
	LEFT JOIN stores ON stores.id=ra_material_sales.store_id	
	LEFT JOIN materials ON materials.id=ra_material_sales.material_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_sale'::text AS reg_id,
	get_reg_types_descr('product_sale'::reg_types)::text AS reg_name,
	
	TRUE AS deb,
	stores.name||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_sales.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_product_sales.cost,0)::text
	 AS facts
	FROM ra_product_sales	
	LEFT JOIN stores ON stores.id=ra_product_sales.store_id	
	LEFT JOIN products ON products.id=ra_product_sales.product_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_sales_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_expences_register_list AS 
;

ALTER VIEW doc_expences_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_expences_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_expences_get_actions(IN in_doc_id int) OWNER TO bellagio;;



-- ******************* update 01/09/2016 17:20:29 ******************

			
			
		
			
				
			
			
			
			
			
		
			
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
						
		
			
			
			
		
			
			
			
			
		
			
			
			
			
			
		
			
			
			
			
			
			
			
			
		
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
		
			
			
			
			
		
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
			
			
			
			
		
			
			
			
			
			
									
			
			
			
			
			
			
						
			
			
		
			
			
			
						
			
			
			
			
			
			
						
			
			
						
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
						
			
			
			
			
						
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
						
			
			
			
			
						
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
			
			
			
						
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
						
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
						
			
			
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
						
			
			
			
			
		
			
			
			
			
			
									
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
		
			
			
			
						
			
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
		
			
			
			
						
			
			
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
						
						
						
						
			
			
		
			
			
			
			
			
			
						
			
						
			
			
			
			
			
			
			
		
			
			
			
						
			
			
			
			
			
									
		
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
						
			
			
			
			
			
									
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
			
			
			
			
			
			
		
			
			
		
			
			
			
						
			
			
			
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
			
			
			
		
			
			
			
			
			
						
			
			
			
						
			
		
			
			
			
			
			
			
		
			
			
			
					
		
			
			
			
						
			
			
			
			
			
			
		
			
			
			
			
		
CREATE OR REPLACE VIEW doc_productions_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_productions_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_productions_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='production'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_productions_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_product_disposals_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_product_disposals_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_product_disposals_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='product_disposal'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_product_disposals_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_procurements_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_procurements_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_procurements_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_procurement'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_procurements_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_to_wastes_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_to_wastes_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_to_wastes_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_to_waste'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_to_wastes_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_material_disposals_register_list AS 

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
;

ALTER VIEW doc_material_disposals_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_material_disposals_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='material_disposal'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_material_disposals_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_sales_register_list AS 

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'material_sale'::text AS reg_id,
	get_reg_types_descr('material_sale'::reg_types)::text AS reg_name
UNION ALL
SELECT
	'product_sale'::text AS reg_id,
	get_reg_types_descr('product_sale'::reg_types)::text AS reg_name
;

ALTER VIEW doc_sales_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_sales_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY

SELECT
	'product'::text AS reg_id,
	get_reg_types_descr('product'::reg_types)::text AS reg_name,
	ra_products.deb,
	stores.name||chr(13)||chr(10)||products.name||chr(13)||chr(10)||
			doc_descr('production'::doc_types,doc_productions.number::text,doc_productions.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_products.quant,0)::text
	 AS facts
	FROM ra_products	
	LEFT JOIN stores ON stores.id=ra_products.store_id	
	LEFT JOIN products ON products.id=ra_products.product_id	
	LEFT JOIN doc_productions ON doc_productions.id=ra_products.doc_production_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_order'::text AS reg_id,
	get_reg_types_descr('product_order'::reg_types)::text AS reg_name,
	ra_product_orders.deb,
	stores.name||chr(13)||chr(10)||
			get_product_order_types_descr(product_order_type)
			||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_orders.quant,0)::text
	 AS facts
	FROM ra_product_orders	
	LEFT JOIN stores ON stores.id=ra_product_orders.store_id	
	LEFT JOIN products ON products.id=ra_product_orders.product_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material'::text AS reg_id,
	get_reg_types_descr('material'::reg_types)::text AS reg_name,
	ra_materials.deb,
	stores.name||chr(13)||chr(10)||
			get_stock_types_descr(stock_type)
			||chr(13)||chr(10)||materials.name||chr(13)||chr(10)||
			doc_descr('material_procurement'::doc_types,doc_material_procurements.number::text,doc_material_procurements.date_time)
			 AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_materials.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_materials.cost,0)::text
	 AS facts
	FROM ra_materials	
	LEFT JOIN stores ON stores.id=ra_materials.store_id	
	LEFT JOIN materials ON materials.id=ra_materials.material_id	
	LEFT JOIN doc_material_procurements ON doc_material_procurements.id=ra_materials.doc_procurement_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'material_sale'::text AS reg_id,
	get_reg_types_descr('material_sale'::reg_types)::text AS reg_name,
	
	TRUE AS deb,
	stores.name||chr(13)||chr(10)||materials.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_material_sales.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_material_sales.cost,0)::text
	 AS facts
	FROM ra_material_sales	
	LEFT JOIN stores ON stores.id=ra_material_sales.store_id	
	LEFT JOIN materials ON materials.id=ra_material_sales.material_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
UNION ALL
SELECT
	'product_sale'::text AS reg_id,
	get_reg_types_descr('product_sale'::reg_types)::text AS reg_name,
	
	TRUE AS deb,
	stores.name||chr(13)||chr(10)||products.name AS dimensions,
	'' AS attributes,
	
		COALESCE(ra_product_sales.quant,0)::text
	||chr(13)||chr(10)||
		COALESCE(ra_product_sales.cost,0)::text
	 AS facts
	FROM ra_product_sales	
	LEFT JOIN stores ON stores.id=ra_product_sales.store_id	
	LEFT JOIN products ON products.id=ra_product_sales.product_id
	WHERE doc_type='sale'::doc_types AND doc_id=in_doc_id	
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_sales_get_actions(IN in_doc_id int) OWNER TO bellagio;;

CREATE OR REPLACE VIEW doc_expences_register_list AS 
;

ALTER VIEW doc_expences_register_list OWNER TO bellagio;


--doc actions

CREATE OR REPLACE FUNCTION doc_expences_get_actions(IN in_doc_id int)
  RETURNS TABLE(reg_id text, reg_name text, deb boolean, dimensions text, attributes text, facts text) AS
$BODY$
BEGIN
RETURN QUERY
;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE COST 100;
  
ALTER FUNCTION doc_expences_get_actions(IN in_doc_id int) OWNER TO bellagio;;
