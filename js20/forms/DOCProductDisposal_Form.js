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
function DOCProductDisposal_Form(options){
	options = options || {};	
	
	options.formName = "DOCProductDisposal";
	options.method = "get_object";
	
	DOCProductDisposal_Form.superclass.constructor.call(this,options);
}
extend(DOCProductDisposal_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

