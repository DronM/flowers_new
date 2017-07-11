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
	options.fields.id = new FieldInt("id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.template = new FieldText("template",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.param = new FieldText("param",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.param_type = new FieldText("param_type",filed_options);
	
			
																		
		TemplateParam_Model.superclass.constructor.call(this,id,options);
}
extend(TemplateParam_Model,ModelXML);

