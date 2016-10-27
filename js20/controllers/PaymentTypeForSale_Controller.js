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

function PaymentTypeForSale_Controller(app,options){
	options = options || {};
	options.listModelId = "PaymentTypeForSale_Model";
	options.objModelId = "PaymentTypeForSale_Model";
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
	var options;
	
	var pm = this.getInsert();
	options = {};
	options.alias = "Код";options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Наименование";options.required = true;
	var field = new FieldString("name",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Вид оплаты из заказа";	
	options.enumValues = 'cash,bank,yandex,trans_to_card,web_money';
	field = new FieldEnum("client_order_payment_type",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Тип оплаты для ККМ";
	var field = new FieldInt("kkm_type_close",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			PaymentTypeForSale_Controller.prototype.addUpdate = function(){
	PaymentTypeForSale_Controller.superclass.addUpdate.call(this);
	var field;
	var options;	
	var pm = this.getUpdate();
	options = {"sendNulls":true};
	options.alias = "Код";options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	options = {"sendNulls":true};
	options.alias = "Наименование";
	var field = new FieldString("name",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Вид оплаты из заказа";	
	options.enumValues = 'cash,bank,yandex,trans_to_card,web_money';
	
	field = new FieldEnum("client_order_payment_type",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Тип оплаты для ККМ";
	var field = new FieldInt("kkm_type_close",options);
	
	pm.addField(field);
	
	
	
}

			PaymentTypeForSale_Controller.prototype.addDelete = function(){
	PaymentTypeForSale_Controller.superclass.addDelete.call(this);
	var options = {"required":true};
	
	var pm = this.getDelete();
	pm.addField(new FieldInt("id",options));
}

			PaymentTypeForSale_Controller.prototype.addGetList = function(){
	PaymentTypeForSale_Controller.superclass.addGetList.call(this);
	var options = {};
	
	var pm = this.getGetList();
	pm.addField(new FieldInt("id",options));
	pm.addField(new FieldString("name",options));
	pm.addField(new FieldEnum("client_order_payment_type",options));
	pm.addField(new FieldInt("kkm_type_close",options));
	pm.getField(this.PARAM_ORD_FIELDS).setValue("name");
	
}

			PaymentTypeForSale_Controller.prototype.addGetObject = function(){
	PaymentTypeForSale_Controller.superclass.addGetObject.call(this);
	var options = {};
	
	var pm = this.getGetObject();
	pm.addField(new FieldInt("id",options));
}

		