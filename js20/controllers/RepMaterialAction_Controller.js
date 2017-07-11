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

function RepMaterialAction_Controller(app,options){
	options = options || {};
	RepMaterialAction_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addGetObject();
		
}
extend(RepMaterialAction_Controller,ControllerDb);

			RepMaterialAction_Controller.prototype.addGetObject = function(){
	RepMaterialAction_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
}

		