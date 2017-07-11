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


function DiscCardEditRef(id,options){
	options = options || {};	
	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Диск.карта:";
	}
	
	options.cmdOpen = true;
	options.cmdInsert = false;
	
	options.keyIds = options.keyIds || ["id"];
	
	//форма выбора из списка
	options.selectWinClass = null;
	options.selectDescrIds = null;
	
	//форма редактирования элемента
	options.editWinClass = DiscCard_Form;
	
	options.acMinLengthForQuery = 1;
	options.acController = new DiscCard_Controller(options.app);
	options.acModel = new DiscCard_Model();
	options.acPatternFieldId = options.acPatternFieldId || "barcode";
	options.acKeyFields = options.acKeyFields || [options.acModel.getField("id")];
	options.acDescrFields = options.acDescrFields || [options.acModel.getField("barcode")];
	options.acICase = options.acICase || "1";
	options.acMid = options.acMid || "1";
	
	DiscCardEditRef.superclass.constructor.call(this,id,options);
}
extend(DiscCardEditRef,EditRef);

/* Constants */


/* private members */

/* protected*/


/* public methods */

