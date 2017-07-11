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

function DOCExpenceDOCTExpenceTypeList_Model(options){
	var id = 'DOCExpenceDOCTExpenceTypeList_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	options.fields.view_id = new FieldString("view_id",filed_options);
	options.fields.view_id.getValidator().setMaxLength('32');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	filed_options.alias = '№';options.fields.line_number = new FieldInt("line_number",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.login_id = new FieldInt("login_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.expence_type_id = new FieldInt("expence_type_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Вид затрат';options.fields.expence_type_descr = new FieldString("expence_type_descr",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Комментарий';options.fields.expence_comment = new FieldText("expence_comment",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Сумма';options.fields.total = new FieldFloat("total",filed_options);
	options.fields.total.getValidator().setMaxLength('15');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Дата расхода';options.fields.expence_date = new FieldDate("expence_date",filed_options);
	
		DOCExpenceDOCTExpenceTypeList_Model.superclass.constructor.call(this,id,options);
}
extend(DOCExpenceDOCTExpenceTypeList_Model,ModelXML);

