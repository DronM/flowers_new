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
function DOCNumberEdit(id,options){
	options = options || {};	
	options.labelCaption="Номер:";
	options.contClassName = options.contClassName || options.app.getBsCol(3);
	options.labelClassName = options.app.getBsCol(5);
	options.editContClassName = "input-group "+options.app.getBsCol(5);  
	options.enabled = (options.enabled!=undefined)? options.enabled:false;
	options.cmdClear = false;
	options.maxlength = 10;
	
	DOCNumberEdit.superclass.constructor.call(this,id,options);
}
extend(DOCNumberEdit,EditString);

/* Constants */


/* private members */

/* protected*/


/* public methods */

