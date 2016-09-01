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

function DOCMaterialOrderMaterialList_Model(options){
	var id = 'DOCMaterialOrderMaterialList_Model';
	options = options || {};
	
	options.fields = {};
	
			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	
	var field = new FieldInt("id",filed_options);
	

	options.fields.id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldDateTime("date_time",filed_options);
	

	options.fields.date_time = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("date_time_descr",filed_options);
	

	options.fields.date_time_descr = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("number",filed_options);
	

	options.fields.number = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldInt("store_id",filed_options);
	

	options.fields.store_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("store_descr",filed_options);
	

	options.fields.store_descr = field;
			
			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldInt("user_id",filed_options);
	

	options.fields.user_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("user_descr",filed_options);
	

	options.fields.user_descr = field;

			
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
	
	
	var field = new FieldInt("material_group_id",filed_options);
	

	options.fields.material_group_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("material_group_descr",filed_options);
	

	options.fields.material_group_descr = field;
			
			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldFloat("quant",filed_options);
	

	options.fields.quant = field;

			
		DOCMaterialOrderMaterialList_Model.superclass.constructor.call(this,id,options);
}
extend(DOCMaterialOrderMaterialList_Model,ModelXML);

