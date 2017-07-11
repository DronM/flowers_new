/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2017
 
 * @class
 * @classdesc controller
 
 * @requires ../core/extend.js
 * @requires ../core/ControllerDb.js 
  
 * @param {App} app - app instance
 * @param {namespase} options
 * @param {Model} options.listModel
 * @param {Model} options.objModel 
 */ 

function DOCClientOrder_Controller(app,options){
	options = options || {};
	options.listModel = DOCClientOrderList_Model;
	options.objModel = DOCClientOrderList_Model;
	DOCClientOrder_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.add_get_print();
	this.add_before_open();
	this.add_set_unprocessed();
	this.add_get_actions();
	this.add_get_print();
	this.add_set_state();
	this.add_set_payed();
		
}
extend(DOCClientOrder_Controller,ControllerDb);

			DOCClientOrder_Controller.prototype.addInsert = function(){
	DOCClientOrder_Controller.superclass.addInsert.call(this);
	var field;
	
	var pm = this.getInsert();
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldDateTime("date_time",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Номер";
	var field = new FieldInt("number",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Номер с сайта";
	var field = new FieldString("number_from_site",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Проведен";
	var field = new FieldBool("processed",options);
	
	pm.addField(field);
	
	var options = {};
	options.required = true;	
	options.enumValues = 'courier,by_client';
	field = new FieldEnum("delivery_type",options);
	
	pm.addField(field);
	
	var options = {};
	options.required = true;
	var field = new FieldString("client_name",options);
	
	pm.addField(field);
	
	var options = {};
	options.required = true;
	var field = new FieldString("client_tel",options);
	
	pm.addField(field);
	
	var options = {};
	options.required = true;	
	options.enumValues = 'self,other';
	field = new FieldEnum("recipient_type",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldString("recipient_name",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldString("recipient_tel",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldText("address",options);
	
	pm.addField(field);
	
	var options = {};
	options.required = true;
	var field = new FieldDate("delivery_date",options);
	
	pm.addField(field);
	
	var options = {};
	options.required = true;
	var field = new FieldInt("delivery_hour_id",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldString("delivery_comment",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldBool("card",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldText("card_text",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldBool("anonym_gift",options);
	
	pm.addField(field);
	
	var options = {};
		
	options.enumValues = 'by_call,by_sms';
	field = new FieldEnum("delivery_note_type",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldText("extra_comment",options);
	
	pm.addField(field);
	
	var options = {};
		
	options.enumValues = 'cash,bank,yandex,trans_to_card,web_money';
	field = new FieldEnum("payment_type",options);
	
	pm.addField(field);
	
	var options = {};
		
	options.enumValues = 'to_noone,checked,to_florist,to_courier,closed';
	field = new FieldEnum("client_order_state",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldBool("payed",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Сумма";
	var field = new FieldFloat("total",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Магазин";
	var field = new FieldInt("store_id",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
		var options = {};
		options.required = true;		
		pm.addField(new FieldString("view_id",options));
	
	
}

			DOCClientOrder_Controller.prototype.addUpdate = function(){
	DOCClientOrder_Controller.superclass.addUpdate.call(this);
	var field;	
	var pm = this.getUpdate();
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldDateTime("date_time",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Номер";
	var field = new FieldInt("number",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Номер с сайта";
	var field = new FieldString("number_from_site",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Проведен";
	var field = new FieldBool("processed",options);
	
	pm.addField(field);
	
	var options = {};
		
	options.enumValues = 'courier,by_client';
	options.enumValues+= (options.enumValues=='')? '':',';
	options.enumValues+= 'null';
	
	field = new FieldEnum("delivery_type",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldString("client_name",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldString("client_tel",options);
	
	pm.addField(field);
	
	var options = {};
		
	options.enumValues = 'self,other';
	options.enumValues+= (options.enumValues=='')? '':',';
	options.enumValues+= 'null';
	
	field = new FieldEnum("recipient_type",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldString("recipient_name",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldString("recipient_tel",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldText("address",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldDate("delivery_date",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("delivery_hour_id",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldString("delivery_comment",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldBool("card",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldText("card_text",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldBool("anonym_gift",options);
	
	pm.addField(field);
	
	var options = {};
		
	options.enumValues = 'by_call,by_sms';
	
	field = new FieldEnum("delivery_note_type",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldText("extra_comment",options);
	
	pm.addField(field);
	
	var options = {};
		
	options.enumValues = 'cash,bank,yandex,trans_to_card,web_money';
	
	field = new FieldEnum("payment_type",options);
	
	pm.addField(field);
	
	var options = {};
		
	options.enumValues = 'to_noone,checked,to_florist,to_courier,closed';
	
	field = new FieldEnum("client_order_state",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldBool("payed",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Сумма";
	var field = new FieldFloat("total",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Магазин";
	var field = new FieldInt("store_id",options);
	
	pm.addField(field);
	
		var options = {};
		options.required = true;		
		pm.addField(new FieldString("view_id",options));
	
	
}

			DOCClientOrder_Controller.prototype.addDelete = function(){
	DOCClientOrder_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			DOCClientOrder_Controller.prototype.addGetList = function(){
	DOCClientOrder_Controller.superclass.addGetList.call(this);
	
	
	
	var pm = this.getGetList();
	var f_opts = {};
	
	pm.addField(new FieldInt("id",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldDateTime("date_time",f_opts));
	var f_opts = {};
	f_opts.alias = "Проведен";
	pm.addField(new FieldBool("processed",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldString("number",f_opts));
	var f_opts = {};
	f_opts.alias = "Номер с сайта";
	pm.addField(new FieldString("number_from_site",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldString("delivery_type",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldString("client_name",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldString("client_tel",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("client_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Покупатель из справочника";
	pm.addField(new FieldString("client_descr",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldString("recipient_type",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldString("recipient_name",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldString("recipient_tel",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldText("address",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldDate("delivery_date",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("delivery_hour_id",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldString("delivery_hour_descr",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldBool("card",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldText("card_text",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldBool("anonym_gift",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldString("delivery_note_type",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldText("extra_comment",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldText("delivery_comment",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldString("payment_type",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldString("client_order_state",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldBool("payed",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldFloat("total",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("store_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Проведен";
	pm.addField(new FieldString("store_descr",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldString("doc_client_order_descr",f_opts));
	var f_opts = {};
	f_opts.alias = "Сумма";
	pm.addField(new FieldFloat("total",f_opts));
}

			DOCClientOrder_Controller.prototype.addGetObject = function(){
	DOCClientOrder_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
}

			DOCClientOrder_Controller.prototype.add_get_print = function(){
	var pm = new PublicMethod('get_print',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_id",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("templ",options));
	
			
}
												
			DOCClientOrder_Controller.prototype.add_before_open = function(){
	var pm = new PublicMethod('before_open',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		options.maxlength = "32";
	
		pm.addField(new FieldString("view_id",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_id",options));
	
			
}

			DOCClientOrder_Controller.prototype.add_set_unprocessed = function(){
	var pm = new PublicMethod('set_unprocessed',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldInt("doc_id",options));
	
			
}
			
			DOCClientOrder_Controller.prototype.add_get_actions = function(){
	var pm = new PublicMethod('get_actions',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_id",options));
	
			
}
			
			DOCClientOrder_Controller.prototype.add_get_print = function(){
	var pm = new PublicMethod('get_print',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_id",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("templ",options));
	
			
}
			
			DOCClientOrder_Controller.prototype.add_set_state = function(){
	var pm = new PublicMethod('set_state',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_id",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("state",options));
	
			
}
			
			DOCClientOrder_Controller.prototype.add_set_payed = function(){
	var pm = new PublicMethod('set_payed',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_id",options));
	
			
}
			
			
		
	
DOCClientOrder_Controller.prototype.getPrintList = function(){
	return  [
		new PrintObj({
			"caption":"Заказ покупателя",
			"publicMethod":this.getPublicMethod("get_print"),
			"templ":"DOCClientOrderPrint",
			"publicMethodKeyIds":["doc_id"]
		})
	];
}
	
