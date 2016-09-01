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
	
	filed_options.alias = 'Код';
	
	var field = new FieldInt("id",filed_options);
	

	options.fields.id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Продукция';
	
	var field = new FieldInt("product_id",filed_options);
	
		field.getValidator().setRequired(true);
	

	options.fields.product_id = field;
									
			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Материал';
	
	var field = new FieldInt("material_id",filed_options);
	
		field.getValidator().setRequired(true);
	

	options.fields.material_id = field;
						
			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Кол.продукции';
	
	var field = new FieldFloat("product_quant",filed_options);
	
		field.getValidator().setMaxLength('19');
	

	options.fields.product_quant = field;
						
			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Кол.материала';
	
	var field = new FieldFloat("material_quant",filed_options);
	
		field.getValidator().setRequired(true);
	
		field.getValidator().setMaxLength('19');
	

	options.fields.material_quant = field;
						
			
						
		Specification_Model.superclass.constructor.call(this,id,options);
}
extend(Specification_Model,ModelXML);

