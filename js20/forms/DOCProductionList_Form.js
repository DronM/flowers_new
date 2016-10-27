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
function DOCProductionList_Form(options){
	options = options || {};	
	
	options.width = 900;
	options.formName = "DOCProductionList";
	options.controller = "DOCProduction_Controller";
	options.method = "get_list";
	
	DOCProductionList_Form.superclass.constructor.call(this,options);
		
}
extend(DOCProductionList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

