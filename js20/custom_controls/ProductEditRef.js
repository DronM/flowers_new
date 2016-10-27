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


function ProductEditRef(id,options){
	options = options || {};	
	options.labelCaption = options.labelCaption || "Продукция:";
	options.cmdInsert = (options.cmdInsert!=undefined)? options.cmdInsert:false;
	
	options.enabled = false;
	
	options.keyIds = options.keyIds || ["id"];
	
	//форма выбора из списка
	options.selectWinClass = ProductList_Form;
	options.selectDescrIds = options.selectDescrIds || ["name"];
	
	//форма редактирования элемента
	options.cmdEdit = false;
	/*
	options.acMinLengthForQuery = 2;
	options.acController = new Product_Controller(options.app);
	options.acModel = new ProductList_Model();
	options.acPatternFieldId = options.acPatternFieldId || "price";
	options.acKeyFields = options.acKeyFields || [options.acModel.getField("id")];
	options.acDescrFields = options.acDescrFields || [options.acModel.getField("name")];
	options.acICase = options.acICase || "0";
	options.acMid = options.acMid || "1";
	*/
	ProductEditRef.superclass.constructor.call(this,id,options);
}
extend(ProductEditRef,EditRef);

/* Constants */


/* private members */

/* protected*/


/* public methods */

