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

function TemplateParam_Model(options){
	var id = 'TemplateParam_Model';
	options = options || {};
	
	options.fields = {};
	
			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	
	var field = new FieldInt("id",filed_options);
	

	options.fields.id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("template",filed_options);
	
		field.getValidator().setMaxLength('100');
	

	options.fields.template = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Пользователь';
	
	var field = new FieldInt("user_id",filed_options);
	

	options.fields.user_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("param",filed_options);
	
		field.getValidator().setMaxLength('100');
	

	options.fields.param = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldText("val",filed_options);
	

	options.fields.val = field;

			
																		
		TemplateParam_Model.superclass.constructor.call(this,id,options);
}
extend(TemplateParam_Model,ModelXML);

