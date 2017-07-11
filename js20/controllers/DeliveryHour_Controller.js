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

function DeliveryHour_Controller(app,options){
	options = options || {};
	options.listModel = DeliveryHourList_Model;
	options.objModel = DeliveryHourList_Model;
	DeliveryHour_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
		
}
extend(DeliveryHour_Controller,ControllerDb);

			DeliveryHour_Controller.prototype.addInsert = function(){
	DeliveryHour_Controller.superclass.addInsert.call(this);
	var field;
	
	var pm = this.getInsert();
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("h_from",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("h_to",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			DeliveryHour_Controller.prototype.addUpdate = function(){
	DeliveryHour_Controller.superclass.addUpdate.call(this);
	var field;	
	var pm = this.getUpdate();
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("h_from",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("h_to",options);
	
	pm.addField(field);
	
	
}

			DeliveryHour_Controller.prototype.addDelete = function(){
	DeliveryHour_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			DeliveryHour_Controller.prototype.addGetList = function(){
	DeliveryHour_Controller.superclass.addGetList.call(this);
	
	
	
	var pm = this.getGetList();
	var f_opts = {};
	
	pm.addField(new FieldInt("id",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("h_from",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("h_to",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldString("descr",f_opts));
}

			DeliveryHour_Controller.prototype.addGetObject = function(){
	DeliveryHour_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
}

		