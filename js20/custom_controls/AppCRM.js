/* Copyright (c) 2016 
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
 * @requires core/extend.js
 * @requires core/App.js
*/

/* constructor */
function AppCRM(options){
	options = options || {};
	options.lang = "rus";
	AppCRM.superclass.constructor.call(this,"CRM",options);
}
extend(AppCRM,App);

/* Constants */


/* private members */

/* protected*/


/* public methods */
AppCRM.prototype.formatError = function(erCode,erStr){
	return (erStr +( (erCode)? (", код:"+erCode):"" ) );
}

