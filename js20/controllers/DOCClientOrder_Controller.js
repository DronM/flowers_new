/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
 * @requires core/extend.js
 * @requires core/ControllerDb.js
*/

/* constructor
@param string id
@param object options{

}
*/

function DOCClientOrder_Controller(app,options){
	options = options || {};
	options.listModelId = "DOCClientOrderList_Model";
	options.objModelId = "DOCClientOrderList_Model";
	DOCClientOrder_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.add_get_print();
	this.add_before_open();
	this.add_get_actions();
		
}
extend(DOCClientOrder_Controller,ControllerDb);

			DOCClientOrder_Controller.prototype.addInsert = function(){
	DOCClientOrder_Controller.superclass.addInsert.call(this);
	var field;
	var options;
	
	var pm = this.getInsert();
	options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	options = {};
	
	var field = new FieldDateTime("date_time",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Номер";
	var field = new FieldInt("number",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Номер с сайта";
	var field = new FieldString("number_from_site",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Проведен";
	var field = new FieldBool("processed",options);
	
	pm.addField(field);
	
	options = {};
	options.required = true;	
	options.enumValues = 'courier,by_client';
	field = new FieldEnum("delivery_type",options);
	
	pm.addField(field);
	
	options = {};
	options.required = true;
	var field = new FieldString("client_name",options);
	
	pm.addField(field);
	
	options = {};
	options.required = true;
	var field = new FieldString("client_tel",options);
	
	pm.addField(field);
	
	options = {};
	options.required = true;	
	options.enumValues = 'self,other';
	field = new FieldEnum("recipient_type",options);
	
	pm.addField(field);
	
	options = {};
	
	var field = new FieldString("recipient_name",options);
	
	pm.addField(field);
	
	options = {};
	
	var field = new FieldString("recipient_tel",options);
	
	pm.addField(field);
	
	options = {};
	
	var field = new FieldText("address",options);
	
	pm.addField(field);
	
	options = {};
	options.required = true;
	var field = new FieldDate("delivery_date",options);
	
	pm.addField(field);
	
	options = {};
	options.required = true;
	var field = new FieldInt("delivery_hour_id",options);
	
	pm.addField(field);
	
	options = {};
	
	var field = new FieldString("delivery_comment",options);
	
	pm.addField(field);
	
	options = {};
	
	var field = new FieldBool("card",options);
	
	pm.addField(field);
	
	options = {};
	
	var field = new FieldText("card_text",options);
	
	pm.addField(field);
	
	options = {};
	
	var field = new FieldBool("anonym_gift",options);
	
	pm.addField(field);
	
	options = {};
		
	options.enumValues = 'by_call,by_sms';
	field = new FieldEnum("delivery_note_type",options);
	
	pm.addField(field);
	
	options = {};
	
	var field = new FieldText("extra_comment",options);
	
	pm.addField(field);
	
	options = {};
		
	options.enumValues = 'cash,bank,yandex,trans_to_card,web_money';
	field = new FieldEnum("payment_type",options);
	
	pm.addField(field);
	
	options = {};
		
	options.enumValues = 'to_noone,to_florist,to_courier,closed';
	field = new FieldEnum("client_order_state",options);
	
	pm.addField(field);
	
	options = {};
	
	var field = new FieldBool("payed",options);
	
	pm.addField(field);
	
	options = {};
	
	var field = new FieldFloat("total",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			DOCClientOrder_Controller.prototype.addUpdate = function(){
	DOCClientOrder_Controller.superclass.addUpdate.call(this);
	var field;
	var options;	
	var pm = this.getUpdate();
	options = {"sendNulls":true};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	options = {"sendNulls":true};
	
	var field = new FieldDateTime("date_time",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Номер";
	var field = new FieldInt("number",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Номер с сайта";
	var field = new FieldString("number_from_site",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Проведен";
	var field = new FieldBool("processed",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
		
	options.enumValues = 'courier,by_client';
	options.enumValues+= (options.enumValues=='')? '':',';
	options.enumValues+= 'null';
	
	field = new FieldEnum("delivery_type",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	
	var field = new FieldString("client_name",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	
	var field = new FieldString("client_tel",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
		
	options.enumValues = 'self,other';
	options.enumValues+= (options.enumValues=='')? '':',';
	options.enumValues+= 'null';
	
	field = new FieldEnum("recipient_type",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	
	var field = new FieldString("recipient_name",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	
	var field = new FieldString("recipient_tel",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	
	var field = new FieldText("address",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	
	var field = new FieldDate("delivery_date",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	
	var field = new FieldInt("delivery_hour_id",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	
	var field = new FieldString("delivery_comment",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	
	var field = new FieldBool("card",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	
	var field = new FieldText("card_text",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	
	var field = new FieldBool("anonym_gift",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
		
	options.enumValues = 'by_call,by_sms';
	
	field = new FieldEnum("delivery_note_type",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	
	var field = new FieldText("extra_comment",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
		
	options.enumValues = 'cash,bank,yandex,trans_to_card,web_money';
	
	field = new FieldEnum("payment_type",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
		
	options.enumValues = 'to_noone,to_florist,to_courier,closed';
	
	field = new FieldEnum("client_order_state",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	
	var field = new FieldBool("payed",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	
	var field = new FieldFloat("total",options);
	
	pm.addField(field);
	
	
	
}

			DOCClientOrder_Controller.prototype.addDelete = function(){
	DOCClientOrder_Controller.superclass.addDelete.call(this);
	var options = {"required":true};
	
	var pm = this.getDelete();
	pm.addField(new FieldInt("id",options));
}

			DOCClientOrder_Controller.prototype.addGetList = function(){
	DOCClientOrder_Controller.superclass.addGetList.call(this);
	var options = {};
	
	var pm = this.getGetList();
	pm.addField(new FieldInt("id",options));
	pm.addField(new FieldDateTime("date_time",options));
	pm.addField(new FieldString("date_time_descr",options));
	pm.addField(new FieldString("number",options));
	pm.addField(new FieldString("delivery_type",options));
	pm.addField(new FieldString("delivery_type_descr",options));
	pm.addField(new FieldString("client_name",options));
	pm.addField(new FieldString("client_tel",options));
	pm.addField(new FieldString("recipient_type",options));
	pm.addField(new FieldString("recipient_type_descr",options));
	pm.addField(new FieldString("recipient_name",options));
	pm.addField(new FieldString("recipient_tel",options));
	pm.addField(new FieldText("address",options));
	pm.addField(new FieldDate("delivery_date",options));
	pm.addField(new FieldString("delivery_date_descr",options));
	pm.addField(new FieldInt("delivery_hour_id",options));
	pm.addField(new FieldString("delivery_hour_descr",options));
	pm.addField(new FieldBool("card",options));
	pm.addField(new FieldText("card_text",options));
	pm.addField(new FieldBool("anonym_gift",options));
	pm.addField(new FieldString("delivery_note_type_descr",options));
	pm.addField(new FieldText("extra_comment",options));
	pm.addField(new FieldString("payment_type",options));
	pm.addField(new FieldString("payment_type_descr",options));
	pm.addField(new FieldString("client_order_state",options));
	pm.addField(new FieldString("client_order_state_descr",options));
	pm.addField(new FieldFloat("total",options));
}

			DOCClientOrder_Controller.prototype.addGetObject = function(){
	DOCClientOrder_Controller.superclass.addGetObject.call(this);
	var options = {};
	
	var pm = this.getGetObject();
	pm.addField(new FieldInt("id",options));
}

			DOCClientOrder_Controller.prototype.add_get_print = function(){
	var pm = new PublicMethod('get_print',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_id",options));
	
			
}
												
			DOCClientOrder_Controller.prototype.add_before_open = function(){
	var pm = new PublicMethod('before_open',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_id",options));
	
			
}

			DOCClientOrder_Controller.prototype.add_get_actions = function(){
	var pm = new PublicMethod('get_actions',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_id",options));
	
			
}
			
		