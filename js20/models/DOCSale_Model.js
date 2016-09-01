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

function DOCSale_Model(options){
	var id = 'DOCSale_Model';
	options = options || {};
	
	options.fields = {};
	
			
				
			
			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	
	var field = new FieldInt("id",filed_options);
	

	options.fields.id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Дата';
	
	var field = new FieldDateTime("date_time",filed_options);
	
		field.getValidator().setRequired(true);
	

	options.fields.date_time = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Номер';
	
	var field = new FieldInt("number",filed_options);
	

	options.fields.number = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Проведен';
	
	var field = new FieldBool("processed",filed_options);
	

	options.fields.processed = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Магазин';
	
	var field = new FieldInt("store_id",filed_options);
	

	options.fields.store_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Продавец';
	
	var field = new FieldInt("user_id",filed_options);
	

	options.fields.user_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Магазин';
	
	var field = new FieldInt("payment_type_for_sale_id",filed_options);
	

	options.fields.payment_type_for_sale_id = field;
			
			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Сумма';
	
	var field = new FieldFloat("total",filed_options);
	
		field.getValidator().setMaxLength('15');
	

	options.fields.total = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Себест.материалов';
	
	var field = new FieldFloat("total_material_cost",filed_options);
	
		field.getValidator().setMaxLength('15');
	

	options.fields.total_material_cost = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Себест.продукции';
	
	var field = new FieldFloat("total_product_cost",filed_options);
	
		field.getValidator().setMaxLength('15');
	

	options.fields.total_product_cost = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Клиент';
	
	var field = new FieldInt("client_id",filed_options);
	

	options.fields.client_id = field;

						
			
			
			
				
				
				
				
				
									
		DOCSale_Model.superclass.constructor.call(this,id,options);
}
extend(DOCSale_Model,ModelXML);

