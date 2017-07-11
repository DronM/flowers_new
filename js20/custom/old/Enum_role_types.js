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

function Enum_role_types(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	var multy_lang_values = {"ru_admin":"Администратор"
,"ru_store_manager":"Администратор салона"
,"ru_florist":"Флорист"
,"ru_cashier":"Продавец"
};
	options.options = [{"value":"admin",
"descr":multy_lang_values[options.app.getLocale()+"_"+"admin"],
checked:(options.defaultValue&&options.defaultValue=="admin")}
,{"value":"store_manager",
"descr":multy_lang_values[options.app.getLocale()+"_"+"store_manager"],
checked:(options.defaultValue&&options.defaultValue=="store_manager")}
,{"value":"florist",
"descr":multy_lang_values[options.app.getLocale()+"_"+"florist"],
checked:(options.defaultValue&&options.defaultValue=="florist")}
,{"value":"cashier",
"descr":multy_lang_values[options.app.getLocale()+"_"+"cashier"],
checked:(options.defaultValue&&options.defaultValue=="cashier")}
];
	
	Enum_role_types.superclass.constructor.call(this,id,options);
	
}
extend(Enum_role_types,EditSelect);

