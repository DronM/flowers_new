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

function DOCClientOrderDOCTProduct_Controller(app,options){
	options = options || {};
	options.listModel = DOCClientOrderDOCTProductList_Model;
	options.objModel = DOCClientOrderDOCTProductList_Model;
	DOCClientOrderDOCTProduct_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
		
}
extend(DOCClientOrderDOCTProduct_Controller,ControllerDb);

			DOCClientOrderDOCTProduct_Controller.prototype.addInsert = function(){
	DOCClientOrderDOCTProduct_Controller.superclass.addInsert.call(this);
	var field;
	
	var pm = this.getInsert();
	var options = {};
	options.primaryKey = true;
	var field = new FieldString("view_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.primaryKey = true;
	var field = new FieldInt("line_number",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("login_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Букет";options.required = true;
	var field = new FieldInt("product_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Количество";
	var field = new FieldFloat("quant",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Цена";
	var field = new FieldFloat("price",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldFloat("disc_percent",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldFloat("price_no_disc",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Сумма";
	var field = new FieldFloat("total",options);
	
	pm.addField(field);
	
	
}

			DOCClientOrderDOCTProduct_Controller.prototype.addUpdate = function(){
	DOCClientOrderDOCTProduct_Controller.superclass.addUpdate.call(this);
	var field;	
	var pm = this.getUpdate();
	var options = {};
	options.primaryKey = true;
	var field = new FieldString("view_id",options);
	
	pm.addField(field);
	
	field = new FieldString("old_view_id",{});
	pm.addField(field);
	
	var options = {};
	options.primaryKey = true;
	var field = new FieldInt("line_number",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_line_number",{});
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("login_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Букет";
	var field = new FieldInt("product_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Количество";
	var field = new FieldFloat("quant",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Цена";
	var field = new FieldFloat("price",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldFloat("disc_percent",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldFloat("price_no_disc",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Сумма";
	var field = new FieldFloat("total",options);
	
	pm.addField(field);
	
	
}

			DOCClientOrderDOCTProduct_Controller.prototype.addDelete = function(){
	DOCClientOrderDOCTProduct_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldString("view_id",options));
	var options = {"required":true};
		
	pm.addField(new FieldInt("line_number",options));
}

			DOCClientOrderDOCTProduct_Controller.prototype.addGetList = function(){
	DOCClientOrderDOCTProduct_Controller.superclass.addGetList.call(this);
	
	
	
	var pm = this.getGetList();
	var f_opts = {};
	
	pm.addField(new FieldString("view_id",f_opts));
	var f_opts = {};
	f_opts.alias = "№";
	pm.addField(new FieldInt("line_number",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("login_id",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("product_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Букет";
	pm.addField(new FieldString("product_descr",f_opts));
	var f_opts = {};
	f_opts.alias = "Количество";
	pm.addField(new FieldFloat("quant",f_opts));
	var f_opts = {};
	f_opts.alias = "Цена";
	pm.addField(new FieldFloat("price",f_opts));
	var f_opts = {};
	f_opts.alias = "Скидка,%";
	pm.addField(new FieldFloat("disc_percent",f_opts));
	var f_opts = {};
	f_opts.alias = "Цена";
	pm.addField(new FieldFloat("price_no_disc",f_opts));
	var f_opts = {};
	f_opts.alias = "Всего";
	pm.addField(new FieldFloat("total",f_opts));
}

			DOCClientOrderDOCTProduct_Controller.prototype.addGetObject = function(){
	DOCClientOrderDOCTProduct_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldString("view_id",f_opts));
	var f_opts = {};
	f_opts.alias = "№";	
	pm.addField(new FieldInt("line_number",f_opts));
}

		