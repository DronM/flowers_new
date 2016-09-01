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

function DOCProductOrder_Controller(app,options){
	options = options || {};
	options.listModelId = "DOCProductOrderList_Model";
	options.objModelId = "DOCProductOrderList_Model";
	DOCProductOrder_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.add_get_actions();
		
}
extend(DOCProductOrder_Controller,ControllerDb);

			DOCProductOrder_Controller.prototype.addInsert = function(){
	DOCProductOrder_Controller.superclass.addInsert.call(this);
	var field;
	var options;
	
	var pm = this.getInsert();
	
}

			DOCProductOrder_Controller.prototype.addUpdate = function(){
	DOCProductOrder_Controller.superclass.addUpdate.call(this);
	var field;
	var options;	
	var pm = this.getUpdate();
	
}

			DOCProductOrder_Controller.prototype.addDelete = function(){
	DOCProductOrder_Controller.superclass.addDelete.call(this);
	var options = {"required":true};
	
	var pm = this.getDelete();
}

			DOCProductOrder_Controller.prototype.addGetList = function(){
	DOCProductOrder_Controller.superclass.addGetList.call(this);
	var options = {};
	
	var pm = this.getGetList();
}

			DOCProductOrder_Controller.prototype.addGetObject = function(){
	DOCProductOrder_Controller.superclass.addGetObject.call(this);
	var options = {};
	
	var pm = this.getGetObject();
}

			DOCProductOrder_Controller.prototype.add_get_actions = function(){
	var pm = new PublicMethod('get_actions',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_id",options));
	
			
}
						
		