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

function ClientDialog_Model(options){
	var id = 'ClientDialog_Model';
	options = options || {};
	
	options.fields = {};
	
			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	
	var field = new FieldInt("id",filed_options);
	

	options.fields.id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
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
	
	
	var field = new FieldString("phone_cel",filed_options);
	

	options.fields.phone_cel = field;

		ClientDialog_Model.superclass.constructor.call(this,id,options);
}
extend(ClientDialog_Model,ModelXML);

