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

function Specification_Controller(app,options){
	options = options || {};
	options.listModel = SpecificationList_Model;
	options.objModel = SpecificationList_Model;
	Specification_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
		
}
extend(Specification_Controller,ControllerDb);

			Specification_Controller.prototype.addInsert = function(){
	Specification_Controller.superclass.addInsert.call(this);
	var field;
	
	var pm = this.getInsert();
	var options = {};
	options.alias = "Код";options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Продукция";options.required = true;
	var field = new FieldInt("product_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Материал";options.required = true;
	var field = new FieldInt("material_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Кол.продукции";
	var field = new FieldFloat("product_quant",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Кол.материала";options.required = true;
	var field = new FieldFloat("material_quant",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			Specification_Controller.prototype.addUpdate = function(){
	Specification_Controller.superclass.addUpdate.call(this);
	var field;	
	var pm = this.getUpdate();
	var options = {};
	options.alias = "Код";options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	var options = {};
	options.alias = "Продукция";
	var field = new FieldInt("product_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Материал";
	var field = new FieldInt("material_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Кол.продукции";
	var field = new FieldFloat("product_quant",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Кол.материала";
	var field = new FieldFloat("material_quant",options);
	
	pm.addField(field);
	
	
}

			Specification_Controller.prototype.addDelete = function(){
	Specification_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
	options.alias = "Код";	
	pm.addField(new FieldInt("id",options));
}

			Specification_Controller.prototype.addGetList = function(){
	Specification_Controller.superclass.addGetList.call(this);
	
	
	
	var pm = this.getGetList();
	var f_opts = {};
	
	pm.addField(new FieldInt("id",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("product_id",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldString("product_descr",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("material_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Материал";
	pm.addField(new FieldString("material_descr",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("product_quant",f_opts));
	var f_opts = {};
	f_opts.alias = "Количество";
	pm.addField(new FieldFloat("material_quant",f_opts));
}

			Specification_Controller.prototype.addGetObject = function(){
	Specification_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
}

		