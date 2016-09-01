/* Copyright (c) 2012 
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
 * @requires common/functions.js
 * @requires core/ControllerDb.js
*/
//ф
/* constructor */

function CashRegister_Controller(servConnector){
	options = {};
	options["listModelId"] = "CashRegister_Model";
	options["objModelId"] = "CashRegister_Model";
	CashRegister_Controller.superclass.constructor.call(this,"CashRegister_Controller",servConnector,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	
}
extend(CashRegister_Controller,ControllerDb);

			CashRegister_Controller.prototype.addInsert = function(){
	CashRegister_Controller.superclass.addInsert.call(this);
	var param;
	var options;
	var pm = this.getInsert();
	options = {};
	
	var param = new FieldString("name",options);
	
	pm.addParam(param);
	
	options = {};
	
	var param = new FieldInt("port",options);
	
	pm.addParam(param);
	
	options = {};
	
	var param = new FieldInt("baud_rate",options);
	
	pm.addParam(param);
	
	pm.addParam(new FieldInt("ret_id",{}));
	
	
}

			CashRegister_Controller.prototype.addUpdate = function(){
	CashRegister_Controller.superclass.addUpdate.call(this);
	var param;
	var options;	
	var pm = this.getUpdate();
	options = {};
	
	var param = new FieldInt("id",options);
	
	pm.addParam(param);
	
	
	param = new FieldInt("old_id",{});
	pm.addParam(param);
	
	options = {};
	
	var param = new FieldString("name",options);
	
	pm.addParam(param);
	
	
	options = {};
	
	var param = new FieldInt("port",options);
	
	pm.addParam(param);
	
	
	options = {};
	
	var param = new FieldInt("baud_rate",options);
	
	pm.addParam(param);
	
	
	
}

			CashRegister_Controller.prototype.addDelete = function(){
	CashRegister_Controller.superclass.addDelete.call(this);
	var options = {"required":true};
	
	var pm = this.getDelete();
	pm.addParam(new FieldInt("id",options));
}

			CashRegister_Controller.prototype.addGetList = function(){
	CashRegister_Controller.superclass.addGetList.call(this);
	var options = {};
	
	var pm = this.getGetList();
	pm.addParam(new FieldInt("id",options));
	pm.addParam(new FieldString("name",options));
	pm.addParam(new FieldInt("port",options));
	pm.addParam(new FieldInt("baud_rate",options));
	pm.getParamById(this.PARAM_ORD_FIELDS).setValue("name");
	
}

			CashRegister_Controller.prototype.addGetObject = function(){
	CashRegister_Controller.superclass.addGetObject.call(this);
	var options = {};
	
	var pm = this.getGetObject();
	pm.addParam(new FieldInt("id",options));
}

		