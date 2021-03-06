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

function DiscCard_Controller(app,options){
	options = options || {};
	options.listModel = DiscCard_Model;
	options.objModel = DiscCard_Model;
	DiscCard_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addUpdate();
	this.addGetList();
	this.addGetObject();
	this.addComplete();
		
}
extend(DiscCard_Controller,ControllerDb);

			DiscCard_Controller.prototype.addUpdate = function(){
	DiscCard_Controller.superclass.addUpdate.call(this);
	var field;	
	var pm = this.getUpdate();
	var options = {};
	options.alias = "Код";options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	var options = {};
	options.alias = "Вид скидки";
	var field = new FieldInt("discount_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Штрихкод";
	var field = new FieldText("barcode",options);
	
	pm.addField(field);
	
	
}

			DiscCard_Controller.prototype.addGetList = function(){
	DiscCard_Controller.superclass.addGetList.call(this);
	
	
	
	var pm = this.getGetList();
	var f_opts = {};
	f_opts.alias = "Код";
	pm.addField(new FieldInt("id",f_opts));
	var f_opts = {};
	f_opts.alias = "Вид скидки";
	pm.addField(new FieldInt("discount_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Штрихкод";
	pm.addField(new FieldText("barcode",f_opts));
}

			DiscCard_Controller.prototype.addGetObject = function(){
	DiscCard_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
	f_opts.alias = "Код";	
	pm.addField(new FieldInt("id",f_opts));
}

			DiscCard_Controller.prototype.addComplete = function(){
	DiscCard_Controller.superclass.addComplete.call(this);
	
	var f_opts = {};
	f_opts.alias = "";
	var pm = this.getComplete();
	pm.addField(new FieldText("barcode",f_opts));
	pm.getField(this.PARAM_ORD_FIELDS).setValue("barcode");
}

		