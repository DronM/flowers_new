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

function Client_Model(options){
	var id = 'Client_Model';
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
	

	options.fields.name_full = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Сотовый телефон';
	
	var field = new FieldString("phone_cel",filed_options);
	
		field.getValidator().setMaxLength('15');
	

	options.fields.phone_cel = field;
			
			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Менеджер';
	
	var field = new FieldInt("manager_id",filed_options);
	

	options.fields.manager_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldDate("create_date",filed_options);
	

	options.fields.create_date = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("email",filed_options);
	
		field.getValidator().setMaxLength('50');
	

	options.fields.email = field;
			
						
		Client_Model.superclass.constructor.call(this,id,options);
}
extend(Client_Model,ModelXML);

