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
	filed_options.alias = 'Код';options.fields.id = new FieldInt("id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Наименование';options.fields.name = new FieldString("name",filed_options);
	options.fields.name.getValidator().setRequired(true);
	options.fields.name.getValidator().setMaxLength('100');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Описание';options.fields.name_full = new FieldText("name_full",filed_options);
	options.fields.name_full.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Розничная цена';options.fields.price = new FieldFloat("price",filed_options);
	options.fields.price.getValidator().setRequired(true);
	options.fields.price.getValidator().setMaxLength('15');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Для продажи';options.fields.for_sale = new FieldBool("for_sale",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Заказывать автоматически';options.fields.make_order = new FieldBool("make_order",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Минимальный остаток';options.fields.min_stock_quant = new FieldFloat("min_stock_quant",filed_options);
	options.fields.min_stock_quant.getValidator().setMaxLength('19');
	
						
									
		Product_Model.superclass.constructor.call(this,id,options);
}
extend(Product_Model,ModelXML);

