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

function Enum_client_order_states(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	var multy_lang_values = {"ru_to_noone":"Не обработан"
,"ru_checked":"Проверен"
,"ru_to_florist":"Букет составлен"
,"ru_to_courier":"Забрал курьер"
,"ru_closed":"Выполнен"
};
	options.options = [{"value":"to_noone",
"descr":multy_lang_values[options.app.getLocale()+"_"+"to_noone"],
checked:(options.defaultValue&&options.defaultValue=="to_noone")}
,{"value":"checked",
"descr":multy_lang_values[options.app.getLocale()+"_"+"checked"],
checked:(options.defaultValue&&options.defaultValue=="checked")}
,{"value":"to_florist",
"descr":multy_lang_values[options.app.getLocale()+"_"+"to_florist"],
checked:(options.defaultValue&&options.defaultValue=="to_florist")}
,{"value":"to_courier",
"descr":multy_lang_values[options.app.getLocale()+"_"+"to_courier"],
checked:(options.defaultValue&&options.defaultValue=="to_courier")}
,{"value":"closed",
"descr":multy_lang_values[options.app.getLocale()+"_"+"closed"],
checked:(options.defaultValue&&options.defaultValue=="closed")}
];
	
	Enum_client_order_states.superclass.constructor.call(this,id,options);
	
}
extend(Enum_client_order_states,EditSelect);

