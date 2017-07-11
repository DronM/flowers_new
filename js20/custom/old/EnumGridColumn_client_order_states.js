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
	
	options.multyLangValues.rus = {};

	options.multyLangValues.rus.to_noone = "Не обработан";

	options.multyLangValues.rus.checked = "Проверен";

	options.multyLangValues.rus.to_florist = "Букет составлен";

	options.multyLangValues.rus.to_courier = "Забрал курьер";

	options.multyLangValues.rus.closed = "Выполнен";
EnumGridColumn_client_order_states.superclass.constructor.call(this,id,options);
	
}
extend(EnumGridColumn_client_order_states,GridColumnEnum);

