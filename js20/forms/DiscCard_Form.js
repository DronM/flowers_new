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
function DiscCard_Form(options){
	options = options || {};	
	
	options.formName = "DiscCard";
	options.method = "get_object";
	
	DiscCard_Form.superclass.constructor.call(this,options);
}
extend(DiscCard_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

