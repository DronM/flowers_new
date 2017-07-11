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


function ClientEditRef(id,options){
	options = options || {};	
	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Клиент:";
	}
	
	options.cmdOpen = (options.cmdOpen!=undefined)? options.cmdOpen:false;
	options.cmdInsert = (options.cmdInsert!=undefined)? options.cmdInsert:false;
	
	options.keyIds = options.keyIds || ["id"];
	
	//форма выбора из списка
	options.selectWinClass = options.selectWinClass || ClientList_Form;
	options.selectDescrIds = options.selectDescrIds || ["name"];
	options.selectKeyIds = options.selectKeyIds || ["id"];
	
	//форма редактирования элемента
	options.editWinClass = Client_Form;
	
	options.acMinLengthForQuery = 1;
	options.acController = new Client_Controller(options.app);
	options.acModel = new ClientList_Model();
	options.acPatternFieldId = options.acPatternFieldId || "name";
	options.acKeyFields = options.acKeyFields || [options.acModel.getField("id")];
	options.acDescrFields = options.acDescrFields || [options.acModel.getField("name")];
	options.acICase = options.acICase || "1";
	options.acMid = options.acMid || "0";
	
	ClientEditRef.superclass.constructor.call(this,id,options);
}
extend(ClientEditRef,EditRef);

/* Constants */


/* private members */

/* protected*/


/* public methods */

