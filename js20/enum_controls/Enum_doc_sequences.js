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

function Enum_doc_sequences(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	var multy_lang_values = {"ru_materials":"Учет материалов"
};
	options.options = [{"value":"materials",
"descr":multy_lang_values[options.app.getLocale()+"_"+"materials"],
checked:(options.defaultValue&&options.defaultValue=="materials")}
];
	
	Enum_doc_sequences.superclass.constructor.call(this,id,options);
	
}
extend(Enum_doc_sequences,EditSelect);

