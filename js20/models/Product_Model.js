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

function Product_Model(options){
	var id = 'Product_Model';
	options = options || {};
	
	options.fields = {};
	
			
				
			
			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	filed_options.alias = 'Код';
	
	var field = new FieldInt("id",filed_options);
	

	options.fields.id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Наименование';
	
	var field = new FieldString("name",filed_options);
	
		field.getValidator().setRequired(true);
	
		field.getValidator().setMaxLength('100');
	

	options.fields.name = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Описание';
	
	var field = new FieldText("name_full",filed_options);
	
		field.getValidator().setRequired(true);
	

	options.fields.name_full = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Розничная цена';
	
	var field = new FieldFloat("price",filed_options);
	
		field.getValidator().setRequired(true);
	
		field.getValidator().setMaxLength('15');
	

	options.fields.price = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Для продажи';
	
	var field = new FieldBool("for_sale",filed_options);
	

	options.fields.for_sale = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Заказывать автоматически';
	
	var field = new FieldBool("make_order",filed_options);
	

	options.fields.make_order = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Минимальный остаток';
	
	var field = new FieldFloat("min_stock_quant",filed_options);
	
		field.getValidator().setMaxLength('19');
	

	options.fields.min_stock_quant = field;

						
									
		Product_Model.superclass.constructor.call(this,id,options);
}
extend(Product_Model,ModelXML);

