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

function DOCSale_Controller(app,options){
	options = options || {};
	options.listModelId = "DOCSaleList_Model";
	options.objModelId = "DOCSaleDialog_Model";
	DOCSale_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.add_before_open();
	this.add_get_actions();
	this.add_get_print();
	this.add_get_mat_details();
	this.add_get_prod_details();
		
}
extend(DOCSale_Controller,ControllerDb);

			DOCSale_Controller.prototype.addInsert = function(){
	DOCSale_Controller.superclass.addInsert.call(this);
	var field;
	var options;
	
	var pm = this.getInsert();
	options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Дата";options.required = true;
	var field = new FieldDateTime("date_time",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Номер";
	var field = new FieldInt("number",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Проведен";
	var field = new FieldBool("processed",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Магазин";
	var field = new FieldInt("store_id",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Продавец";
	var field = new FieldInt("user_id",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Магазин";
	var field = new FieldInt("payment_type_for_sale_id",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Сумма";
	var field = new FieldFloat("total",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Себест.материалов";
	var field = new FieldFloat("total_material_cost",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Себест.продукции";
	var field = new FieldFloat("total_product_cost",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Клиент";
	var field = new FieldInt("client_id",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			DOCSale_Controller.prototype.addUpdate = function(){
	DOCSale_Controller.superclass.addUpdate.call(this);
	var field;
	var options;	
	var pm = this.getUpdate();
	options = {"sendNulls":true};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	options = {"sendNulls":true};
	options.alias = "Дата";
	var field = new FieldDateTime("date_time",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Номер";
	var field = new FieldInt("number",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Проведен";
	var field = new FieldBool("processed",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Магазин";
	var field = new FieldInt("store_id",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Продавец";
	var field = new FieldInt("user_id",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Магазин";
	var field = new FieldInt("payment_type_for_sale_id",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Сумма";
	var field = new FieldFloat("total",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Себест.материалов";
	var field = new FieldFloat("total_material_cost",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Себест.продукции";
	var field = new FieldFloat("total_product_cost",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Клиент";
	var field = new FieldInt("client_id",options);
	
	pm.addField(field);
	
	
	
}

			DOCSale_Controller.prototype.addDelete = function(){
	DOCSale_Controller.superclass.addDelete.call(this);
	var options = {"required":true};
	
	var pm = this.getDelete();
	pm.addField(new FieldInt("id",options));
}

			DOCSale_Controller.prototype.addGetList = function(){
	DOCSale_Controller.superclass.addGetList.call(this);
	var options = {};
	
	var pm = this.getGetList();
	pm.addField(new FieldInt("id",options));
	pm.addField(new FieldDateTime("date_time",options));
	pm.addField(new FieldString("number",options));
	pm.addField(new FieldString("processed",options));
	pm.addField(new FieldInt("store_id",options));
	pm.addField(new FieldString("store_descr",options));
	pm.addField(new FieldInt("user_id",options));
	pm.addField(new FieldString("user_descr",options));
	pm.addField(new FieldInt("payment_type_for_sale_id",options));
	pm.addField(new FieldString("payment_type_for_sale_descr",options));
	pm.addField(new FieldInt("client_id",options));
	pm.addField(new FieldString("client_descr",options));
	pm.addField(new FieldString("delivery",options));
	pm.addField(new FieldFloat("total",options));
	pm.addField(new FieldFloat("cost",options));
	pm.addField(new FieldFloat("income",options));
	pm.addField(new FieldFloat("income_percent",options));
}

			DOCSale_Controller.prototype.addGetObject = function(){
	DOCSale_Controller.superclass.addGetObject.call(this);
	var options = {};
	
	var pm = this.getGetObject();
	pm.addField(new FieldInt("id",options));
}

			DOCSale_Controller.prototype.add_before_open = function(){
	var pm = new PublicMethod('before_open',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_id",options));
	
			
}

			DOCSale_Controller.prototype.add_get_actions = function(){
	var pm = new PublicMethod('get_actions',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_id",options));
	
			
}

			DOCSale_Controller.prototype.add_get_print = function(){
	var pm = new PublicMethod('get_print',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_id",options));
	
			
}
									
			DOCSale_Controller.prototype.add_get_mat_details = function(){
	var pm = new PublicMethod('get_mat_details',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldString("cond_fields",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldString("cond_vals",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldString("cond_sgns",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("cond_ic",options));
				
				
	
	var options = {};
	
		pm.addField(new FieldInt("from",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("count",options));
				
				
	
	var options = {};
	
		pm.addField(new FieldString("ord_fields",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("ord_directs",options));
					
			
}
												
			DOCSale_Controller.prototype.add_get_prod_details = function(){
	var pm = new PublicMethod('get_prod_details',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldString("cond_fields",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldString("cond_vals",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldString("cond_sgns",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("cond_ic",options));
				
				
	
	var options = {};
	
		pm.addField(new FieldInt("from",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("count",options));
				
				
	
	var options = {};
	
		pm.addField(new FieldString("ord_fields",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("ord_directs",options));
								
			
}
															
		