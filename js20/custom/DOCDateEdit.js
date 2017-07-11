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
	
	var tm = options.value;
	if (tm==undefined){
		tm = DateHelper.time();
		tm.setHours(0,0,0,0);
	}	
	options.value = tm;
	
	options.labelCaption = options.labelCaption || "от:";
	options.contClassName = options.contClassName || "form-group";//options.app.getBsCol(3);
	DOCDateEdit.superclass.constructor.call(this,id,options);
}
extend(DOCDateEdit,EditDateTime);

/* Constants */


/* private members */

/* protected*/


/* public methods */

