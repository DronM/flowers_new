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

function EnumGridColumn_message_types(id,options){
	options = options || {};
	
	options.multyLangValues = {};
	
	options.multyLangValues.rus = {};

	options.multyLangValues.rus.error = "Ошибка";

	options.multyLangValues.rus.warning = "Предупреждение";

	options.multyLangValues.rus.info = "Информация";
EnumGridColumn_message_types.superclass.constructor.call(this,id,options);
	
}
extend(EnumGridColumn_message_types,GridColumnEnum);

