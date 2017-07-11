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
function ProductBalanceList_Form(options){
	options = options || {};	
	
	options.formName = "ProductBalanceList";
	options.controller = "Product_Controller";
	options.method = "get_list_with_balance";
	
	ProductBalanceList_Form.superclass.constructor.call(this,options);
		
}
extend(ProductBalanceList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

