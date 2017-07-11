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

function EnumGridColumn_recipient_types(id,options){
	options = options || {};
	
	options.multyLangValues = {};
	
	options.multyLangValues.ru = {};

	options.multyLangValues.ru.self = "я получатель";

	options.multyLangValues.ru.other = "другой человек";
EnumGridColumn_recipient_types.superclass.constructor.call(this,id,options);
	
}
extend(EnumGridColumn_recipient_types,GridColumnEnum);

