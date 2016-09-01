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

function DOCMaterialOrderDOCTFMaterialList_Model(options){
	var id = 'DOCMaterialOrderDOCTFMaterialList_Model';
	options = options || {};
	
	options.fields = {};
	
			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	
	var field = new FieldInt("doc_id",filed_options);
	

	options.fields.doc_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	filed_options.alias = '№';
	
	var field = new FieldInt("line_number",filed_options);
	

	options.fields.line_number = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldInt("material_id",filed_options);
	

	options.fields.material_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("material_descr",filed_options);
	

	options.fields.material_descr = field;
			
			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldFloat("quant",filed_options);
	

	options.fields.quant = field;

		DOCMaterialOrderDOCTFMaterialList_Model.superclass.constructor.call(this,id,options);
}
extend(DOCMaterialOrderDOCTFMaterialList_Model,ModelXML);

