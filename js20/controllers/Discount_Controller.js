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

function Discount_Controller(app,options){
	options = options || {};
	options.listModel = Discount_Model;
	options.objModel = Discount_Model;
	Discount_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.add_get_list_for_sale();
		
}
extend(Discount_Controller,ControllerDb);

			Discount_Controller.prototype.addInsert = function(){
	Discount_Controller.superclass.addInsert.call(this);
	var field;
	
	var pm = this.getInsert();
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Наименование";
	var field = new FieldString("name",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Процент";
	var field = new FieldInt("percent",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			Discount_Controller.prototype.addUpdate = function(){
	Discount_Controller.superclass.addUpdate.call(this);
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
	options.alias = "Процент";
	var field = new FieldInt("percent",options);
	
	pm.addField(field);
	
	
}

			Discount_Controller.prototype.addDelete = function(){
	Discount_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			Discount_Controller.prototype.addGetList = function(){
	Discount_Controller.superclass.addGetList.call(this);
	
	
	
	var pm = this.getGetList();
	var f_opts = {};
	
	pm.addField(new FieldInt("id",f_opts));
	var f_opts = {};
	f_opts.alias = "Наименование";
	pm.addField(new FieldString("name",f_opts));
	var f_opts = {};
	f_opts.alias = "Процент";
	pm.addField(new FieldInt("percent",f_opts));
	pm.getField(this.PARAM_ORD_FIELDS).setValue("name");
	
}

			Discount_Controller.prototype.addGetObject = function(){
	Discount_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
}

			Discount_Controller.prototype.add_get_list_for_sale = function(){
	var pm = new PublicMethod('get_list_for_sale',{controller:this});
	this.addPublicMethod(pm);
	
}

		