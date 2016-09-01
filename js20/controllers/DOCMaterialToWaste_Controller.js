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

function DOCMaterialToWaste_Controller(app,options){
	options = options || {};
	options.listModelId = "DOCMaterialToWasteList_Model";
	options.objModelId = "DOCMaterialToWasteList_Model";
	DOCMaterialToWaste_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.add_before_open();
	this.add_get_actions();
	this.add_get_print();
		
}
extend(DOCMaterialToWaste_Controller,ControllerDb);

			DOCMaterialToWaste_Controller.prototype.addInsert = function(){
	DOCMaterialToWaste_Controller.superclass.addInsert.call(this);
	var field;
	var options;
	
	var pm = this.getInsert();
	options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Дата";options.required = true;
	var field = new FieldDateTime("date_time",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Номер";
	var field = new FieldInt("number",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Проведен";
	var field = new FieldBool("processed",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Магазин";
	var field = new FieldInt("store_id",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Автор";
	var field = new FieldInt("user_id",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Причина списания";
	var field = new FieldText("explanation",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			DOCMaterialToWaste_Controller.prototype.addUpdate = function(){
	DOCMaterialToWaste_Controller.superclass.addUpdate.call(this);
	var field;
	var options;	
	var pm = this.getUpdate();
	options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	options = {};
	options.alias = "Дата";options.required = true;
	var field = new FieldDateTime("date_time",options);
	
	pm.addField(field);
	
	
	options = {};
	options.alias = "Номер";
	var field = new FieldInt("number",options);
	
	pm.addField(field);
	
	
	options = {};
	options.alias = "Проведен";
	var field = new FieldBool("processed",options);
	
	pm.addField(field);
	
	
	options = {};
	options.alias = "Магазин";
	var field = new FieldInt("store_id",options);
	
	pm.addField(field);
	
	
	options = {};
	options.alias = "Автор";
	var field = new FieldInt("user_id",options);
	
	pm.addField(field);
	
	
	options = {};
	options.alias = "Причина списания";
	var field = new FieldText("explanation",options);
	
	pm.addField(field);
	
	
	
}

			DOCMaterialToWaste_Controller.prototype.addDelete = function(){
	DOCMaterialToWaste_Controller.superclass.addDelete.call(this);
	var options = {"required":true};
	
	var pm = this.getDelete();
	pm.addField(new FieldInt("id",options));
}

			DOCMaterialToWaste_Controller.prototype.addGetList = function(){
	DOCMaterialToWaste_Controller.superclass.addGetList.call(this);
	var options = {};
	
	var pm = this.getGetList();
	pm.addField(new FieldInt("id",options));
	pm.addField(new FieldDateTime("date_time",options));
	pm.addField(new FieldString("date_time_descr",options));
	pm.addField(new FieldString("number",options));
	pm.addField(new FieldString("processed",options));
	pm.addField(new FieldInt("store_id",options));
	pm.addField(new FieldString("store_descr",options));
	pm.addField(new FieldInt("user_id",options));
	pm.addField(new FieldString("user_descr",options));
	pm.addField(new FieldString("explanation",options));
}

			DOCMaterialToWaste_Controller.prototype.addGetObject = function(){
	DOCMaterialToWaste_Controller.superclass.addGetObject.call(this);
	var options = {};
	
	var pm = this.getGetObject();
	pm.addField(new FieldInt("id",options));
}

			DOCMaterialToWaste_Controller.prototype.add_before_open = function(){
	var pm = new PublicMethod('before_open',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_id",options));
	
			
}

			DOCMaterialToWaste_Controller.prototype.add_get_actions = function(){
	var pm = new PublicMethod('get_actions',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_id",options));
	
			
}

			DOCMaterialToWaste_Controller.prototype.add_get_print = function(){
	var pm = new PublicMethod('get_print',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_id",options));
	
			
}
									
		