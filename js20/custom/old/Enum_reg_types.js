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

function Enum_reg_types(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	var multy_lang_values = {"ru_material":"Учет материалов"
,"ru_product":"Учет продукции"
,"ru_client_order":"Учет заказов клиентов"
};
	options.options = [{"value":"material",
"descr":multy_lang_values[options.app.getLocale()+"_"+"material"],
checked:(options.defaultValue&&options.defaultValue=="material")}
,{"value":"product",
"descr":multy_lang_values[options.app.getLocale()+"_"+"product"],
checked:(options.defaultValue&&options.defaultValue=="product")}
,{"value":"client_order",
"descr":multy_lang_values[options.app.getLocale()+"_"+"client_order"],
checked:(options.defaultValue&&options.defaultValue=="client_order")}
];
	
	Enum_reg_types.superclass.constructor.call(this,id,options);
	
}
extend(Enum_reg_types,EditSelect);

