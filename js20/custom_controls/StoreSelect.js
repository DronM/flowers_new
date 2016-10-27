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
function StoreSelect(id,options){
	options = options || {};
	options.model = new StoreList_Model();
	options.labelCaption = options.labelCaption || "Салон:";
	
	var contr = new Store_Controller(options.app);
	options.readPublicMethod = contr.getPublicMethod("get_list");
	
	StoreSelect.superclass.constructor.call(this,id,options);
	
}
extend(StoreSelect,EditSelectRef);

