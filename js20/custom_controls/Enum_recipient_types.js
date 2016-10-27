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

function Enum_recipient_types(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	options.options = [{"value":"self","descr":"я получатель",checked:(options.defaultValue&&options.defaultValue=="self")}
,{"value":"other","descr":"другой человек",checked:(options.defaultValue&&options.defaultValue=="other")}
];
	
	Enum_role_types.superclass.constructor.call(this,id,options);
	
}
extend(Enum_recipient_types,EditSelect);

