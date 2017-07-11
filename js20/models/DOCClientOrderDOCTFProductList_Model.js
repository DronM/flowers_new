/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
 * @requires core/extend.js
 * @requires core/ModelXML.js
*/

/* constructor
@param string id
@param object options{

}
*/

function DOCClientOrderDOCTFProductList_Model(options){
	var id = 'DOCClientOrderDOCTFProductList_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	options.fields.doc_id = new FieldInt("doc_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	filed_options.alias = '№';options.fields.line_number = new FieldInt("line_number",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.product_id = new FieldInt("product_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.product_descr = new FieldString("product_descr",filed_options);
				
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.quant = new FieldFloat("quant",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.price = new FieldFloat("price",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.disc_percent = new FieldFloat("disc_percent",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.price_no_disc = new FieldFloat("price_no_disc",filed_options);
				
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.total = new FieldFloat("total",filed_options);
	
		DOCClientOrderDOCTFProductList_Model.superclass.constructor.call(this,id,options);
}
extend(DOCClientOrderDOCTFProductList_Model,ModelXML);

