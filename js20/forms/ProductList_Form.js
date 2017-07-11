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
function ProductList_Form(options){
	options = options || {};	
	
	options.formName = "ProductList";
	options.controller = "Product_Controller";
	options.method = "get_list";
	
	ProductList_Form.superclass.constructor.call(this,options);
		
}
extend(ProductList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

