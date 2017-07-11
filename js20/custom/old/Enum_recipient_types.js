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

function Enum_recipient_types(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	var multy_lang_values = {"ru_self":"я получатель"
,"ru_other":"другой человек"
};
	options.options = [{"value":"self",
"descr":multy_lang_values[options.app.getLocale()+"_"+"self"],
checked:(options.defaultValue&&options.defaultValue=="self")}
,{"value":"other",
"descr":multy_lang_values[options.app.getLocale()+"_"+"other"],
checked:(options.defaultValue&&options.defaultValue=="other")}
];
	
	Enum_recipient_types.superclass.constructor.call(this,id,options);
	
}
extend(Enum_recipient_types,EditSelect);

