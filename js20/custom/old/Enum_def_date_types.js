/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
 * @requires core/extend.js
 * @requires controls/EditSelect.js
*/

/* constructor */

function Enum_def_date_types(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	var multy_lang_values = {"ru_cur_shift":"Текущая смена"
,"ru_cur_date":"Текущая дата"
,"ru_cur_week":"Текущая неделя"
,"ru_cur_month":"Текущий месяц"
,"ru_cur_quarter":"Текущий квартал"
,"ru_cur_year":"Текущий год"
};
	options.options = [{"value":"cur_shift",
"descr":multy_lang_values[options.app.getLocale()+"_"+"cur_shift"],
checked:(options.defaultValue&&options.defaultValue=="cur_shift")}
,{"value":"cur_date",
"descr":multy_lang_values[options.app.getLocale()+"_"+"cur_date"],
checked:(options.defaultValue&&options.defaultValue=="cur_date")}
,{"value":"cur_week",
"descr":multy_lang_values[options.app.getLocale()+"_"+"cur_week"],
checked:(options.defaultValue&&options.defaultValue=="cur_week")}
,{"value":"cur_month",
"descr":multy_lang_values[options.app.getLocale()+"_"+"cur_month"],
checked:(options.defaultValue&&options.defaultValue=="cur_month")}
,{"value":"cur_quarter",
"descr":multy_lang_values[options.app.getLocale()+"_"+"cur_quarter"],
checked:(options.defaultValue&&options.defaultValue=="cur_quarter")}
,{"value":"cur_year",
"descr":multy_lang_values[options.app.getLocale()+"_"+"cur_year"],
checked:(options.defaultValue&&options.defaultValue=="cur_year")}
];
	
	Enum_def_date_types.superclass.constructor.call(this,id,options);
	
}
extend(Enum_def_date_types,EditSelect);

