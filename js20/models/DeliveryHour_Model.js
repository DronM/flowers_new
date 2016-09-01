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

function DeliveryHour_Model(options){
	var id = 'DeliveryHour_Model';
	options = options || {};
	
	options.fields = {};
	
			
				
					
			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	
	var field = new FieldInt("id",filed_options);
	
		field.getValidator().setRequired(true);
	

	options.fields.id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldInt("h_from",filed_options);
	

	options.fields.h_from = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldInt("h_to",filed_options);
	

	options.fields.h_to = field;

		DeliveryHour_Model.superclass.constructor.call(this,id,options);
}
extend(DeliveryHour_Model,ModelXML);

