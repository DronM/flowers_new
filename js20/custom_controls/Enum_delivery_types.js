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
	options.options = [{"value":"courier","descr":"курьер",checked:(options.defaultValue&&options.defaultValue=="courier")}
,{"value":"by_client","descr":"самовывоз",checked:(options.defaultValue&&options.defaultValue=="by_client")}
];
	
	Enum_role_types.superclass.constructor.call(this,id,options);
	
}
extend(Enum_delivery_types,EditSelect);

