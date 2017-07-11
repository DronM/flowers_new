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

function Enum_message_types(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	var multy_lang_values = {"ru_error":"Ошибка"
,"ru_warning":"Предупреждение"
,"ru_info":"Информация"
};
	options.options = [{"value":"error",
"descr":multy_lang_values[options.app.getLocale()+"_"+"error"],
checked:(options.defaultValue&&options.defaultValue=="error")}
,{"value":"warning",
"descr":multy_lang_values[options.app.getLocale()+"_"+"warning"],
checked:(options.defaultValue&&options.defaultValue=="warning")}
,{"value":"info",
"descr":multy_lang_values[options.app.getLocale()+"_"+"info"],
checked:(options.defaultValue&&options.defaultValue=="info")}
];
	
	Enum_message_types.superclass.constructor.call(this,id,options);
	
}
extend(Enum_message_types,EditSelect);

