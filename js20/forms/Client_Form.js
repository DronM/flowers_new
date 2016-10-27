/* Copyright (c) 2016 
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
function Client_Form(options){
	options = options || {};	
	
	options.width = 900;
	options.formName = "ClientDialog";
	options.method = "get_object";
	options.controller = "Client_Controller";
	
	Client_Form.superclass.constructor.call(this,options);
}
extend(Client_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

