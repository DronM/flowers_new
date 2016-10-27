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
function Supplier_Form(options){
	options = options || {};	
	
	options.width = 900;
	options.formName = "Supplier";
	options.method = "get_object";
	
	Supplier_Form.superclass.constructor.call(this,options);
}
extend(Supplier_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

