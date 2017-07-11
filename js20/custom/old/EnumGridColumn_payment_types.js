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

function EnumGridColumn_payment_types(id,options){
	options = options || {};
	
	options.multyLangValues = {};
	
	options.multyLangValues.rus = {};

	options.multyLangValues.rus.cash = "Наличными";

	options.multyLangValues.rus.bank = "Банковской картой";

	options.multyLangValues.rus.yandex = "Яндекс деньги";

	options.multyLangValues.rus.trans_to_card = "Перевод на карту";

	options.multyLangValues.rus.web_money = "Web money";
EnumGridColumn_payment_types.superclass.constructor.call(this,id,options);
	
}
extend(EnumGridColumn_payment_types,GridColumnEnum);

