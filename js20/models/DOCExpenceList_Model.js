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

function DOCExpenceList_Model(options){
	var id = 'DOCExpenceList_Model';
	options = options || {};
	
	options.fields = {};
	
			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	
	var field = new FieldInt("id",filed_options);
	

	options.fields.id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Номер';
	
	var field = new FieldString("number",filed_options);
	

	options.fields.number = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldDateTime("date_time",filed_options);
	

	options.fields.date_time = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Дата';
	
	var field = new FieldString("date_time_descr",filed_options);
	

	options.fields.date_time_descr = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldInt("store_id",filed_options);
	

	options.fields.store_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Салон';
	
	var field = new FieldString("store_descr",filed_options);
	

	options.fields.store_descr = field;
			
			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldInt("user_id",filed_options);
	

	options.fields.user_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Автор';
	
	var field = new FieldString("user_descr",filed_options);
	

	options.fields.user_descr = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("processed",filed_options);
	

	options.fields.processed = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Сумма';
	
	var field = new FieldFloat("total",filed_options);
	
		field.getValidator().setMaxLength('15');
	

	options.fields.total = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("total_descr",filed_options);
	

	options.fields.total_descr = field;

			
		DOCExpenceList_Model.superclass.constructor.call(this,id,options);
}
extend(DOCExpenceList_Model,ModelXML);

