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

function DOCReprocessStat_Model(options){
	var id = 'DOCReprocessStat_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	filed_options.alias = 'Последовательности';options.fields.doc_sequence = new FieldEnum("doc_sequence",filed_options);
	filed_options.enumValues = 'materials';
				
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.start_time = new FieldDateTime("start_time",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.update_time = new FieldDateTime("update_time",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.end_time = new FieldDateTime("end_time",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.count_total = new FieldInt("count_total",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.count_done = new FieldInt("count_done",filed_options);
				
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.time_to_go = new FieldInterval("time_to_go",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.doc_id = new FieldInt("doc_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.doc_type = new FieldEnum("doc_type",filed_options);
	filed_options.enumValues = 'production,product_disposal,material_procurement,material_disposal,sale,expence,doc_client_order';
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.error_message = new FieldText("error_message",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.res = new FieldBool("res",filed_options);
	
		DOCReprocessStat_Model.superclass.constructor.call(this,id,options);
}
extend(DOCReprocessStat_Model,ModelXML);

