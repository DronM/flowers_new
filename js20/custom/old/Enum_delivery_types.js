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

function Enum_delivery_types(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	var multy_lang_values = {"ru_courier":"курьер"
,"ru_by_client":"самовывоз"
};
	options.options = [{"value":"courier",
"descr":multy_lang_values[options.app.getLocale()+"_"+"courier"],
checked:(options.defaultValue&&options.defaultValue=="courier")}
,{"value":"by_client",
"descr":multy_lang_values[options.app.getLocale()+"_"+"by_client"],
checked:(options.defaultValue&&options.defaultValue=="by_client")}
];
	
	Enum_delivery_types.superclass.constructor.call(this,id,options);
	
}
extend(Enum_delivery_types,EditSelect);

