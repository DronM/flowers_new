-- Function: doc_client_orders_del_act(in_doc_id int)

-- DROP FUNCTION doc_client_orders_del_act(in_doc_id int);

-- DROP FUNCTION doc_client_orders_del_act(in_doc_id int);
 
CREATE OR REPLACE FUNCTION doc_client_orders_del_act(in_doc_id integer)
  RETURNS void AS
$$
	--******************************
	--SELECT ra_products_remove_acts('sale'::doc_types,in_doc_id);	
	--******************************
$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION doc_client_orders_del_act(in_doc_id int) OWNER TO bellagio;
