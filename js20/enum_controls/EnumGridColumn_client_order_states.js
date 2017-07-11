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

function EnumGridColumn_client_order_states(id,options){
	options = options || {};
	
	options.multyLangValues = {};
	
	options.multyLangValues.ru = {};

	options.multyLangValues.ru.to_noone = "Не обработан";

	options.multyLangValues.ru.checked = "Проверен";

	options.multyLangValues.ru.to_florist = "Букет составлен";

	options.multyLangValues.ru.to_courier = "Забрал курьер";

	options.multyLangValues.ru.closed = "Выполнен";
EnumGridColumn_client_order_states.superclass.constructor.call(this,id,options);
	
}
extend(EnumGridColumn_client_order_states,GridColumnEnum);

