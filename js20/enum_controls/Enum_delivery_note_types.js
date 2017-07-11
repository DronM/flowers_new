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

function Enum_delivery_note_types(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	var multy_lang_values = {"ru_by_call":"звонок"
,"ru_by_sms":"SMS"
};
	options.options = [{"value":"by_call",
"descr":multy_lang_values[options.app.getLocale()+"_"+"by_call"],
checked:(options.defaultValue&&options.defaultValue=="by_call")}
,{"value":"by_sms",
"descr":multy_lang_values[options.app.getLocale()+"_"+"by_sms"],
checked:(options.defaultValue&&options.defaultValue=="by_sms")}
];
	
	Enum_delivery_note_types.superclass.constructor.call(this,id,options);
	
}
extend(Enum_delivery_note_types,EditSelect);

