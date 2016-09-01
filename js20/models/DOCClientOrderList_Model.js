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

function DOCClientOrderList_Model(options){
	var id = 'DOCClientOrderList_Model';
	options = options || {};
	
	options.fields = {};
	
			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	
	var field = new FieldInt("id",filed_options);
	

	options.fields.id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldDateTime("date_time",filed_options);
	

	options.fields.date_time = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("date_time_descr",filed_options);
	

	options.fields.date_time_descr = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("number",filed_options);
	

	options.fields.number = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("delivery_type",filed_options);
	

	options.fields.delivery_type = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("delivery_type_descr",filed_options);
	

	options.fields.delivery_type_descr = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("client_name",filed_options);
	

	options.fields.client_name = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("client_tel",filed_options);
	

	options.fields.client_tel = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("recipient_type",filed_options);
	

	options.fields.recipient_type = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("recipient_type_descr",filed_options);
	

	options.fields.recipient_type_descr = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("recipient_name",filed_options);
	

	options.fields.recipient_name = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("recipient_tel",filed_options);
	

	options.fields.recipient_tel = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldText("address",filed_options);
	

	options.fields.address = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldDate("delivery_date",filed_options);
	

	options.fields.delivery_date = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("delivery_date_descr",filed_options);
	

	options.fields.delivery_date_descr = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldInt("delivery_hour_id",filed_options);
	

	options.fields.delivery_hour_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("delivery_hour_descr",filed_options);
	

	options.fields.delivery_hour_descr = field;

			
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
	
	
	var field = new FieldString("delivery_note_type_descr",filed_options);
	

	options.fields.delivery_note_type_descr = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldText("extra_comment",filed_options);
	

	options.fields.extra_comment = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("payment_type",filed_options);
	

	options.fields.payment_type = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("payment_type_descr",filed_options);
	

	options.fields.payment_type_descr = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("client_order_state",filed_options);
	

	options.fields.client_order_state = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("client_order_state_descr",filed_options);
	

	options.fields.client_order_state_descr = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldFloat("total",filed_options);
	
		field.getValidator().setMaxLength('15');
	

	options.fields.total = field;

		DOCClientOrderList_Model.superclass.constructor.call(this,id,options);
}
extend(DOCClientOrderList_Model,ModelXML);

