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

function EnumGridColumn_reg_types(id,options){
	options = options || {};
	
	options.multyLangValues = {};
	
	options.multyLangValues.ru = {};

	options.multyLangValues.ru.material = "Учет материалов";

	options.multyLangValues.ru.product = "Учет продукции";

	options.multyLangValues.ru.client_order = "Учет заказов клиентов";
EnumGridColumn_reg_types.superclass.constructor.call(this,id,options);
	
}
extend(EnumGridColumn_reg_types,GridColumnEnum);

