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
function ClientList_Form(options){
	options = options || {};	
	
	options.formName = "ClientList";
	options.controller = "Client_Controller";
	options.method = "get_list";
	
	ClientList_Form.superclass.constructor.call(this,options);
		
}
extend(ClientList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

