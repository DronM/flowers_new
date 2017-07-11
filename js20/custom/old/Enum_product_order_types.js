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

function Enum_product_order_types(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	options.options = [{"value":"sale","descr":"Продажа",checked:(options.defaultValue&&options.defaultValue=="sale")}
,{"value":"disposal","descr":"Списание",checked:(options.defaultValue&&options.defaultValue=="disposal")}
,{"value":"manual","descr":"Вручную",checked:(options.defaultValue&&options.defaultValue=="manual")}
];
	
	Enum_role_types.superclass.constructor.call(this,id,options);
	
}
extend(Enum_product_order_types,EditSelect);

