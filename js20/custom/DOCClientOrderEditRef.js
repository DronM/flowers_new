/* Copyright (c) 2016 
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
 * @requires 
 * @requires core/extend.js  
*/

/* constructor
@param string id
@param object options{

}
*/

function DOCClientOrderEditRef(id,options){
	options = options || {};
		
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Заказ покупателя:";
	}
	
	options.cmdInsert = (options.cmdInsert!=undefined)? options.cmdInsert:false;
	
	options.keyIds = options.keyIds || ["id"];
	
	//форма выбора из списка
	options.selectWinClass = options.selectWinClass || DOCClientOrderList_Form;
	options.selectKeyIds = options.selectKeyIds;
	options.selectDescrIds = ["doc_client_order_descr"];
	//options.selectDescrFunction = this.m_formatFunction;
	
	
	//форма редактирования элемента
	options.editWinClass = DOCProduction_Form;
	
	options.cmdAutoComplete = false;
	
	DOCClientOrderEditRef.superclass.constructor.call(this,id,options);
}
extend(DOCClientOrderEditRef,EditRef);

/* Constants */


/* private members */

/* protected*/


/* public methods */
