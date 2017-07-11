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
function DeliveryHourSelect(id,options){
	options = options || {};
	options.model = new DeliveryHourList_Model();
	
	options.keyIds = options.keyIds || ["id"];
	
	options.modelKeyFields = [options.model.getField("id")];
	//options.modelDescrFields = [options.model.getField("descr")];
	
	options.modelDescrFormatFunction = function(fields){
		return fields.h_from.getValue()+"-"+fields.h_to.getValue();
	};
	var contr = new DeliveryHour_Controller(options.app);
	options.readPublicMethod = contr.getPublicMethod("get_list");
	
	DeliveryHourSelect.superclass.constructor.call(this,id,options);
	
}
extend(DeliveryHourSelect,EditSelectRef);

