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

function Client_Controller(servConnector){
	options = {};
	options["listModelId"] = "ClientList_Model";
	options["objModelId"] = "ClientDialog_Model";
	Client_Controller.superclass.constructor.call(this,"Client_Controller",servConnector,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.addComplete();
	
}
extend(Client_Controller,ControllerDb);

			Client_Controller.prototype.addInsert = function(){
	Client_Controller.superclass.addInsert.call(this);
	var param;
	var options;
	var pm = this.getInsert();
	options = {};
	options["alias"]="Наименование";
	var param = new FieldString("name",options);
	
	pm.addParam(param);
	
	options = {};
	options["alias"]="Полное наименование";
	var param = new FieldText("name_full",options);
	
	pm.addParam(param);
	
	options = {};
	options["alias"]="Сотовый телефон";
	var param = new FieldString("phone_cel",options);
	
	pm.addParam(param);
	
	options = {};
	options["alias"]="Менеджер";
	var param = new FieldInt("manager_id",options);
	
	pm.addParam(param);
	
	options = {};
	
	var param = new FieldDate("create_date",options);
	
	pm.addParam(param);
	
	options = {};
	
	var param = new FieldString("email",options);
	
	pm.addParam(param);
	
	pm.addParam(new FieldInt("ret_id",{}));
	
	
}

			Client_Controller.prototype.addUpdate = function(){
	Client_Controller.superclass.addUpdate.call(this);
	var param;
	var options;	
	var pm = this.getUpdate();
	options = {};
	options["alias"]="Код";
	var param = new FieldInt("id",options);
	
	pm.addParam(param);
	
	
	param = new FieldInt("old_id",{});
	pm.addParam(param);
	
	options = {};
	options["alias"]="Наименование";
	var param = new FieldString("name",options);
	
	pm.addParam(param);
	
	
	options = {};
	options["alias"]="Полное наименование";
	var param = new FieldText("name_full",options);
	
	pm.addParam(param);
	
	
	options = {};
	options["alias"]="Сотовый телефон";
	var param = new FieldString("phone_cel",options);
	
	pm.addParam(param);
	
	
	options = {};
	options["alias"]="Менеджер";
	var param = new FieldInt("manager_id",options);
	
	pm.addParam(param);
	
	
	options = {};
	
	var param = new FieldDate("create_date",options);
	
	pm.addParam(param);
	
	
	options = {};
	
	var param = new FieldString("email",options);
	
	pm.addParam(param);
	
	
	
}

			Client_Controller.prototype.addDelete = function(){
	Client_Controller.superclass.addDelete.call(this);
	var options = {"required":true};
	
	var pm = this.getDelete();
	pm.addParam(new FieldInt("id",options));
}

			Client_Controller.prototype.addGetList = function(){
	Client_Controller.superclass.addGetList.call(this);
	var options = {};
	
	var pm = this.getGetList();
	pm.addParam(new FieldInt("id",options));
	pm.addParam(new FieldString("name",options));
	pm.addParam(new FieldString("phone_cel",options));
}

			Client_Controller.prototype.addGetObject = function(){
	Client_Controller.superclass.addGetObject.call(this);
	var options = {};
	
	var pm = this.getGetObject();
	pm.addParam(new FieldInt("id",options));
}

			Client_Controller.prototype.addComplete = function(){
	Client_Controller.superclass.addComplete.call(this);
	
	var options = {};
	
	var pm = this.getComplete();
	pm.addParam(new FieldString("name",options));
	pm.getParamById(this.PARAM_ORD_FIELDS).setValue("name");
}

		