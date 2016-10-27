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

function Enum_report_types(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	options.options = [{"value":"material_actions","descr":"Движение материалов",checked:(options.defaultValue&&options.defaultValue=="material_actions")}
];
	
	Enum_role_types.superclass.constructor.call(this,id,options);
	
}
extend(Enum_report_types,EditSelect);

