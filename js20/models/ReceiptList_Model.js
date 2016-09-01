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

function ReceiptList_Model(options){
	var id = 'ReceiptList_Model';
	options = options || {};
	
	options.fields = {};
	
			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	
	var field = new FieldInt("user_id",filed_options);
	

	options.fields.user_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	
	var field = new FieldInt("item_id",filed_options);
	

	options.fields.item_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	
	var field = new FieldInt("item_type",filed_options);
	

	options.fields.item_type = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldInt("doc_production_id",filed_options);
	

	options.fields.doc_production_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("item_name",filed_options);
	
		field.getValidator().setMaxLength('100');
	

	options.fields.item_name = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldFloat("quant",filed_options);
	
		field.getValidator().setMaxLength('19');
	

	options.fields.quant = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldFloat("price",filed_options);
	
		field.getValidator().setMaxLength('15');
	

	options.fields.price = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldFloat("total",filed_options);
	
		field.getValidator().setMaxLength('15');
	

	options.fields.total = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldFloat("total_no_disc",filed_options);
	
		field.getValidator().setMaxLength('15');
	

	options.fields.total_no_disc = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldFloat("price_no_disc",filed_options);
	
		field.getValidator().setMaxLength('15');
	

	options.fields.price_no_disc = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldFloat("disc_percent",filed_options);
	
		field.getValidator().setMaxLength('15');
	

	options.fields.disc_percent = field;

		ReceiptList_Model.superclass.constructor.call(this,id,options);
}
extend(ReceiptList_Model,ModelXML);

