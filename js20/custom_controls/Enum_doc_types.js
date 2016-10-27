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
	options.options = [{"value":"production","descr":"Комплектация",checked:(options.defaultValue&&options.defaultValue=="production")}
,{"value":"product_disposal","descr":"Разукомплектация",checked:(options.defaultValue&&options.defaultValue=="product_disposal")}
,{"value":"material_procurement","descr":"Поступление материалов",checked:(options.defaultValue&&options.defaultValue=="material_procurement")}
,{"value":"material_disposal","descr":"Списание материалов",checked:(options.defaultValue&&options.defaultValue=="material_disposal")}
,{"value":"sale","descr":"Продажа",checked:(options.defaultValue&&options.defaultValue=="sale")}
,{"value":"product_order","descr":"Заказ на производство",checked:(options.defaultValue&&options.defaultValue=="product_order")}
,{"value":"material_order","descr":"Заказ материалов",checked:(options.defaultValue&&options.defaultValue=="material_order")}
,{"value":"expence","descr":"Затраты",checked:(options.defaultValue&&options.defaultValue=="expence")}
,{"value":"doc_client_order","descr":"Заказы покупателей",checked:(options.defaultValue&&options.defaultValue=="doc_client_order")}
];
	
	Enum_role_types.superclass.constructor.call(this,id,options);
	
}
extend(Enum_doc_types,EditSelect);

