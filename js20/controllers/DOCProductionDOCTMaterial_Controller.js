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

function DOCProductionDOCTMaterial_Controller(app,options){
	options = options || {};
	options.listModel = DOCProductionDOCTMaterialList_Model;
	options.objModel = DOCProductionDOCTMaterialList_Model;
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
	
	var pm = this.getInsert();
	var options = {};
	options.primaryKey = true;
	var field = new FieldString("view_id",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("login_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.primaryKey = true;
	var field = new FieldInt("line_number",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Материал";options.required = true;
	var field = new FieldInt("material_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Количество";
	var field = new FieldFloat("quant",options);
	
	pm.addField(field);
	
	
}

			DOCProductionDOCTMaterial_Controller.prototype.addUpdate = function(){
	DOCProductionDOCTMaterial_Controller.superclass.addUpdate.call(this);
	var field;	
	var pm = this.getUpdate();
	var options = {};
	options.primaryKey = true;
	var field = new FieldString("view_id",options);
	
	pm.addField(field);
	
	field = new FieldString("old_view_id",{});
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("login_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.primaryKey = true;
	var field = new FieldInt("line_number",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_line_number",{});
	pm.addField(field);
	
	var options = {};
	options.alias = "Материал";
	var field = new FieldInt("material_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Количество";
	var field = new FieldFloat("quant",options);
	
	pm.addField(field);
	
	
}

			DOCProductionDOCTMaterial_Controller.prototype.addDelete = function(){
	DOCProductionDOCTMaterial_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldString("view_id",options));
	var options = {"required":true};
		
	pm.addField(new FieldInt("line_number",options));
}

			DOCProductionDOCTMaterial_Controller.prototype.addGetList = function(){
	DOCProductionDOCTMaterial_Controller.superclass.addGetList.call(this);
	
	
	
	var pm = this.getGetList();
	var f_opts = {};
	
	pm.addField(new FieldString("view_id",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("login_id",f_opts));
	var f_opts = {};
	f_opts.alias = "№";
	pm.addField(new FieldInt("line_number",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("material_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Материал";
	pm.addField(new FieldString("material_descr",f_opts));
	var f_opts = {};
	f_opts.alias = "Количество";
	pm.addField(new FieldFloat("quant",f_opts));
}

			DOCProductionDOCTMaterial_Controller.prototype.addGetObject = function(){
	DOCProductionDOCTMaterial_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldString("view_id",f_opts));
	var f_opts = {};
	f_opts.alias = "№";	
	pm.addField(new FieldInt("line_number",f_opts));
}

			DOCProductionDOCTMaterial_Controller.prototype.add_get_florist_list = function(){
	var pm = new PublicMethod('get_florist_list',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("store_id",options));
	
			
}

		