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

function Enum_delivery_note_types(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	options.options = [{"value":"by_call","descr":"звонок",checked:(options.defaultValue&&options.defaultValue=="by_call")}
,{"value":"by_sms","descr":"SMS",checked:(options.defaultValue&&options.defaultValue=="by_sms")}
];
	
	Enum_role_types.superclass.constructor.call(this,id,options);
	
}
extend(Enum_delivery_note_types,EditSelect);

