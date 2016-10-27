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
function DOCProduction_Form(options){
	options = options || {};	
	
	//options.width = 1200;
	//options.height = 800;
	options.fullScreen = true;
	options.formName = "DOCProduction";
	options.method = "get_object";
	
	DOCProduction_Form.superclass.constructor.call(this,options);
}
extend(DOCProduction_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

