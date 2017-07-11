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

/* constructor
@param object options{
	@param string modelDataStr
}
*/
function CashRegisterSelect(id,options){
	options = options || {};
	options.model = new CashRegister_Model();
	
	options.keyIds = options.keyIds || ["cash_register_id"];
	
	options.modelKeyFields = [options.model.getField("id")];
	options.modelDescrFields = [options.model.getField("name")];
	
	var contr = new CashRegister_Controller(options.app);
	options.readPublicMethod = contr.getPublicMethod("get_list");
	
	CashRegisterSelect.superclass.constructor.call(this,id,options);
	
}
extend(CashRegisterSelect,EditSelectRef);

