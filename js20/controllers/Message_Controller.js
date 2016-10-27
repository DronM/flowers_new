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

function Message_Controller(servConnector){
	options = {};
	Message_Controller.superclass.constructor.call(this,"Message_Controller",servConnector,options);	
	
	//methods
	this.add_get_headers();
	
}
extend(Message_Controller,ControllerDb);

			Message_Controller.prototype.add_get_headers = function(){
	var pm = this.addMethodById('get_headers');
	
}

		