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

function Specification_Controller(app,options){
	options = options || {};
	options.listModelId = "SpecificationList_Model";
	options.objModelId = "SpecificationList_Model";
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
	var options;
	
	var pm = this.getInsert();
	options = {};
	options.alias = "Код";options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Продукция";options.required = true;
	var field = new FieldInt("product_id",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Материал";options.required = true;
	var field = new FieldInt("material_id",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Кол.продукции";
	var field = new FieldFloat("product_quant",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Кол.материала";options.required = true;
	var field = new FieldFloat("material_quant",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			Specification_Controller.prototype.addUpdate = function(){
	Specification_Controller.superclass.addUpdate.call(this);
	var field;
	var options;	
	var pm = this.getUpdate();
	options = {"sendNulls":true};
	options.alias = "Код";options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	options = {"sendNulls":true};
	options.alias = "Продукция";
	var field = new FieldInt("product_id",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Материал";
	var field = new FieldInt("material_id",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Кол.продукции";
	var field = new FieldFloat("product_quant",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Кол.материала";
	var field = new FieldFloat("material_quant",options);
	
	pm.addField(field);
	
	
	
}

			Specification_Controller.prototype.addDelete = function(){
	Specification_Controller.superclass.addDelete.call(this);
	var options = {"required":true};
	
	var pm = this.getDelete();
	pm.addField(new FieldInt("id",options));
}

			Specification_Controller.prototype.addGetList = function(){
	Specification_Controller.superclass.addGetList.call(this);
	var options = {};
	
	var pm = this.getGetList();
	pm.addField(new FieldInt("id",options));
	pm.addField(new FieldInt("product_id",options));
	pm.addField(new FieldString("product_descr",options));
	pm.addField(new FieldInt("material_id",options));
	pm.addField(new FieldString("material_descr",options));
	pm.addField(new FieldInt("product_quant",options));
	pm.addField(new FieldFloat("material_quant",options));
}

			Specification_Controller.prototype.addGetObject = function(){
	Specification_Controller.superclass.addGetObject.call(this);
	var options = {};
	
	var pm = this.getGetObject();
	pm.addField(new FieldInt("id",options));
}

		