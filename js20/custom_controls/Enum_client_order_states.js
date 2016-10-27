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

function Enum_client_order_states(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	options.options = [{"value":"to_noone","descr":"Не обработан",checked:(options.defaultValue&&options.defaultValue=="to_noone")}
,{"value":"to_florist","descr":"Букет составлен",checked:(options.defaultValue&&options.defaultValue=="to_florist")}
,{"value":"to_courier","descr":"Забрал курьер",checked:(options.defaultValue&&options.defaultValue=="to_courier")}
,{"value":"closed","descr":"Выполнен",checked:(options.defaultValue&&options.defaultValue=="closed")}
];
	
	Enum_role_types.superclass.constructor.call(this,id,options);
	
}
extend(Enum_client_order_states,EditSelect);

