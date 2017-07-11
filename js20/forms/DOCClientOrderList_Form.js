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
function DOCClientOrderList_Form(options){
	options = options || {};	
	
	options.formName = "DOCClientOrderList";
	options.controller = "DOCClientOrder_Controller";
	options.method = "get_list";
	
	DOCClientOrderList_Form.superclass.constructor.call(this,options);
		
}
extend(DOCClientOrderList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

