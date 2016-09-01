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

function DOCExpenceDOCTFExpenceTypeList_Model(options){
	var id = 'DOCExpenceDOCTFExpenceTypeList_Model';
	options = options || {};
	
	options.fields = {};
	
			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	filed_options.alias = '№';
	
	var field = new FieldInt("line_number",filed_options);
	

	options.fields.line_number = field;

			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	
	var field = new FieldInt("login_id",filed_options);
	

	options.fields.login_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Вид затрат';
	
	var field = new FieldString("expence_type_descr",filed_options);
	

	options.fields.expence_type_descr = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Комментарий';
	
	var field = new FieldText("expence_comment",filed_options);
	

	options.fields.expence_comment = field;
		
		DOCExpenceDOCTFExpenceTypeList_Model.superclass.constructor.call(this,id,options);
}
extend(DOCExpenceDOCTFExpenceTypeList_Model,ModelXML);
