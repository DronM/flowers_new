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
function SupplierList_Form(options){
	options = options || {};	
	
	options.width = 900;
	options.formName = "SupplierList";
	options.controller = "Supplier_Controller";
	options.method = "get_list";
	
	SupplierList_Form.superclass.constructor.call(this,options);
		
}
extend(SupplierList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

