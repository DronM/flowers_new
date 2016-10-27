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

function Enum_payment_types(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	options.options = [{"value":"cash","descr":"Наличными",checked:(options.defaultValue&&options.defaultValue=="cash")}
,{"value":"bank","descr":"Банковской картой",checked:(options.defaultValue&&options.defaultValue=="bank")}
,{"value":"yandex","descr":"Яндекс деньги",checked:(options.defaultValue&&options.defaultValue=="yandex")}
,{"value":"trans_to_card","descr":"Перевод на карту",checked:(options.defaultValue&&options.defaultValue=="trans_to_card")}
,{"value":"web_money","descr":"Web money",checked:(options.defaultValue&&options.defaultValue=="web_money")}
];
	
	Enum_role_types.superclass.constructor.call(this,id,options);
	
}
extend(Enum_payment_types,EditSelect);

