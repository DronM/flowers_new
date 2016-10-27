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
function ProductNameEdit(id,options){
	options = options || {};

	options.labelCaption = "Наименование:",
	options.placeholder = "Краткое наименование продукции",
	options.maxlength = 100;
	
	ProductNameEdit.superclass.constructor.call(this,id,options);
	
}
extend(ProductNameEdit,EditString);

