-- Function: doc_product_disposals_del_act(in_doc_id int)

-- DROP FUNCTION doc_product_disposals_del_act(in_doc_id int);

-- DROP FUNCTION doc_product_disposals_del_act(in_doc_id int);
 
CREATE OR REPLACE FUNCTION doc_product_disposals_del_act(in_doc_id integer)
  RETURNS void AS
$$
	--******************************
	SELECT ra_products_remove_acts('product_disposal'::doc_types,in_doc_id);	
	SELECT ra_materials_remove_acts('product_disposal'::doc_types,in_doc_id);
	
	--******************************
	
	SELECT seq_viol_materials_set_on_doc('product_disposal'::doc_types,in_doc_id);

$$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION doc_product_disposals_del_act(in_doc_id int) OWNER TO bellagio;
