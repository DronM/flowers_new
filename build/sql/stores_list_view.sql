-- View: stores_list_view

-- DROP VIEW stores_list_view;

CREATE OR REPLACE VIEW stores_list_view AS 
 SELECT stores.id, stores.name
   FROM stores
  ORDER BY stores.name;

ALTER TABLE stores_list_view OWNER TO bellagio;
