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
	options.options = [{"value":"cur_shift","descr":"Текущая смена",checked:(options.defaultValue&&options.defaultValue=="cur_shift")}
,{"value":"cur_date","descr":"Текущая дата",checked:(options.defaultValue&&options.defaultValue=="cur_date")}
,{"value":"cur_week","descr":"Текущая неделя",checked:(options.defaultValue&&options.defaultValue=="cur_week")}
,{"value":"cur_month","descr":"Текущий месяц",checked:(options.defaultValue&&options.defaultValue=="cur_month")}
,{"value":"cur_quarter","descr":"Текущий квартал",checked:(options.defaultValue&&options.defaultValue=="cur_quarter")}
,{"value":"cur_year","descr":"Текущий год",checked:(options.defaultValue&&options.defaultValue=="cur_year")}
];
	
	Enum_role_types.superclass.constructor.call(this,id,options);
	
}
extend(Enum_def_date_types,EditSelect);

