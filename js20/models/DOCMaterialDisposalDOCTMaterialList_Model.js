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

function DOCMaterialDisposalDOCTMaterialList_Model(options){
	var id = 'DOCMaterialDisposalDOCTMaterialList_Model';
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
	options.fields.material_id = new FieldInt("material_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Материал';options.fields.material_descr = new FieldString("material_descr",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Количество';options.fields.quant = new FieldFloat("quant",filed_options);
	
		DOCMaterialDisposalDOCTMaterialList_Model.superclass.constructor.call(this,id,options);
}
extend(DOCMaterialDisposalDOCTMaterialList_Model,ModelXML);

