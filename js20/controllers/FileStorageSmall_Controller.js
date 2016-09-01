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

function FileStorageSmall_Controller(servConnector){
	options = {};
	FileStorageSmall_Controller.superclass.constructor.call(this,"FileStorageSmall_Controller",servConnector,options);	
	
	//methods
	this.add_add_file();
	this.add_set_file();
	this.add_get_file();
	
}
extend(FileStorageSmall_Controller,ControllerDb);

			FileStorageSmall_Controller.prototype.add_add_file = function(){
	var pm = this.addMethodById('add_file');
	
}

			FileStorageSmall_Controller.prototype.add_set_file = function(){
	var pm = this.addMethodById('set_file');
	
				
		pm.addParam(new FieldInt("id"));
	
			
}

			FileStorageSmall_Controller.prototype.add_get_file = function(){
	var pm = this.addMethodById('get_file');
	
				
		pm.addParam(new FieldInt("id"));
	
			
}
			
		