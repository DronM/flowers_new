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

function SupplierList_Model(options){
	var id = 'SupplierList_Model';
	options = options || {};
	
	options.fields = {};
	
			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	
	var field = new FieldInt("id",filed_options);
	

	options.fields.id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Наименование';
	
	var field = new FieldString("name",filed_options);
	
		field.getValidator().setMaxLength('100');
	

	options.fields.name = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Телефон';
	
	var field = new FieldString("tel",filed_options);
	
		field.getValidator().setMaxLength('15');
	

	options.fields.tel = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Email';
	
	var field = new FieldString("email",filed_options);
	
		field.getValidator().setMaxLength('50');
	

	options.fields.email = field;

		SupplierList_Model.superclass.constructor.call(this,id,options);
}
extend(SupplierList_Model,ModelXML);

