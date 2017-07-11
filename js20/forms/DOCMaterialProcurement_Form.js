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
function DOCMaterialProcurement_Form(options){
	options = options || {};	
	
	options.formName = "DOCMaterialProcurement";
	options.method = "get_object";
	
	DOCMaterialProcurement_Form.superclass.constructor.call(this,options);
}
extend(DOCMaterialProcurement_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

