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

function Specification_Model(options){
	var id = 'Specification_Model';
	options = options || {};
	
	options.fields = {};
	
			
				
			
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	filed_options.alias = 'Код';options.fields.id = new FieldInt("id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Продукция';options.fields.product_id = new FieldInt("product_id",filed_options);
	options.fields.product_id.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Материал';options.fields.material_id = new FieldInt("material_id",filed_options);
	options.fields.material_id.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.defValue = true;
	filed_options.alias = 'Кол.продукции';options.fields.product_quant = new FieldFloat("product_quant",filed_options);
	options.fields.product_quant.getValidator().setMaxLength('19');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Кол.материала';options.fields.material_quant = new FieldFloat("material_quant",filed_options);
	options.fields.material_quant.getValidator().setRequired(true);
	options.fields.material_quant.getValidator().setMaxLength('19');
	
			
						
		Specification_Model.superclass.constructor.call(this,id,options);
}
extend(Specification_Model,ModelXML);

