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

function Supplier_Controller(app,options){
	options = options || {};
	options.listModelId = "SupplierList_Model";
	options.objModelId = "Supplier_Model";
	Supplier_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.addComplete();
		
}
extend(Supplier_Controller,ControllerDb);

			Supplier_Controller.prototype.addInsert = function(){
	Supplier_Controller.superclass.addInsert.call(this);
	var field;
	var options;
	
	var pm = this.getInsert();
	options = {};
	options.alias = "Код";options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Наименование";options.required = true;
	var field = new FieldString("name",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Полное наименование";options.required = true;
	var field = new FieldText("name_full",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Телефон";
	var field = new FieldString("tel",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Email";
	var field = new FieldString("email",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			Supplier_Controller.prototype.addUpdate = function(){
	Supplier_Controller.superclass.addUpdate.call(this);
	var field;
	var options;	
	var pm = this.getUpdate();
	options = {};
	options.alias = "Код";options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	options = {};
	options.alias = "Наименование";options.required = true;
	var field = new FieldString("name",options);
	
	pm.addField(field);
	
	
	options = {};
	options.alias = "Полное наименование";options.required = true;
	var field = new FieldText("name_full",options);
	
	pm.addField(field);
	
	
	options = {};
	options.alias = "Телефон";
	var field = new FieldString("tel",options);
	
	pm.addField(field);
	
	
	options = {};
	options.alias = "Email";
	var field = new FieldString("email",options);
	
	pm.addField(field);
	
	
	
}

			Supplier_Controller.prototype.addDelete = function(){
	Supplier_Controller.superclass.addDelete.call(this);
	var options = {"required":true};
	
	var pm = this.getDelete();
	pm.addField(new FieldInt("id",options));
}

			Supplier_Controller.prototype.addGetList = function(){
	Supplier_Controller.superclass.addGetList.call(this);
	var options = {};
	
	var pm = this.getGetList();
	pm.addField(new FieldInt("id",options));
	pm.addField(new FieldString("name",options));
	pm.addField(new FieldString("tel",options));
	pm.addField(new FieldString("email",options));
}

			Supplier_Controller.prototype.addGetObject = function(){
	Supplier_Controller.superclass.addGetObject.call(this);
	var options = {};
	
	var pm = this.getGetObject();
	pm.addField(new FieldInt("id",options));
}

			Supplier_Controller.prototype.addComplete = function(){
	Supplier_Controller.superclass.addComplete.call(this);
	
	var options = {};
	
	var pm = this.getComplete();
	pm.addField(new FieldString("name",options));
	pm.getField(this.PARAM_ORD_FIELDS).setValue("name");
}

		