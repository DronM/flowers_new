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
function DOCSale_Form(options){
	options = options || {};	
	
	options.formName = "DOCSale";
	options.method = "get_object";
	
	DOCSale_Form.superclass.constructor.call(this,options);
}
extend(DOCSale_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

