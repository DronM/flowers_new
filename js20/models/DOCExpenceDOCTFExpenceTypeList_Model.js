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
	filed_options.alias = '№';options.fields.line_number = new FieldInt("line_number",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	options.fields.login_id = new FieldInt("login_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Вид затрат';options.fields.expence_type_descr = new FieldString("expence_type_descr",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Комментарий';options.fields.expence_comment = new FieldText("expence_comment",filed_options);
			
		DOCExpenceDOCTFExpenceTypeList_Model.superclass.constructor.call(this,id,options);
}
extend(DOCExpenceDOCTFExpenceTypeList_Model,ModelXML);

