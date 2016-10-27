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

function Enum_message_types(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	options.options = [{"value":"error","descr":"Ошибка",checked:(options.defaultValue&&options.defaultValue=="error")}
,{"value":"warning","descr":"Предупреждение",checked:(options.defaultValue&&options.defaultValue=="warning")}
,{"value":"info","descr":"Информация",checked:(options.defaultValue&&options.defaultValue=="info")}
];
	
	Enum_role_types.superclass.constructor.call(this,id,options);
	
}
extend(Enum_message_types,EditSelect);

