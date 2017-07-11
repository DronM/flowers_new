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
function DOCClientOrder_Form(options){
	options = options || {};	
	
	options.formName = "DOCClientOrder";
	options.method = "get_object";
	
	DOCClientOrder_Form.superclass.constructor.call(this,options);
}
extend(DOCClientOrder_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

