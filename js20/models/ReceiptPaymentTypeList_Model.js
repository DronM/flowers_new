/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
 * @requires core/extend.js
 * @requires core/ModelXML.js
*/

/* constructor
@param string id
@param object options{

}
*/

function ReceiptPaymentTypeList_Model(options){
	var id = 'ReceiptPaymentTypeList_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	options.fields.dt = new FieldString("dt",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.kkm_type_close = new FieldInt("kkm_type_close",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.payment_type_for_sale_id = new FieldInt("payment_type_for_sale_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.payment_type_for_sale_descr = new FieldString("payment_type_for_sale_descr",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.total = new FieldFloat("total",filed_options);
	options.fields.total.getValidator().setMaxLength('2');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.user_id = new FieldInt("user_id",filed_options);
	
		ReceiptPaymentTypeList_Model.superclass.constructor.call(this,id,options);
}
extend(ReceiptPaymentTypeList_Model,ModelXML);

