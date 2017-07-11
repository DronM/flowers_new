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
	
	options.multyLangValues.ru = {};

	options.multyLangValues.ru.error = "Ошибка";

	options.multyLangValues.ru.warning = "Предупреждение";

	options.multyLangValues.ru.info = "Информация";
EnumGridColumn_message_types.superclass.constructor.call(this,id,options);
	
}
extend(EnumGridColumn_message_types,GridColumnEnum);

