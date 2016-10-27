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
	options.options = [{"value":"admin","descr":"Администратор",checked:(options.defaultValue&&options.defaultValue=="admin")}
,{"value":"store_manager","descr":"Администратор салона",checked:(options.defaultValue&&options.defaultValue=="store_manager")}
,{"value":"florist","descr":"Флорист",checked:(options.defaultValue&&options.defaultValue=="florist")}
,{"value":"cashier","descr":"Продавец",checked:(options.defaultValue&&options.defaultValue=="cashier")}
];
	
	Enum_role_types.superclass.constructor.call(this,id,options);
	
}
extend(Enum_role_types,EditSelect);

