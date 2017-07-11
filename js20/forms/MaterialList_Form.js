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
function MaterialList_Form(options){
	options = options || {};	
	
	options.formName = "MaterialList";
	options.controller = "Material_Controller";
	options.method = "get_list";
	
	MaterialList_Form.superclass.constructor.call(this,options);
		
}
extend(MaterialList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

