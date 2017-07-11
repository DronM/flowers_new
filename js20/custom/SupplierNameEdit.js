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
function SupplierNameEdit(id,options){
	options = options || {};

	options.labelCaption = "Наименование:",
	options.placeholder = "Краткое наименование поставщика",
	options.maxlength = 100;
	
	SupplierNameEdit.superclass.constructor.call(this,id,options);
	
}
extend(SupplierNameEdit,EditString);

