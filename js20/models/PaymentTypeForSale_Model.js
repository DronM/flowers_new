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

function PaymentTypeForSale_Model(options){
	var id = 'PaymentTypeForSale_Model';
	options = options || {};
	
	options.fields = {};
	
			
				
			
			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	filed_options.alias = 'Код';
	
	var field = new FieldInt("id",filed_options);
	
		field.getValidator().setRequired(true);
	

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
	
	filed_options.alias = 'Вид оплаты из заказа';
	
	var field = new FieldEnum("client_order_payment_type",filed_options);
	filed_options.enumValues = 'cash,bank,yandex,trans_to_card,web_money';
	

	options.fields.client_order_payment_type = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Тип оплаты для ККМ';
	
	var field = new FieldInt("kkm_type_close",filed_options);
	

	options.fields.kkm_type_close = field;

		PaymentTypeForSale_Model.superclass.constructor.call(this,id,options);
}
extend(PaymentTypeForSale_Model,ModelXML);

