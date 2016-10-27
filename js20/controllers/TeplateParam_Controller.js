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

function TeplateParam_Controller(servConnector){
	options = {};
	options["listModelId"] = "TeplateParamList_Model";
	TeplateParam_Controller.superclass.constructor.call(this,"TeplateParam_Controller",servConnector,options);	
	
	//methods
	this.addGetList();
	this.add_set_value();
	
}
extend(TeplateParam_Controller,ControllerDb);

			TeplateParam_Controller.prototype.addGetList = function(){
	TeplateParam_Controller.superclass.addGetList.call(this);
	var options = {};
	
	var pm = this.getGetList();
		var options = {};
						
		pm.addParam(new FieldString("template",options));
	
}

			TeplateParam_Controller.prototype.add_set_value = function(){
	var pm = this.addMethodById('set_value');
	
				
		pm.addParam(new FieldString("template"));
	
				
		pm.addParam(new FieldString("param"));
	
				
		pm.addParam(new FieldText("val"));
	
			
}

		