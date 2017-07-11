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

function VariantStorage_Model(options){
	var id = 'VariantStorage_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	options.fields.user_id = new FieldInt("user_id",filed_options);
	options.fields.user_id.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	options.fields.storage_name = new FieldText("storage_name",filed_options);
	options.fields.storage_name.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	options.fields.variant_name = new FieldText("variant_name",filed_options);
	options.fields.variant_name.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.default_variant = new FieldBool("default_variant",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.filter_data = new FieldText("filter_data",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.col_visib_data = new FieldText("col_visib_data",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.col_order_data = new FieldText("col_order_data",filed_options);
	
		VariantStorage_Model.superclass.constructor.call(this,id,options);
}
extend(VariantStorage_Model,ModelXML);

