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

/* constructor
@param object options{
	@param string modelDataStr
}
*/
function MaterialNameEdit(id,options){
	options = options || {};

	options.labelCaption = "Наименование:",
	options.placeholder = "Краткое наименование материала",
	options.maxlength = 50;
	
	MaterialNameEdit.superclass.constructor.call(this,id,options);
	
}
extend(MaterialNameEdit,EditString);

