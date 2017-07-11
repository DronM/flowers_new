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
function MaterialGroupRadio(id,options){
	options = options || {};
	
	var constants = {"def_material_group":null};
	options.app.getConstantManager().get(constants);
	options.defaultValue = constants.def_material_group.getValue();
	
	options.model = new MaterialGroup_Model();
	options.cashable = true;
	options.colCount = 3;
	options.notSelectedValue = "0";
	options.notSelectedCaption = "Все группы";
	options.notSelectedLast = true;
	options.keyFieldId = "id";
	options.descrFieldId = "name";
	
	var contr = new MaterialGroup_Controller(options.app);
	options.readPublicMethod = contr.getPublicMethod("get_list");
	
		
	MaterialGroupRadio.superclass.constructor.call(this,id,options);
	
}
extend(MaterialGroupRadio,EditRadioGroupRef);



