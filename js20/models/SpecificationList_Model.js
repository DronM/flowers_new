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

function SpecificationList_Model(options){
	var id = 'SpecificationList_Model';
	options = options || {};
	
	options.fields = {};
	
			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	
	var field = new FieldInt("id",filed_options);
	

	options.fields.id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldInt("product_id",filed_options);
	

	options.fields.product_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("product_descr",filed_options);
	

	options.fields.product_descr = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldInt("material_id",filed_options);
	

	options.fields.material_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("material_descr",filed_options);
	

	options.fields.material_descr = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("product_quant",filed_options);
	

	options.fields.product_quant = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("material_quant",filed_options);
	

	options.fields.material_quant = field;

		SpecificationList_Model.superclass.constructor.call(this,id,options);
}
extend(SpecificationList_Model,ModelXML);

