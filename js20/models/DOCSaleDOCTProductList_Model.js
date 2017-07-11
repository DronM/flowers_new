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

function DOCSaleDOCTProductList_Model(options){
	var id = 'DOCSaleDOCTProductList_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	options.fields.view_id = new FieldString("view_id",filed_options);
	options.fields.view_id.getValidator().setMaxLength('32');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	filed_options.alias = '№';options.fields.line_number = new FieldInt("line_number",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.product_id = new FieldInt("product_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Комплектация';options.fields.doc_production_id = new FieldInt("doc_production_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.doc_production_number = new FieldInt("doc_production_number",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.doc_production_date_time = new FieldDateTime("doc_production_date_time",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.product_descr = new FieldString("product_descr",filed_options);
				
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Количество';options.fields.quant = new FieldFloat("quant",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Цена';options.fields.price = new FieldFloat("price",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Сумма';options.fields.total = new FieldFloat("total",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Скидка';options.fields.disc_percent = new FieldFloat("disc_percent",filed_options);
	options.fields.disc_percent.getValidator().setMaxLength('15');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Цена без скидки';options.fields.price_no_disc = new FieldFloat("price_no_disc",filed_options);
	options.fields.price_no_disc.getValidator().setMaxLength('15');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Сумма без скидки';options.fields.total_no_disc = new FieldFloat("total_no_disc",filed_options);
	options.fields.total_no_disc.getValidator().setMaxLength('15');
							
		DOCSaleDOCTProductList_Model.superclass.constructor.call(this,id,options);
}
extend(DOCSaleDOCTProductList_Model,ModelXML);

