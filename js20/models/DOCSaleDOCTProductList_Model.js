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
	
	
	var field = new FieldInt("login_id",filed_options);
	

	options.fields.login_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	filed_options.alias = '№';
	
	var field = new FieldInt("line_number",filed_options);
	

	options.fields.line_number = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldInt("product_id",filed_options);
	

	options.fields.product_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldInt("doc_production_id",filed_options);
	

	options.fields.doc_production_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("product_descr",filed_options);
	

	options.fields.product_descr = field;
			
			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldFloat("quant",filed_options);
	

	options.fields.quant = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldFloat("price",filed_options);
	

	options.fields.price = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldFloat("total",filed_options);
	

	options.fields.total = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Скидка';
	
	var field = new FieldFloat("disc_percent",filed_options);
	
		field.getValidator().setMaxLength('15');
	

	options.fields.disc_percent = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Цена без скидки';
	
	var field = new FieldFloat("price_no_disc",filed_options);
	
		field.getValidator().setMaxLength('15');
	

	options.fields.price_no_disc = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Сумма буз скидки';
	
	var field = new FieldFloat("total_no_disc",filed_options);
	
		field.getValidator().setMaxLength('15');
	

	options.fields.total_no_disc = field;
						
		DOCSaleDOCTProductList_Model.superclass.constructor.call(this,id,options);
}
extend(DOCSaleDOCTProductList_Model,ModelXML);

