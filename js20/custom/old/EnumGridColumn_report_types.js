/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
 * @requires core/extend.js
*/

/* constructor
@param string id
@param object options{
}
*/

function EnumGridColumn_report_types(id,options){
	options = options || {};
	
	options.multyLangValues = {};
	
	options.multyLangValues.rus = {};

	options.multyLangValues.rus.material_actions = "Движение материалов";
EnumGridColumn_report_types.superclass.constructor.call(this,id,options);
	
}
extend(EnumGridColumn_report_types,GridColumnEnum);

