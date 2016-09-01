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

function DeliveryHourList_Model(options){
	var id = 'DeliveryHourList_Model';
	options = options || {};
	
	options.fields = {};
	
			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	
	var field = new FieldInt("id",filed_options);
	

	options.fields.id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldInt("h_from",filed_options);
	

	options.fields.h_from = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldInt("h_to",filed_options);
	

	options.fields.h_to = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("descr",filed_options);
	

	options.fields.descr = field;

		DeliveryHourList_Model.superclass.constructor.call(this,id,options);
}
extend(DeliveryHourList_Model,ModelXML);

