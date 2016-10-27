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
function DOCProductionDOCTMaterialInline_View(id,options){
	options = options || {};	
	
	DOCProductionDOCTMaterialInline_View.superclass.constructor.call(this,id,options);
}
extend(DOCProductionDOCTMaterialInline_View, ViewGridEditInlineAjx);

/* Constants */


/* private members */

/* protected*/


/* public methods */
ViewGridEditInlineAjx.prototype.addEditControls = function(){
	this.addElement(new Control(this.getId()+":number","div",{"app":this.getApp()}));
	
	this.addElement(new EditString(this.getId()+":metarial",{"app":this.getApp()}));
	
	this.addElement(new EditFloat(this.getId()+":quant",{"app":this.getApp()}));
}
