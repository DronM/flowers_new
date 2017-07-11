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

function DOCProductionEditRef(id,options){
	options = options || {};
		
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Комплектация:";
	}
	options.cmdInsert = (options.cmdInsert!=undefined)? options.cmdInsert:false;
	
	options.keyIds = options.keyIds || ["id"];
	
	options.formatFunction = options.formatFunction || function(row){
		return this.getDescr(row.doc_production_number.getValue(),row.doc_production_date_time.getValue(),row.product_descr.getValue());
	};
	
	//форма выбора из списка
	options.selectWinClass = options.selectWinClass || DOCProductionList_Form;
	options.selectKeyIds = options.selectKeyIds;
	
	options.selectFormatFunction = options.selectFormatFunction || function(row){
		return this.getDescr(row.doc_production_number.getValue(),row.doc_production_date_time.getValue(),row.name.getValue());
	}
	//options.selectDescrIds = options.selectDescrIds || ["number","date_time"];
	//options.selectDescrFunction = this.m_formatFunction;
	
	
	//форма редактирования элемента
	options.editWinClass = DOCProduction_Form;
	
	options.cmdAutoComplete = false;
	
	DOCProductionEditRef.superclass.constructor.call(this,id,options);
}
extend(DOCProductionEditRef,EditRef);

/* Constants */


/* private members */

/* protected*/


/* public methods */
DOCProductionEditRef.prototype.getDescr = function(docNumber,docDate,prodDescr){
	return CommonHelper.format("№ % (%), %",
		[docNumber,DateHelper.format(docDate,this.getApp().getDateFormat()),prodDescr]
	);
}
