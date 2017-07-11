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
function QuantEdit_View(id,options){
	options = options || {};	
	
	options.elements = [new EditFloat(id+":quant",{
		"labelCaption":this.QUANT_CAP,
		"value":options.defValue,
		"focus":true,
		"app":options.app
		})
	];
	
	QuantEdit_View.superclass.constructor.call(this,id,"div",options);
}
extend (QuantEdit_View,ControlContainer);
/* Constants */


/* private members */

/* protected*/


/* public methods */

