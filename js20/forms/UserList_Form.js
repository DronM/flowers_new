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
function UserList_Form(options){
	options = options || {};	
	
	options.formName = "UserList";
	options.controller = "User_Controller";
	options.method = "get_list";
	
	UserList_Form.superclass.constructor.call(this,options);
		
}
extend(UserList_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

