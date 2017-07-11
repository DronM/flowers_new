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

function DOCExpenceDOCTFExpenceType_Model(options){
	var id = 'DOCExpenceDOCTFExpenceType_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	options.fields.doc_id = new FieldInt("doc_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	options.fields.line_number = new FieldInt("line_number",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Вид затрат';options.fields.expence_type_id = new FieldInt("expence_type_id",filed_options);
	options.fields.expence_type_id.getValidator().setRequired(true);
				
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Комментарий';options.fields.expence_comment = new FieldText("expence_comment",filed_options);
			
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Дата расхода';options.fields.expence_date = new FieldDate("expence_date",filed_options);
	
						
		DOCExpenceDOCTFExpenceType_Model.superclass.constructor.call(this,id,options);
}
extend(DOCExpenceDOCTFExpenceType_Model,ModelXML);

