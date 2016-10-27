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
function User_Form(options){
	options = options || {};	
	
	options.width = 900;
	options.formName = "UserDialog";
	options.controller = "User_Controller";
	options.method = "get_object";
	
	User_Form.superclass.constructor.call(this,options);
	
}
extend(User_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

