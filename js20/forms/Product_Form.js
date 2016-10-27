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
function Product_Form(options){
	options = options || {};	
	
	options.width = 900;
	options.height = 800;
	options.formName = "Product";
	options.method = "get_object";
	
	Product_Form.superclass.constructor.call(this,options);
}
extend(Product_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

