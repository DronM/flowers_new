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

function DeliveryHour_Controller(app,options){
	options = options || {};
	options.listModelId = "DeliveryHourList_Model";
	options.objModelId = "DeliveryHourList_Model";
	DeliveryHour_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
		
}
extend(DeliveryHour_Controller,ControllerDb);

			DeliveryHour_Controller.prototype.addInsert = function(){
	DeliveryHour_Controller.superclass.addInsert.call(this);
	var field;
	var options;
	
	var pm = this.getInsert();
	options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	options = {};
	
	var field = new FieldInt("h_from",options);
	
	pm.addField(field);
	
	options = {};
	
	var field = new FieldInt("h_to",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			DeliveryHour_Controller.prototype.addUpdate = function(){
	DeliveryHour_Controller.superclass.addUpdate.call(this);
	var field;
	var options;	
	var pm = this.getUpdate();
	options = {};
	options.primaryKey = true;options.autoInc = true;options.required = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	options = {};
	
	var field = new FieldInt("h_from",options);
	
	pm.addField(field);
	
	
	options = {};
	
	var field = new FieldInt("h_to",options);
	
	pm.addField(field);
	
	
	
}

			DeliveryHour_Controller.prototype.addDelete = function(){
	DeliveryHour_Controller.superclass.addDelete.call(this);
	var options = {"required":true};
	
	var pm = this.getDelete();
	pm.addField(new FieldInt("id",options));
}

			DeliveryHour_Controller.prototype.addGetList = function(){
	DeliveryHour_Controller.superclass.addGetList.call(this);
	var options = {};
	
	var pm = this.getGetList();
	pm.addField(new FieldInt("id",options));
	pm.addField(new FieldInt("h_from",options));
	pm.addField(new FieldInt("h_to",options));
	pm.addField(new FieldString("descr",options));
}

			DeliveryHour_Controller.prototype.addGetObject = function(){
	DeliveryHour_Controller.superclass.addGetObject.call(this);
	var options = {};
	
	var pm = this.getGetObject();
	pm.addField(new FieldInt("id",options));
}

		