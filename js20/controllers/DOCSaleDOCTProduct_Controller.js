/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
 * @requires core/extend.js
 * @requires core/ControllerDb.js
*/

/* constructor
@param string id
@param object options{

}
*/

function DOCSaleDOCTProduct_Controller(app,options){
	options = options || {};
	options.listModelId = "DOCSaleDOCTProductList_Model";
	options.objModelId = "DOCSaleDOCTProductList_Model";
	DOCSaleDOCTProduct_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
		
}
extend(DOCSaleDOCTProduct_Controller,ControllerDb);

			DOCSaleDOCTProduct_Controller.prototype.addInsert = function(){
	DOCSaleDOCTProduct_Controller.superclass.addInsert.call(this);
	var field;
	var options;
	
	var pm = this.getInsert();
	options = {};
	options.primaryKey = true;
	var field = new FieldInt("login_id",options);
	
	pm.addField(field);
	
	options = {};
	options.primaryKey = true;
	var field = new FieldInt("line_number",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Поставка";options.required = true;
	var field = new FieldInt("doc_production_id",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Количество";
	var field = new FieldFloat("quant",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Цена";
	var field = new FieldFloat("price",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Сумма";
	var field = new FieldFloat("total",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Скидка";
	var field = new FieldFloat("disc_percent",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Цена без скидки";
	var field = new FieldFloat("price_no_disc",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Сумма буз скидки";
	var field = new FieldFloat("total_no_disc",options);
	
	pm.addField(field);
	
	
}

			DOCSaleDOCTProduct_Controller.prototype.addUpdate = function(){
	DOCSaleDOCTProduct_Controller.superclass.addUpdate.call(this);
	var field;
	var options;	
	var pm = this.getUpdate();
	options = {};
	options.primaryKey = true;
	var field = new FieldInt("login_id",options);
	
	pm.addField(field);
	
	
	field = new FieldInt("old_login_id",{});
	pm.addField(field);
	
	options = {};
	options.primaryKey = true;
	var field = new FieldInt("line_number",options);
	
	pm.addField(field);
	
	
	field = new FieldInt("old_line_number",{});
	pm.addField(field);
	
	options = {};
	options.alias = "Поставка";options.required = true;
	var field = new FieldInt("doc_production_id",options);
	
	pm.addField(field);
	
	
	options = {};
	options.alias = "Количество";
	var field = new FieldFloat("quant",options);
	
	pm.addField(field);
	
	
	options = {};
	options.alias = "Цена";
	var field = new FieldFloat("price",options);
	
	pm.addField(field);
	
	
	options = {};
	options.alias = "Сумма";
	var field = new FieldFloat("total",options);
	
	pm.addField(field);
	
	
	options = {};
	options.alias = "Скидка";
	var field = new FieldFloat("disc_percent",options);
	
	pm.addField(field);
	
	
	options = {};
	options.alias = "Цена без скидки";
	var field = new FieldFloat("price_no_disc",options);
	
	pm.addField(field);
	
	
	options = {};
	options.alias = "Сумма буз скидки";
	var field = new FieldFloat("total_no_disc",options);
	
	pm.addField(field);
	
	
	
}

			DOCSaleDOCTProduct_Controller.prototype.addDelete = function(){
	DOCSaleDOCTProduct_Controller.superclass.addDelete.call(this);
	var options = {"required":true};
	
	var pm = this.getDelete();
	pm.addField(new FieldInt("login_id",options));
	pm.addField(new FieldInt("line_number",options));
}

			DOCSaleDOCTProduct_Controller.prototype.addGetList = function(){
	DOCSaleDOCTProduct_Controller.superclass.addGetList.call(this);
	var options = {};
	
	var pm = this.getGetList();
	pm.addField(new FieldInt("login_id",options));
	pm.addField(new FieldInt("line_number",options));
	pm.addField(new FieldInt("product_id",options));
	pm.addField(new FieldInt("doc_production_id",options));
	pm.addField(new FieldString("product_descr",options));
	pm.addField(new FieldFloat("quant",options));
	pm.addField(new FieldFloat("price",options));
	pm.addField(new FieldFloat("total",options));
	pm.addField(new FieldFloat("disc_percent",options));
	pm.addField(new FieldFloat("price_no_disc",options));
	pm.addField(new FieldFloat("total_no_disc",options));
}

			DOCSaleDOCTProduct_Controller.prototype.addGetObject = function(){
	DOCSaleDOCTProduct_Controller.superclass.addGetObject.call(this);
	var options = {};
	
	var pm = this.getGetObject();
	pm.addField(new FieldInt("login_id",options));
	pm.addField(new FieldInt("line_number",options));
}

		