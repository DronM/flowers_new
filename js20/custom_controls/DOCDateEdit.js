/* Copyright (c) 2016 
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
 * @requires 
 * @requires core/extend.js  
*/

/* constructor
@param string id
@param object options{

}
*/
function DOCDateEdit(id,options){
	options = options || {};	
	options.labelCaption="от:";
	options.contClassName = options.contClassName || options.app.getBsCol(3);
	DOCDateEdit.superclass.constructor.call(this,id,options);
}
extend(DOCDateEdit,EditDateTime);

/* Constants */


/* private members */

/* protected*/


/* public methods */

