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

function DOCExpenceDOCTExpenceType_Controller(app,options){
	options = options || {};
	options.listModelId = "DOCExpenceDOCTExpenceTypeList_Model";
	options.objModelId = "DOCExpenceDOCTExpenceTypeList_Model";
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
	var options;
	
	var pm = this.getInsert();
	options = {};
	options.primaryKey = true;
	var field = new FieldInt("login_id",options);
	
	pm.addField(field);
	
	options = {};
	options.primaryKey = true;
	var field = new FieldInt("line_number",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Вид затрат";options.required = true;
	var field = new FieldInt("expence_type_id",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Сумма";
	var field = new FieldFloat("total",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Комментарий";
	var field = new FieldText("expence_comment",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Дата расхода";
	var field = new FieldDate("expence_date",options);
	
	pm.addField(field);
	
	
}

			DOCExpenceDOCTExpenceType_Controller.prototype.addUpdate = function(){
	DOCExpenceDOCTExpenceType_Controller.superclass.addUpdate.call(this);
	var field;
	var options;	
	var pm = this.getUpdate();
	options = {};
	options.primaryKey = true;
	var field = new FieldInt("login_id",options);
	
	pm.addField(field);
	
	
	field = new FieldInt("old_login_id",{});
	pm.addField(field);
	
	options = {};
	options.primaryKey = true;
	var field = new FieldInt("line_number",options);
	
	pm.addField(field);
	
	
	field = new FieldInt("old_line_number",{});
	pm.addField(field);
	
	options = {};
	options.alias = "Вид затрат";options.required = true;
	var field = new FieldInt("expence_type_id",options);
	
	pm.addField(field);
	
	
	options = {};
	options.alias = "Сумма";
	var field = new FieldFloat("total",options);
	
	pm.addField(field);
	
	
	options = {};
	options.alias = "Комментарий";
	var field = new FieldText("expence_comment",options);
	
	pm.addField(field);
	
	
	options = {};
	options.alias = "Дата расхода";
	var field = new FieldDate("expence_date",options);
	
	pm.addField(field);
	
	
	
}

			DOCExpenceDOCTExpenceType_Controller.prototype.addDelete = function(){
	DOCExpenceDOCTExpenceType_Controller.superclass.addDelete.call(this);
	var options = {"required":true};
	
	var pm = this.getDelete();
	pm.addField(new FieldInt("login_id",options));
	pm.addField(new FieldInt("line_number",options));
}

			DOCExpenceDOCTExpenceType_Controller.prototype.addGetList = function(){
	DOCExpenceDOCTExpenceType_Controller.superclass.addGetList.call(this);
	var options = {};
	
	var pm = this.getGetList();
	pm.addField(new FieldInt("line_number",options));
	pm.addField(new FieldInt("login_id",options));
	pm.addField(new FieldString("expence_type_descr",options));
	pm.addField(new FieldText("expence_comment",options));
	pm.addField(new FieldDate("expence_date",options));
	pm.addField(new FieldString("expence_date_descr",options));
}

			DOCExpenceDOCTExpenceType_Controller.prototype.addGetObject = function(){
	DOCExpenceDOCTExpenceType_Controller.superclass.addGetObject.call(this);
	var options = {};
	
	var pm = this.getGetObject();
	pm.addField(new FieldInt("line_number",options));
	pm.addField(new FieldInt("login_id",options));
}

		