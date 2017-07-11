-- Function: doc_client_orders_act(in_doc_id int)

--DROP FUNCTION doc_client_orders_act(in_doc_id int);

CREATE OR REPLACE FUNCTION doc_client_orders_act(in_doc_id int)
  RETURNS void AS
$$
$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION doc_client_orders_act(in_doc_id int) OWNER TO bellagio;
