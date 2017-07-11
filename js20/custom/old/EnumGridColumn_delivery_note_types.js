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

function EnumGridColumn_delivery_note_types(id,options){
	options = options || {};
	
	options.multyLangValues = {};
	
	options.multyLangValues.rus = {};

	options.multyLangValues.rus.by_call = "звонок";

	options.multyLangValues.rus.by_sms = "SMS";
EnumGridColumn_delivery_note_types.superclass.constructor.call(this,id,options);
	
}
extend(EnumGridColumn_delivery_note_types,GridColumnEnum);

