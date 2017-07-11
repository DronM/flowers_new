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

function DOCManager_Controller(app,options){
	options = options || {};
	options.listModel = DOCManagerList_Model;
	DOCManager_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.add_reprocess();
	this.addGetList();
	this.add_get_sequence_viol_list();
	this.add_get_reprocess_list();
		
}
extend(DOCManager_Controller,ControllerDb);

			DOCManager_Controller.prototype.add_reprocess = function(){
	var pm = new PublicMethod('reprocess',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldString("sequence_list",options));
	
			
}

			DOCManager_Controller.prototype.addGetList = function(){
	DOCManager_Controller.superclass.addGetList.call(this);
	
	
	
	var pm = this.getGetList();
}

			DOCManager_Controller.prototype.add_get_sequence_viol_list = function(){
	var pm = new PublicMethod('get_sequence_viol_list',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldString("sequence_list",options));
	
			
}

			DOCManager_Controller.prototype.add_get_reprocess_list = function(){
	var pm = new PublicMethod('get_reprocess_list',{controller:this});
	this.addPublicMethod(pm);
	
}

		