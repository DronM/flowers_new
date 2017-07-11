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
function ExpenceTypeEditRef(id,options){
	options = options || {};	
	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Статья затрат:";
	}
	
	options.cmdOpen = false;
	options.cmdInsert = (options.cmdInsert!=undefined)? options.cmdInsert:false;
	
	options.keyIds = options.keyIds || ["id"];
	
	//форма выбора из списка
	options.selectWinClass = options.selectWinClass || ExpenceTypeList_Form;
	options.selectDescrIds = options.selectDescrIds || ["name"];
	
	//форма редактирования элемента
	options.editWinClass = null;
	
	options.acMinLengthForQuery = 1;
	options.acController = new ExpenceType_Controller(options.app);
	options.acModel = new ExpenceType_Model();
	options.acPatternFieldId = options.acPatternFieldId || "name";
	options.acKeyFields = options.acKeyFields || [options.acModel.getField("id")];
	options.acDescrFields = options.acDescrFields || [options.acModel.getField("name")];
	options.acICase = options.acICase || "1";
	options.acMid = options.acMid || "1";
	
	ExpenceTypeEditRef.superclass.constructor.call(this,id,options);
}
extend(ExpenceTypeEditRef,EditRef);

/* Constants */


/* private members */

/* protected*/


/* public methods */

