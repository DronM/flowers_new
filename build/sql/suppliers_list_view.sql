-- View: suppliers_list_view

--DROP VIEW suppliers_list_view;

CREATE OR REPLACE VIEW suppliers_list_view AS 
 SELECT suppliers.id,
    suppliers.name,
	suppliers.tel,
	suppliers.email
   FROM suppliers
  ;

ALTER TABLE suppliers_list_view
  OWNER TO bellagio;
