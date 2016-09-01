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
	
	
	var field = new FieldInt("id",filed_options);
	
		field.getValidator().setRequired(true);
	

	options.fields.id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldDateTime("date_time",filed_options);
	

	options.fields.date_time = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Номер';
	
	var field = new FieldInt("number",filed_options);
	

	options.fields.number = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Номер с сайта';
	
	var field = new FieldString("number_from_site",filed_options);
	
		field.getValidator().setMaxLength('10');
	

	options.fields.number_from_site = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Проведен';
	
	var field = new FieldBool("processed",filed_options);
	

	options.fields.processed = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldEnum("delivery_type",filed_options);
	filed_options.enumValues = 'courier,by_client';
	
		field.getValidator().setRequired(true);
	

	options.fields.delivery_type = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("client_name",filed_options);
	
		field.getValidator().setRequired(true);
	
		field.getValidator().setMaxLength('200');
	

	options.fields.client_name = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("client_tel",filed_options);
	
		field.getValidator().setRequired(true);
	
		field.getValidator().setMaxLength('15');
	

	options.fields.client_tel = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldEnum("recipient_type",filed_options);
	filed_options.enumValues = 'self,other';
	
		field.getValidator().setRequired(true);
	

	options.fields.recipient_type = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("recipient_name",filed_options);
	
		field.getValidator().setMaxLength('200');
	

	options.fields.recipient_name = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("recipient_tel",filed_options);
	
		field.getValidator().setMaxLength('15');
	

	options.fields.recipient_tel = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldText("address",filed_options);
	

	options.fields.address = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldDate("delivery_date",filed_options);
	
		field.getValidator().setRequired(true);
	

	options.fields.delivery_date = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldInt("delivery_hour_id",filed_options);
	
		field.getValidator().setRequired(true);
	

	options.fields.delivery_hour_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("delivery_comment",filed_options);
	
		field.getValidator().setMaxLength('100');
	

	options.fields.delivery_comment = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldBool("card",filed_options);
	

	options.fields.card = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldText("card_text",filed_options);
	

	options.fields.card_text = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldBool("anonym_gift",filed_options);
	

	options.fields.anonym_gift = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldEnum("delivery_note_type",filed_options);
	filed_options.enumValues = 'by_call,by_sms';
	

	options.fields.delivery_note_type = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldText("extra_comment",filed_options);
	

	options.fields.extra_comment = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldEnum("payment_type",filed_options);
	filed_options.enumValues = 'cash,bank,yandex,trans_to_card,web_money';
	

	options.fields.payment_type = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldEnum("client_order_state",filed_options);
	filed_options.enumValues = 'to_noone,to_florist,to_courier,closed';
	

	options.fields.client_order_state = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldBool("payed",filed_options);
	

	options.fields.payed = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldFloat("total",filed_options);
	
		field.getValidator().setMaxLength('15');
	

	options.fields.total = field;

						
			
						
		DOCClientOrder_Model.superclass.constructor.call(this,id,options);
}
extend(DOCClientOrder_Model,ModelXML);

