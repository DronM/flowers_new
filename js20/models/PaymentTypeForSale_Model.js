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
	filed_options.alias = 'Код';options.fields.id = new FieldInt("id",filed_options);
	options.fields.id.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Наименование';options.fields.name = new FieldString("name",filed_options);
	options.fields.name.getValidator().setRequired(true);
	options.fields.name.getValidator().setMaxLength('100');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Вид оплаты из заказа';options.fields.client_order_payment_type = new FieldEnum("client_order_payment_type",filed_options);
	filed_options.enumValues = 'cash,bank,yandex,trans_to_card,web_money';
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Тип оплаты для ККМ';options.fields.kkm_type_close = new FieldInt("kkm_type_close",filed_options);
	
		PaymentTypeForSale_Model.superclass.constructor.call(this,id,options);
}
extend(PaymentTypeForSale_Model,ModelXML);

