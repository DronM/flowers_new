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
		
	options.labelCaption = options.labelCaption || "Комплектация:";
	options.cmdInsert = (options.cmdInsert!=undefined)? options.cmdInsert:false;
	
	options.keyIds = options.keyIds || ["id"];
	
	//форма выбора из списка
	options.selectWinClass = DOCProductionList_Form;
	options.selectDescrIds = options.selectDescrIds || ["name"];
	
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

