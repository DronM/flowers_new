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

function DOCExpenceDOCTExpenceType_Controller(app,options){
	options = options || {};
	options.listModel = DOCExpenceDOCTExpenceTypeList_Model;
	options.objModel = DOCExpenceDOCTExpenceTypeList_Model;
	DOCExpenceDOCTExpenceType_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
		
}
extend(DOCExpenceDOCTExpenceType_Controller,ControllerDb);

			DOCExpenceDOCTExpenceType_Controller.prototype.addInsert = function(){
	DOCExpenceDOCTExpenceType_Controller.superclass.addInsert.call(this);
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
	options.alias = "Вид затрат";options.required = true;
	var field = new FieldInt("expence_type_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Сумма";
	var field = new FieldFloat("total",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Комментарий";
	var field = new FieldText("expence_comment",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Дата расхода";
	var field = new FieldDate("expence_date",options);
	
	pm.addField(field);
	
	
}

			DOCExpenceDOCTExpenceType_Controller.prototype.addUpdate = function(){
	DOCExpenceDOCTExpenceType_Controller.superclass.addUpdate.call(this);
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
	options.alias = "Вид затрат";
	var field = new FieldInt("expence_type_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Сумма";
	var field = new FieldFloat("total",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Комментарий";
	var field = new FieldText("expence_comment",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Дата расхода";
	var field = new FieldDate("expence_date",options);
	
	pm.addField(field);
	
	
}

			DOCExpenceDOCTExpenceType_Controller.prototype.addDelete = function(){
	DOCExpenceDOCTExpenceType_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldString("view_id",options));
	var options = {"required":true};
		
	pm.addField(new FieldInt("line_number",options));
}

			DOCExpenceDOCTExpenceType_Controller.prototype.addGetList = function(){
	DOCExpenceDOCTExpenceType_Controller.superclass.addGetList.call(this);
	
	
	
	var pm = this.getGetList();
	var f_opts = {};
	
	pm.addField(new FieldString("view_id",f_opts));
	var f_opts = {};
	f_opts.alias = "№";
	pm.addField(new FieldInt("line_number",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("login_id",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("expence_type_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Вид затрат";
	pm.addField(new FieldString("expence_type_descr",f_opts));
	var f_opts = {};
	f_opts.alias = "Комментарий";
	pm.addField(new FieldText("expence_comment",f_opts));
	var f_opts = {};
	f_opts.alias = "Сумма";
	pm.addField(new FieldFloat("total",f_opts));
	var f_opts = {};
	f_opts.alias = "Дата расхода";
	pm.addField(new FieldDate("expence_date",f_opts));
}

			DOCExpenceDOCTExpenceType_Controller.prototype.addGetObject = function(){
	DOCExpenceDOCTExpenceType_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldString("view_id",f_opts));
	var f_opts = {};
	f_opts.alias = "№";	
	pm.addField(new FieldInt("line_number",f_opts));
}

		