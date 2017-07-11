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
function DOCExpence_Form(options){
	options = options || {};	
	
	options.formName = "DOCExpence";
	options.method = "get_object";
	
	DOCExpence_Form.superclass.constructor.call(this,options);
}
extend(DOCExpence_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

