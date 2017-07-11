/* Copyright (c) 2017 
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
 * @requires 
 * @requires core/extend.js
 * @requires controls/WindowForm.js     
*/

/* constructor
@param string id
@param object options{

}
*/
function ClientConfig_Form(options){
	options = options || {};	
	
	options.formName = "ClientConfig";
	options.method = "get_object";
	options.controller = "ClientConfig_Controller";
	
	ClientConfig_Form.superclass.constructor.call(this,options);
}
extend(ClientConfig_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

