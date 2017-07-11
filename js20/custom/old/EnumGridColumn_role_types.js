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

function EnumGridColumn_role_types(id,options){
	options = options || {};
	
	options.multyLangValues = {};
	
	options.multyLangValues.rus = {};

	options.multyLangValues.rus.admin = "Администратор";

	options.multyLangValues.rus.store_manager = "Администратор салона";

	options.multyLangValues.rus.florist = "Флорист";

	options.multyLangValues.rus.cashier = "Продавец";
EnumGridColumn_role_types.superclass.constructor.call(this,id,options);
	
}
extend(EnumGridColumn_role_types,GridColumnEnum);

