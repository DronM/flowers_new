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


function SupplierEditRef(id,options){
	options = options || {};	
	options.labelCaption = options.labelCaption || "Поставщик:";
	options.cmdInsert = (options.cmdInsert!=undefined)? options.cmdInsert:false;
	
	options.keyIds = options.keyIds || ["id"];
	
	//форма выбора из списка
	options.selectWinClass = SupplierList_Form;
	options.selectDescrIds = options.selectDescrIds || ["name"];
	
	//форма редактирования элемента
	options.editWinClass = Supplier_Form;
	
	options.acMinLengthForQuery = 1;
	options.acController = new Supplier_Controller(options.app);
	options.acModel = new SupplierList_Model();
	options.acPatternFieldId = options.acPatternFieldId || "name";
	options.acKeyFields = options.acKeyFields || [options.acModel.getField("id")];
	options.acDescrFields = options.acDescrFields || [options.acModel.getField("name")];
	options.acICase = options.acICase || "1";
	options.acMid = options.acMid || "1";
	
	SupplierEditRef.superclass.constructor.call(this,id,options);
}
extend(SupplierEditRef,EditRef);

/* Constants */


/* private members */

/* protected*/


/* public methods */

