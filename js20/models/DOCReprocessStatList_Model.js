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

function DOCReprocessStatList_Model(options){
	var id = 'DOCReprocessStatList_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	filed_options.alias = 'Последовательности';options.fields.doc_sequence = new FieldEnum("doc_sequence",filed_options);
	filed_options.enumValues = 'materials';
				
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Состав идентификаторы';options.fields.seq_contents = new FieldString("seq_contents",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Состав представления';options.fields.seq_contents_descrs = new FieldString("seq_contents_descrs",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Время начала';options.fields.stat_start_time = new FieldDateTime("stat_start_time",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Время обновления';options.fields.stat_update_time = new FieldDateTime("stat_update_time",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Время окончания';options.fields.stat_end_time = new FieldDateTime("stat_end_time",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.done_percent = new FieldInt("done_percent",filed_options);
				
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.stat_time_to_go = new FieldInterval("stat_time_to_go",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.stat_doc_id = new FieldInt("stat_doc_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.stat_doc_type = new FieldEnum("stat_doc_type",filed_options);
	filed_options.enumValues = 'production,product_disposal,material_procurement,material_disposal,sale,expence,doc_client_order';
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.stat_error_message = new FieldText("stat_error_message",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.stat_res = new FieldBool("stat_res",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.stat_user_id = new FieldInt("stat_user_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.stat_user_descr = new FieldString("stat_user_descr",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.viol_date_time = new FieldDateTime("viol_date_time",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.viol_reprocessing = new FieldBool("viol_reprocessing",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.violated = new FieldBool("violated",filed_options);
	
			
		DOCReprocessStatList_Model.superclass.constructor.call(this,id,options);
}
extend(DOCReprocessStatList_Model,ModelXML);

