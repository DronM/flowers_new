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

function Enum_doc_types(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	var multy_lang_values = {"ru_production":"Комплектация"
,"ru_product_disposal":"Разукомплектация"
,"ru_material_procurement":"Поступление материалов"
,"ru_material_disposal":"Списание материалов"
,"ru_sale":"Продажа"
,"ru_expence":"Затраты"
,"ru_doc_client_order":"Заказы покупателей"
};
	options.options = [{"value":"production",
"descr":multy_lang_values[options.app.getLocale()+"_"+"production"],
checked:(options.defaultValue&&options.defaultValue=="production")}
,{"value":"product_disposal",
"descr":multy_lang_values[options.app.getLocale()+"_"+"product_disposal"],
checked:(options.defaultValue&&options.defaultValue=="product_disposal")}
,{"value":"material_procurement",
"descr":multy_lang_values[options.app.getLocale()+"_"+"material_procurement"],
checked:(options.defaultValue&&options.defaultValue=="material_procurement")}
,{"value":"material_disposal",
"descr":multy_lang_values[options.app.getLocale()+"_"+"material_disposal"],
checked:(options.defaultValue&&options.defaultValue=="material_disposal")}
,{"value":"sale",
"descr":multy_lang_values[options.app.getLocale()+"_"+"sale"],
checked:(options.defaultValue&&options.defaultValue=="sale")}
,{"value":"expence",
"descr":multy_lang_values[options.app.getLocale()+"_"+"expence"],
checked:(options.defaultValue&&options.defaultValue=="expence")}
,{"value":"doc_client_order",
"descr":multy_lang_values[options.app.getLocale()+"_"+"doc_client_order"],
checked:(options.defaultValue&&options.defaultValue=="doc_client_order")}
];
	
	Enum_doc_types.superclass.constructor.call(this,id,options);
	
}
extend(Enum_doc_types,EditSelect);

