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

function PaymentTypeForSale_Controller(app,options){
	options = options || {};
	options.listModel = PaymentTypeForSale_Model;
	options.objModel = PaymentTypeForSale_Model;
	PaymentTypeForSale_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
		
}
extend(PaymentTypeForSale_Controller,ControllerDb);

			PaymentTypeForSale_Controller.prototype.addInsert = function(){
	PaymentTypeForSale_Controller.superclass.addInsert.call(this);
	var field;
	
	var pm = this.getInsert();
	var options = {};
	options.alias = "Код";options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Наименование";options.required = true;
	var field = new FieldString("name",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Вид оплаты из заказа";	
	options.enumValues = 'cash,bank,yandex,trans_to_card,web_money';
	field = new FieldEnum("client_order_payment_type",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Тип оплаты для ККМ";
	var field = new FieldInt("kkm_type_close",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			PaymentTypeForSale_Controller.prototype.addUpdate = function(){
	PaymentTypeForSale_Controller.superclass.addUpdate.call(this);
	var field;	
	var pm = this.getUpdate();
	var options = {};
	options.alias = "Код";options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	var options = {};
	options.alias = "Наименование";
	var field = new FieldString("name",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Вид оплаты из заказа";	
	options.enumValues = 'cash,bank,yandex,trans_to_card,web_money';
	
	field = new FieldEnum("client_order_payment_type",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Тип оплаты для ККМ";
	var field = new FieldInt("kkm_type_close",options);
	
	pm.addField(field);
	
	
}

			PaymentTypeForSale_Controller.prototype.addDelete = function(){
	PaymentTypeForSale_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
	options.alias = "Код";	
	pm.addField(new FieldInt("id",options));
}

			PaymentTypeForSale_Controller.prototype.addGetList = function(){
	PaymentTypeForSale_Controller.superclass.addGetList.call(this);
	
	
	
	var pm = this.getGetList();
	var f_opts = {};
	f_opts.alias = "Код";
	pm.addField(new FieldInt("id",f_opts));
	var f_opts = {};
	f_opts.alias = "Наименование";
	pm.addField(new FieldString("name",f_opts));
	var f_opts = {};
	f_opts.alias = "Вид оплаты из заказа";
	pm.addField(new FieldEnum("client_order_payment_type",f_opts));
	var f_opts = {};
	f_opts.alias = "Тип оплаты для ККМ";
	pm.addField(new FieldInt("kkm_type_close",f_opts));
	pm.getField(this.PARAM_ORD_FIELDS).setValue("name");
	
}

			PaymentTypeForSale_Controller.prototype.addGetObject = function(){
	PaymentTypeForSale_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
	f_opts.alias = "Код";	
	pm.addField(new FieldInt("id",f_opts));
}

		