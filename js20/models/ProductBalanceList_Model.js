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

function ProductBalanceList_Model(options){
	var id = 'ProductBalanceList_Model';
	options = options || {};
	
	options.fields = {};
	
			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	
	var field = new FieldInt("id",filed_options);
	

	options.fields.id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Продукция';
	
	var field = new FieldString("name",filed_options);
	

	options.fields.name = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Цена';
	
	var field = new FieldFloat("price",filed_options);
	

	options.fields.price = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Сумма';
	
	var field = new FieldFloat("total",filed_options);
	

	options.fields.total = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Кол-во';
	
	var field = new FieldFloat("quant",filed_options);
	

	options.fields.quant = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Кол-во заказано';
	
	var field = new FieldFloat("order_quant",filed_options);
	

	options.fields.order_quant = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldInt("store_id",filed_options);
	

	options.fields.store_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Время изготовления';
	
	var field = new FieldString("after_production_time",filed_options);
	

	options.fields.after_production_time = field;

		ProductBalanceList_Model.superclass.constructor.call(this,id,options);
}
extend(ProductBalanceList_Model,ModelXML);

