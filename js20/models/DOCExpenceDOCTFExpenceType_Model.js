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
	
	
	var field = new FieldInt("doc_id",filed_options);
	

	options.fields.doc_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	
	var field = new FieldInt("line_number",filed_options);
	

	options.fields.line_number = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Вид затрат';
	
	var field = new FieldInt("expence_type_id",filed_options);
	
		field.getValidator().setRequired(true);
	

	options.fields.expence_type_id = field;
			
			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Комментарий';
	
	var field = new FieldText("expence_comment",filed_options);
	

	options.fields.expence_comment = field;
		
			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Дата расхода';
	
	var field = new FieldDate("expence_date",filed_options);
	

	options.fields.expence_date = field;

						
		DOCExpenceDOCTFExpenceType_Model.superclass.constructor.call(this,id,options);
}
extend(DOCExpenceDOCTFExpenceType_Model,ModelXML);

