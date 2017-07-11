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
function MaterialGroupSelect(id,options){
	options = options || {};
	options.model = new MaterialGroup_Model();
	
	var contr = new MaterialGroup_Controller(options.app);
	options.readPublicMethod = contr.getPublicMethod("get_list");
	
	options.keyIds = options.keyIds || ["id"];
	options.modelKeyFields = [options.model.getField("id")];
	options.modelDescrFields = [options.model.getField("name")];
	
	MaterialGroupSelect.superclass.constructor.call(this,id,options);
	
}
extend(MaterialGroupSelect,EditSelectRef);
