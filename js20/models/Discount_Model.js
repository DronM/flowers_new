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

function Discount_Model(options){
	var id = 'Discount_Model';
	options = options || {};
	
	options.fields = {};
	
			
				
							
		
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	options.fields.id = new FieldInt("id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Наименование';options.fields.name = new FieldString("name",filed_options);
	options.fields.name.getValidator().setMaxLength('150');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Процент';options.fields.percent = new FieldInt("percent",filed_options);
	
			
																		
		Discount_Model.superclass.constructor.call(this,id,options);
}
extend(Discount_Model,ModelXML);

