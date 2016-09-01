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

function DOCClientOrderDOCTFMaterial_Model(options){
	var id = 'DOCClientOrderDOCTFMaterial_Model';
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
	
	var field = new FieldFloat("quant",filed_options);
	
		field.getValidator().setMaxLength('19');
	

	options.fields.quant = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Цена';
	
	var field = new FieldFloat("price",filed_options);
	
		field.getValidator().setMaxLength('15');
	

	options.fields.price = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Сумма';
	
	var field = new FieldFloat("total",filed_options);
	
		field.getValidator().setMaxLength('15');
	

	options.fields.total = field;

		DOCClientOrderDOCTFMaterial_Model.superclass.constructor.call(this,id,options);
}
extend(DOCClientOrderDOCTFMaterial_Model,ModelXML);

