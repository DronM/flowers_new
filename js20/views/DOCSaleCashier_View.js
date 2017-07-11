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
function DOCSaleCashier_View(id,options){
	options = options || {};	
	
	var constants = {"doc_per_page_count":null,"def_store":null,"grid_refresh_interval":null};
	options.app.getConstantManager().get(constants);
	
	var model = new ModelXML("get_list_for_sale",{
		"fields":{
			"id":new FieldInt("id"),
			"name":new FieldString("name"),
			"code":new FieldString("code"),
			"quant":new FieldFloat("quant"),
			"quant_descr":new FieldString("quant_descr"),
			"price":new FieldString("price"),
			"doc_production_id":new FieldInt("doc_production_id"),
			"item_type":new FieldInt("item_type")
		},
		"data":options.get_list_for_sale});
		
	var contr = new Product_Controller(options.app);
	
	options.elements = [
		new ItemsForSaleGrid(id+":items-grid",{
			"model":model,
			"controller":contr,
			"readPublicMethod":contr.getPublicMethod("get_list_for_sale"),
			"refreshInterval":constants.grid_refresh_interval.getValue()*1000,
			"app":options.app
		}),	
		new DOCSaleReceipt_View(id+":receipt",{
			"ReceiptHeadList_Model":options.ReceiptHeadList_Model,
			"ReceiptList_Model":options.ReceiptList_Model,
			"ReceiptPaymentTypeList_Model":options.ReceiptPaymentTypeList_Model,
			"PaymentTypeForSale_Model":options.PaymentTypeForSale_Model,			
			"app":options.app			
		})
	];
	
	DOCSaleCashier_View.superclass.constructor.call(this, id, options);
	
	this.getElement("items-grid").m_receiptGrid = this.getElement("receipt").getElement("receipt-grid");
}
extend(DOCSaleCashier_View,View);

/* Constants */


/* private members */

/* protected*/


/* public methods */

