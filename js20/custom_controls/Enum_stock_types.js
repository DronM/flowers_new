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

function Enum_stock_types(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	options.options = [{"value":"main","descr":"Основной",checked:(options.defaultValue&&options.defaultValue=="main")}
,{"value":"waste","descr":"Брак",checked:(options.defaultValue&&options.defaultValue=="waste")}
];
	
	Enum_role_types.superclass.constructor.call(this,id,options);
	
}
extend(Enum_stock_types,EditSelect);

