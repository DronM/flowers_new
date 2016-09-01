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

function DOCProductionDOCTMaterial_Controller(app,options){
	options = options || {};
	options.listModelId = "DOCProductionDOCTMaterialList_Model";
	options.objModelId = "DOCProductionDOCTMaterialList_Model";
	DOCProductionDOCTMaterial_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.add_get_florist_list();
		
}
extend(DOCProductionDOCTMaterial_Controller,ControllerDb);

			DOCProductionDOCTMaterial_Controller.prototype.addInsert = function(){
	DOCProductionDOCTMaterial_Controller.superclass.addInsert.call(this);
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
	var field = new FieldFloat("quant_norm",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Количество";
	var field = new FieldFloat("quant",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Количество";
	var field = new FieldFloat("quant_waste",options);
	
	pm.addField(field);
	
	
}

			DOCProductionDOCTMaterial_Controller.prototype.addUpdate = function(){
	DOCProductionDOCTMaterial_Controller.superclass.addUpdate.call(this);
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
	var field = new FieldFloat("quant_norm",options);
	
	pm.addField(field);
	
	
	options = {};
	options.alias = "Количество";
	var field = new FieldFloat("quant",options);
	
	pm.addField(field);
	
	
	options = {};
	options.alias = "Количество";
	var field = new FieldFloat("quant_waste",options);
	
	pm.addField(field);
	
	
	
}

			DOCProductionDOCTMaterial_Controller.prototype.addDelete = function(){
	DOCProductionDOCTMaterial_Controller.superclass.addDelete.call(this);
	var options = {"required":true};
	
	var pm = this.getDelete();
	pm.addField(new FieldInt("login_id",options));
	pm.addField(new FieldInt("line_number",options));
}

			DOCProductionDOCTMaterial_Controller.prototype.addGetList = function(){
	DOCProductionDOCTMaterial_Controller.superclass.addGetList.call(this);
	var options = {};
	
	var pm = this.getGetList();
	pm.addField(new FieldInt("line_number",options));
	pm.addField(new FieldInt("login_id",options));
	pm.addField(new FieldInt("material_id",options));
	pm.addField(new FieldString("material_descr",options));
	pm.addField(new FieldFloat("quant_norm",options));
	pm.addField(new FieldFloat("quant",options));
	pm.addField(new FieldFloat("quant_waste",options));
}

			DOCProductionDOCTMaterial_Controller.prototype.addGetObject = function(){
	DOCProductionDOCTMaterial_Controller.superclass.addGetObject.call(this);
	var options = {};
	
	var pm = this.getGetObject();
	pm.addField(new FieldInt("line_number",options));
	pm.addField(new FieldInt("login_id",options));
}

			DOCProductionDOCTMaterial_Controller.prototype.add_get_florist_list = function(){
	var pm = new PublicMethod('get_florist_list',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("store_id",options));
	
			
}

		