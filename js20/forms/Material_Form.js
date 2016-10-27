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
function Material_Form(options){
	options = options || {};	
	
	options.width = 900;
	options.formName = "Material";
	options.method = "get_object";
	
	Material_Form.superclass.constructor.call(this,options);
}
extend(Material_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

