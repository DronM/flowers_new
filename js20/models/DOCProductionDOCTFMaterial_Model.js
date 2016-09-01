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

function DOCProductionDOCTFMaterial_Model(options){
	var id = 'DOCProductionDOCTFMaterial_Model';
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
	
	filed_options.alias = 'Материал';
	
	var field = new FieldInt("material_id",filed_options);
	
		field.getValidator().setRequired(true);
	

	options.fields.material_id = field;
			
			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Количество';
	
	var field = new FieldFloat("quant_norm",filed_options);
	
		field.getValidator().setMaxLength('19');
	

	options.fields.quant_norm = field;
			
			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Количество';
	
	var field = new FieldFloat("quant",filed_options);
	
		field.getValidator().setMaxLength('19');
	

	options.fields.quant = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Количество';
	
	var field = new FieldFloat("quant_waste",filed_options);
	
		field.getValidator().setMaxLength('19');
	

	options.fields.quant_waste = field;

		DOCProductionDOCTFMaterial_Model.superclass.constructor.call(this,id,options);
}
extend(DOCProductionDOCTFMaterial_Model,ModelXML);

