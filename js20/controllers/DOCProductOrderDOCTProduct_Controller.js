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

function DOCProductOrderDOCTProduct_Controller(app,options){
	options = options || {};
	options.listModelId = "DOCProductOrderDOCTProductList_Model";
	options.objModelId = "DOCProductOrderDOCTProductList_Model";
	DOCProductOrderDOCTProduct_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
		
}
extend(DOCProductOrderDOCTProduct_Controller,ControllerDb);

			DOCProductOrderDOCTProduct_Controller.prototype.addInsert = function(){
	DOCProductOrderDOCTProduct_Controller.superclass.addInsert.call(this);
	var field;
	var options;
	
	var pm = this.getInsert();
	
}

			DOCProductOrderDOCTProduct_Controller.prototype.addUpdate = function(){
	DOCProductOrderDOCTProduct_Controller.superclass.addUpdate.call(this);
	var field;
	var options;	
	var pm = this.getUpdate();
	
}

			DOCProductOrderDOCTProduct_Controller.prototype.addDelete = function(){
	DOCProductOrderDOCTProduct_Controller.superclass.addDelete.call(this);
	var options = {"required":true};
	
	var pm = this.getDelete();
}

			DOCProductOrderDOCTProduct_Controller.prototype.addGetList = function(){
	DOCProductOrderDOCTProduct_Controller.superclass.addGetList.call(this);
	var options = {};
	
	var pm = this.getGetList();
}

			DOCProductOrderDOCTProduct_Controller.prototype.addGetObject = function(){
	DOCProductOrderDOCTProduct_Controller.superclass.addGetObject.call(this);
	var options = {};
	
	var pm = this.getGetObject();
}

		