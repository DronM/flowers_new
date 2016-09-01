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

function DOCProduction_Model(options){
	var id = 'DOCProduction_Model';
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
	
	filed_options.alias = 'Флорист';
	
	var field = new FieldInt("user_id",filed_options);
	

	options.fields.user_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Букет';
	
	var field = new FieldInt("product_id",filed_options);
	
		field.getValidator().setRequired(true);
	

	options.fields.product_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Вид заявки';
	
	var field = new FieldEnum("product_order_type",filed_options);
	filed_options.enumValues = 'sale,disposal,manual';
	

	options.fields.product_order_type = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'По норме';
	
	var field = new FieldBool("on_norm",filed_options);
	

	options.fields.on_norm = field;

			
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
	
	filed_options.alias = 'Комментарий';
	
	var field = new FieldText("florist_comment",filed_options);
	

	options.fields.florist_comment = field;

						
			
			
			
				
				
				
			
		DOCProduction_Model.superclass.constructor.call(this,id,options);
}
extend(DOCProduction_Model,ModelXML);

