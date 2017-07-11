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

function EnumGridColumn_def_date_types(id,options){
	options = options || {};
	
	options.multyLangValues = {};
	
	options.multyLangValues.rus = {};

	options.multyLangValues.rus.cur_shift = "Текущая смена";

	options.multyLangValues.rus.cur_date = "Текущая дата";

	options.multyLangValues.rus.cur_week = "Текущая неделя";

	options.multyLangValues.rus.cur_month = "Текущий месяц";

	options.multyLangValues.rus.cur_quarter = "Текущий квартал";

	options.multyLangValues.rus.cur_year = "Текущий год";
EnumGridColumn_def_date_types.superclass.constructor.call(this,id,options);
	
}
extend(EnumGridColumn_def_date_types,GridColumnEnum);
