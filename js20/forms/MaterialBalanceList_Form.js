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
function MaterialBalanceList_Form(options){
	options = options || {};	
	
	options.formName = "MaterialBalanceList";
	options.controller = "Material_Controller";
	options.method = "get_list_with_balance";
	
	MaterialBalanceList_Form.superclass.constructor.call(this,options);
		
}
extend(MaterialBalanceList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

