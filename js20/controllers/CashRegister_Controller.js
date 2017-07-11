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

function CashRegister_Controller(app,options){
	options = options || {};
	options.listModel = CashRegister_Model;
	options.objModel = CashRegister_Model;
	CashRegister_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
		
}
extend(CashRegister_Controller,ControllerDb);

			CashRegister_Controller.prototype.addInsert = function(){
	CashRegister_Controller.superclass.addInsert.call(this);
	var field;
	
	var pm = this.getInsert();
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Наименование";options.required = true;
	var field = new FieldString("name",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Порт оборудования";
	var field = new FieldInt("port",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Скорость оборудования";
	var field = new FieldInt("baud_rate",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Сервер";
	var field = new FieldString("eq_server",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Порт сервера";
	var field = new FieldInt("eq_port",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Идентификатор оборуд.";
	var field = new FieldString("eq_id",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			CashRegister_Controller.prototype.addUpdate = function(){
	CashRegister_Controller.superclass.addUpdate.call(this);
	var field;	
	var pm = this.getUpdate();
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	var options = {};
	options.alias = "Наименование";
	var field = new FieldString("name",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Порт оборудования";
	var field = new FieldInt("port",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Скорость оборудования";
	var field = new FieldInt("baud_rate",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Сервер";
	var field = new FieldString("eq_server",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Порт сервера";
	var field = new FieldInt("eq_port",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Идентификатор оборуд.";
	var field = new FieldString("eq_id",options);
	
	pm.addField(field);
	
	
}

			CashRegister_Controller.prototype.addDelete = function(){
	CashRegister_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			CashRegister_Controller.prototype.addGetList = function(){
	CashRegister_Controller.superclass.addGetList.call(this);
	
	
	
	var pm = this.getGetList();
	var f_opts = {};
	
	pm.addField(new FieldInt("id",f_opts));
	var f_opts = {};
	f_opts.alias = "Наименование";
	pm.addField(new FieldString("name",f_opts));
	var f_opts = {};
	f_opts.alias = "Порт оборудования";
	pm.addField(new FieldInt("port",f_opts));
	var f_opts = {};
	f_opts.alias = "Скорость оборудования";
	pm.addField(new FieldInt("baud_rate",f_opts));
	var f_opts = {};
	f_opts.alias = "Сервер";
	pm.addField(new FieldString("eq_server",f_opts));
	var f_opts = {};
	f_opts.alias = "Порт сервера";
	pm.addField(new FieldInt("eq_port",f_opts));
	var f_opts = {};
	f_opts.alias = "Идентификатор оборуд.";
	pm.addField(new FieldString("eq_id",f_opts));
	pm.getField(this.PARAM_ORD_FIELDS).setValue("name");
	
}

			CashRegister_Controller.prototype.addGetObject = function(){
	CashRegister_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
}

		