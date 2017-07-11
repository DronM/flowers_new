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
	
	options.multyLangValues.ru = {};

	options.multyLangValues.ru.production = "Комплектация";

	options.multyLangValues.ru.product_disposal = "Разукомплектация";

	options.multyLangValues.ru.material_procurement = "Поступление материалов";

	options.multyLangValues.ru.material_disposal = "Списание материалов";

	options.multyLangValues.ru.sale = "Продажа";

	options.multyLangValues.ru.expence = "Затраты";

	options.multyLangValues.ru.doc_client_order = "Заказы покупателей";
EnumGridColumn_doc_types.superclass.constructor.call(this,id,options);
	
}
extend(EnumGridColumn_doc_types,GridColumnEnum);

