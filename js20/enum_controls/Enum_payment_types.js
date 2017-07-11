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
	var multy_lang_values = {"ru_cash":"Наличными"
,"ru_bank":"Банковской картой"
,"ru_yandex":"Яндекс деньги"
,"ru_trans_to_card":"Перевод на карту"
,"ru_web_money":"Web money"
};
	options.options = [{"value":"cash",
"descr":multy_lang_values[options.app.getLocale()+"_"+"cash"],
checked:(options.defaultValue&&options.defaultValue=="cash")}
,{"value":"bank",
"descr":multy_lang_values[options.app.getLocale()+"_"+"bank"],
checked:(options.defaultValue&&options.defaultValue=="bank")}
,{"value":"yandex",
"descr":multy_lang_values[options.app.getLocale()+"_"+"yandex"],
checked:(options.defaultValue&&options.defaultValue=="yandex")}
,{"value":"trans_to_card",
"descr":multy_lang_values[options.app.getLocale()+"_"+"trans_to_card"],
checked:(options.defaultValue&&options.defaultValue=="trans_to_card")}
,{"value":"web_money",
"descr":multy_lang_values[options.app.getLocale()+"_"+"web_money"],
checked:(options.defaultValue&&options.defaultValue=="web_money")}
];
	
	Enum_payment_types.superclass.constructor.call(this,id,options);
	
}
extend(Enum_payment_types,EditSelect);

