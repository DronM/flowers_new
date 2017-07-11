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
function DiscountSelect(id,options){
	options = options || {};
	
	if (options.labelCaption==undefined && options.labelCaption!=""){
		options.labelCaption = this.CAP;
	}
	
	options.keyIds = options.keyIds || ["id"];
	
	options.model = new DiscountList_Model();
	
	options.modelKeyFields = [options.model.getField("id")];
	options.modelDescrFields = [options.model.getField("descr")];
	/*
	options.formatFunction = function(m){
		return m.getFieldValue("descr")+"("+m.getFieldValue("percent")+")";
	}
	*/
	
	var contr = new Discount_Controller(options.app);
	options.readPublicMethod = contr.getPublicMethod("get_list_for_sale");
	
	DiscountSelect.superclass.constructor.call(this,id,options);
	
}
extend(DiscountSelect,EditSelectRef);

