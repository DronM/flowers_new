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

function Supplier_Model(options){
	var id = 'Supplier_Model';
	options = options || {};
	
	options.fields = {};
	
			
				
			
			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	filed_options.alias = 'Код';
	
	var field = new FieldInt("id",filed_options);
	

	options.fields.id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Наименование';
	
	var field = new FieldString("name",filed_options);
	
		field.getValidator().setRequired(true);
	
		field.getValidator().setMaxLength('100');
	

	options.fields.name = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Полное наименование';
	
	var field = new FieldText("name_full",filed_options);
	
		field.getValidator().setRequired(true);
	

	options.fields.name_full = field;

			
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

			
		Supplier_Model.superclass.constructor.call(this,id,options);
}
extend(Supplier_Model,ModelXML);

