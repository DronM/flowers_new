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

function ConstantList_Model(options){
	var id = 'ConstantList_Model';
	options = options || {};
	
	options.fields = {};
	
			
				
			
			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	
	var field = new FieldString("id",filed_options);
	

	options.fields.id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("name",filed_options);
	

	options.fields.name = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldText("descr",filed_options);
	

	options.fields.descr = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldText("val_descr",filed_options);
	

	options.fields.val_descr = field;

		ConstantList_Model.superclass.constructor.call(this,id,options);
}
extend(ConstantList_Model,ModelXML);

