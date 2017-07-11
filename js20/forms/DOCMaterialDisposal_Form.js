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
function DOCMaterialDisposal_Form(options){
	options = options || {};	
	
	options.formName = "DOCMaterialDisposal";
	options.method = "get_object";
	
	DOCMaterialDisposal_Form.superclass.constructor.call(this,options);
}
extend(DOCMaterialDisposal_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

