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
function ExpenceTypeList_Form(options){
	options = options || {};	
	
	options.formName = "ExpenceTypeList";
	options.controller = "ExpenceType_Controller";
	options.method = "get_list";
	
	ExpenceTypeList_Form.superclass.constructor.call(this,options);
		
}
extend(ExpenceTypeList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

