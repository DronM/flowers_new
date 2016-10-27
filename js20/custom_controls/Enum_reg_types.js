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
	options.options = [{"value":"material","descr":"Учет материалов",checked:(options.defaultValue&&options.defaultValue=="material")}
,{"value":"product","descr":"Учет продукции",checked:(options.defaultValue&&options.defaultValue=="product")}
,{"value":"product_order","descr":"Учет заказов",checked:(options.defaultValue&&options.defaultValue=="product_order")}
,{"value":"material_cost","descr":"Себестоимость материалов",checked:(options.defaultValue&&options.defaultValue=="material_cost")}
,{"value":"material_sale","descr":"Продажи материалов",checked:(options.defaultValue&&options.defaultValue=="material_sale")}
,{"value":"product_sale","descr":"Продажи букетов",checked:(options.defaultValue&&options.defaultValue=="product_sale")}
];
	
	Enum_role_types.superclass.constructor.call(this,id,options);
	
}
extend(Enum_reg_types,EditSelect);

