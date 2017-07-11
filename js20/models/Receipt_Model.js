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

function Receipt_Model(options){
	var id = 'Receipt_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	options.fields.user_id = new FieldInt("user_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	options.fields.item_id = new FieldInt("item_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	options.fields.item_type = new FieldInt("item_type",filed_options);
				
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.doc_production_id = new FieldInt("doc_production_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.item_name = new FieldString("item_name",filed_options);
	options.fields.item_name.getValidator().setMaxLength('100');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.quant = new FieldFloat("quant",filed_options);
	options.fields.quant.getValidator().setMaxLength('19');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.price = new FieldFloat("price",filed_options);
	options.fields.price.getValidator().setMaxLength('15');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.total = new FieldFloat("total",filed_options);
	options.fields.total.getValidator().setMaxLength('15');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.ord = new FieldTime("ord",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.total_no_disc = new FieldFloat("total_no_disc",filed_options);
	options.fields.total_no_disc.getValidator().setMaxLength('15');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.price_no_disc = new FieldFloat("price_no_disc",filed_options);
	options.fields.price_no_disc.getValidator().setMaxLength('15');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.disc_percent = new FieldFloat("disc_percent",filed_options);
	options.fields.disc_percent.getValidator().setMaxLength('15');
				
									
		Receipt_Model.superclass.constructor.call(this,id,options);
}
extend(Receipt_Model,ModelXML);

