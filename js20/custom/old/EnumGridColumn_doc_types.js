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

function EnumGridColumn_doc_types(id,options){
	options = options || {};
	
	options.multyLangValues = {};
	
	options.multyLangValues.rus = {};

	options.multyLangValues.rus.production = "Комплектация";

	options.multyLangValues.rus.product_disposal = "Разукомплектация";

	options.multyLangValues.rus.material_procurement = "Поступление материалов";

	options.multyLangValues.rus.material_disposal = "Списание материалов";

	options.multyLangValues.rus.sale = "Продажа";

	options.multyLangValues.rus.expence = "Затраты";

	options.multyLangValues.rus.doc_client_order = "Заказы покупателей";
EnumGridColumn_doc_types.superclass.constructor.call(this,id,options);
	
}
extend(EnumGridColumn_doc_types,GridColumnEnum);

