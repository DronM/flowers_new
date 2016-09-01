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

function DOCMaterialProcurementDOCTMaterial_Controller(app,options){
	options = options || {};
	options.listModelId = "DOCMaterialProcurementDOCTMaterialList_Model";
	options.objModelId = "DOCMaterialProcurementDOCTMaterialList_Model";
	DOCMaterialProcurementDOCTMaterial_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
		
}
extend(DOCMaterialProcurementDOCTMaterial_Controller,ControllerDb);

			DOCMaterialProcurementDOCTMaterial_Controller.prototype.addInsert = function(){
	DOCMaterialProcurementDOCTMaterial_Controller.superclass.addInsert.call(this);
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
	options.alias = "Материал";options.required = true;
	var field = new FieldInt("material_id",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Количество";
	var field = new FieldFloat("quant",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Цена";
	var field = new FieldFloat("price",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Сумма";
	var field = new FieldFloat("total",options);
	
	pm.addField(field);
	
	
}

			DOCMaterialProcurementDOCTMaterial_Controller.prototype.addUpdate = function(){
	DOCMaterialProcurementDOCTMaterial_Controller.superclass.addUpdate.call(this);
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
	options.alias = "Материал";options.required = true;
	var field = new FieldInt("material_id",options);
	
	pm.addField(field);
	
	
	options = {};
	options.alias = "Количество";
	var field = new FieldFloat("quant",options);
	
	pm.addField(field);
	
	
	options = {};
	options.alias = "Цена";
	var field = new FieldFloat("price",options);
	
	pm.addField(field);
	
	
	options = {};
	options.alias = "Сумма";
	var field = new FieldFloat("total",options);
	
	pm.addField(field);
	
	
	
}

			DOCMaterialProcurementDOCTMaterial_Controller.prototype.addDelete = function(){
	DOCMaterialProcurementDOCTMaterial_Controller.superclass.addDelete.call(this);
	var options = {"required":true};
	
	var pm = this.getDelete();
	pm.addField(new FieldInt("login_id",options));
	pm.addField(new FieldInt("line_number",options));
}

			DOCMaterialProcurementDOCTMaterial_Controller.prototype.addGetList = function(){
	DOCMaterialProcurementDOCTMaterial_Controller.superclass.addGetList.call(this);
	var options = {};
	
	var pm = this.getGetList();
	pm.addField(new FieldInt("login_id",options));
	pm.addField(new FieldInt("line_number",options));
	pm.addField(new FieldInt("material_id",options));
	pm.addField(new FieldString("material_descr",options));
	pm.addField(new FieldFloat("quant",options));
	pm.addField(new FieldFloat("price",options));
	pm.addField(new FieldFloat("total",options));
}

			DOCMaterialProcurementDOCTMaterial_Controller.prototype.addGetObject = function(){
	DOCMaterialProcurementDOCTMaterial_Controller.superclass.addGetObject.call(this);
	var options = {};
	
	var pm = this.getGetObject();
	pm.addField(new FieldInt("login_id",options));
	pm.addField(new FieldInt("line_number",options));
}

		