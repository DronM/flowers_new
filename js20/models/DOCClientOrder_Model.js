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

function DOCClientOrder_Model(options){
	var id = 'DOCClientOrder_Model';
	options = options || {};
	
	options.fields = {};
	
			
				
			
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	options.fields.id = new FieldInt("id",filed_options);
	options.fields.id.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.date_time = new FieldDateTime("date_time",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Номер';options.fields.number = new FieldInt("number",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Номер с сайта';options.fields.number_from_site = new FieldString("number_from_site",filed_options);
	options.fields.number_from_site.getValidator().setMaxLength('10');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Проведен';options.fields.processed = new FieldBool("processed",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.delivery_type = new FieldEnum("delivery_type",filed_options);
	filed_options.enumValues = 'courier,by_client';
	options.fields.delivery_type.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.client_name = new FieldString("client_name",filed_options);
	options.fields.client_name.getValidator().setRequired(true);
	options.fields.client_name.getValidator().setMaxLength('200');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.client_tel = new FieldString("client_tel",filed_options);
	options.fields.client_tel.getValidator().setRequired(true);
	options.fields.client_tel.getValidator().setMaxLength('15');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.recipient_type = new FieldEnum("recipient_type",filed_options);
	filed_options.enumValues = 'self,other';
	options.fields.recipient_type.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.recipient_name = new FieldString("recipient_name",filed_options);
	options.fields.recipient_name.getValidator().setMaxLength('200');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.recipient_tel = new FieldString("recipient_tel",filed_options);
	options.fields.recipient_tel.getValidator().setMaxLength('15');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.address = new FieldText("address",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.delivery_date = new FieldDate("delivery_date",filed_options);
	options.fields.delivery_date.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.delivery_hour_id = new FieldInt("delivery_hour_id",filed_options);
	options.fields.delivery_hour_id.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.delivery_comment = new FieldString("delivery_comment",filed_options);
	options.fields.delivery_comment.getValidator().setMaxLength('100');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.card = new FieldBool("card",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.card_text = new FieldText("card_text",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.anonym_gift = new FieldBool("anonym_gift",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.delivery_note_type = new FieldEnum("delivery_note_type",filed_options);
	filed_options.enumValues = 'by_call,by_sms';
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.extra_comment = new FieldText("extra_comment",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.payment_type = new FieldEnum("payment_type",filed_options);
	filed_options.enumValues = 'cash,bank,yandex,trans_to_card,web_money';
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.defValue = true;
	options.fields.client_order_state = new FieldEnum("client_order_state",filed_options);
	filed_options.enumValues = 'to_noone,checked,to_florist,to_courier,closed';
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.defValue = true;
	options.fields.payed = new FieldBool("payed",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Сумма';options.fields.total = new FieldFloat("total",filed_options);
	options.fields.total.getValidator().setMaxLength('15');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Магазин';options.fields.store_id = new FieldInt("store_id",filed_options);
	
			
						
			
						
									
			
			
			
		DOCClientOrder_Model.superclass.constructor.call(this,id,options);
}
extend(DOCClientOrder_Model,ModelXML);

