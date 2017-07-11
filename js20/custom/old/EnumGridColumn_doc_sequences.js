/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
 * @requires core/extend.js
*/

/* constructor
@param string id
@param object options{
}
*/

function EnumGridColumn_doc_sequences(id,options){
	options = options || {};
	
	options.multyLangValues = {};
	
	options.multyLangValues.rus = {};

	options.multyLangValues.rus.materials = "Учет материалов";
EnumGridColumn_doc_sequences.superclass.constructor.call(this,id,options);
	
}
extend(EnumGridColumn_doc_sequences,GridColumnEnum);

