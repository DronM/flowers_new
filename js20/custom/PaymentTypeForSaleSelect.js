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
function PaymentTypeForSaleSelect(id,options){
	options = options || {};
	options.model = new PaymentTypeForSale_Model();
	
	if (options.labelCaption==undefined && options.labelCaption!=""){
		options.labelCaption = this.CAP;
	}
	
	options.modelKeyFields = [options.model.getField("id")];
	options.modelDescrFields = [options.model.getField("name")];
	
	var contr = new PaymentTypeForSale_Controller(options.app);
	options.readPublicMethod = contr.getPublicMethod("get_list");
	
	PaymentTypeForSaleSelect.superclass.constructor.call(this,id,options);
	
}
extend(PaymentTypeForSaleSelect,EditSelectRef);

