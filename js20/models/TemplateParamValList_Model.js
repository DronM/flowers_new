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

function TemplateParamValList_Model(options){
	var id = 'TemplateParamValList_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.param = new FieldString("param",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.val = new FieldText("val",filed_options);
	
		TemplateParamValList_Model.superclass.constructor.call(this,id,options);
}
extend(TemplateParamValList_Model,ModelXML);

