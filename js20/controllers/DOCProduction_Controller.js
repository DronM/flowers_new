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

function DOCProduction_Controller(app,options){
	options = options || {};
	options.listModelId = "DOCProductionList_Model";
	options.objModelId = "DOCProductionList_Model";
	DOCProduction_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.add_get_doc();
	this.add_fill_on_spec();
	this.add_get_balance_list();
	this.add_get_current_doc_cost();
	this.add_add_to_open_doc();
	this.add_get_actions();
	this.add_get_print();
	this.add_print_barcode();
	this.add_get_details();
		
}
extend(DOCProduction_Controller,ControllerDb);

			DOCProduction_Controller.prototype.addInsert = function(){
	DOCProduction_Controller.superclass.addInsert.call(this);
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
	options.alias = "Флорист";
	var field = new FieldInt("user_id",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Букет";options.required = true;
	var field = new FieldInt("product_id",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Вид заявки";	
	options.enumValues = 'sale,disposal,manual';
	field = new FieldEnum("product_order_type",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "По норме";
	var field = new FieldBool("on_norm",options);
	
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
	options.alias = "Комментарий";
	var field = new FieldText("florist_comment",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			DOCProduction_Controller.prototype.addUpdate = function(){
	DOCProduction_Controller.superclass.addUpdate.call(this);
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
	options.alias = "Флорист";
	var field = new FieldInt("user_id",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Букет";
	var field = new FieldInt("product_id",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Вид заявки";	
	options.enumValues = 'sale,disposal,manual';
	
	field = new FieldEnum("product_order_type",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "По норме";
	var field = new FieldBool("on_norm",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Количество";
	var field = new FieldFloat("quant",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Цена";
	var field = new FieldFloat("price",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Комментарий";
	var field = new FieldText("florist_comment",options);
	
	pm.addField(field);
	
	
	
}

			DOCProduction_Controller.prototype.addDelete = function(){
	DOCProduction_Controller.superclass.addDelete.call(this);
	var options = {"required":true};
	
	var pm = this.getDelete();
	pm.addField(new FieldInt("id",options));
}

			DOCProduction_Controller.prototype.addGetList = function(){
	DOCProduction_Controller.superclass.addGetList.call(this);
	var options = {};
	
	var pm = this.getGetList();
	pm.addField(new FieldInt("id",options));
	pm.addField(new FieldString("tmp_id",options));
	pm.addField(new FieldString("number",options));
	pm.addField(new FieldDateTime("date_time",options));
	pm.addField(new FieldInt("store_id",options));
	pm.addField(new FieldString("store_descr",options));
	pm.addField(new FieldInt("user_id",options));
	pm.addField(new FieldString("user_descr",options));
	pm.addField(new FieldInt("product_id",options));
	pm.addField(new FieldString("product_descr",options));
	pm.addField(new FieldFloat("quant",options));
	pm.addField(new FieldFloat("price",options));
	pm.addField(new FieldFloat("mat_sum",options));
	pm.addField(new FieldFloat("mat_cost",options));
	pm.addField(new FieldString("processed",options));
	pm.addField(new FieldText("florist_comment",options));
}

			DOCProduction_Controller.prototype.addGetObject = function(){
	DOCProduction_Controller.superclass.addGetObject.call(this);
	var options = {};
	
	var pm = this.getGetObject();
	pm.addField(new FieldInt("id",options));
}

			
			DOCProduction_Controller.prototype.add_get_doc = function(){
	var pm = new PublicMethod('get_doc',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldInt("id",options));
	
			
}

			
			
			DOCProduction_Controller.prototype.add_fill_on_spec = function(){
	var pm = new PublicMethod('fill_on_spec',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldInt("product_id",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldFloat("product_quant",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("store_id",options));
	
			
}
			
			DOCProduction_Controller.prototype.add_get_balance_list = function(){
	var pm = new PublicMethod('get_balance_list',{controller:this});
	this.addPublicMethod(pm);
	
}

			DOCProduction_Controller.prototype.add_get_current_doc_cost = function(){
	var pm = new PublicMethod('get_current_doc_cost',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("store_id",options));
	
			
}

			DOCProduction_Controller.prototype.add_add_to_open_doc = function(){
	var pm = new PublicMethod('add_to_open_doc',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldInt("product_id",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldInt("material_id",options));
	
			
}
						
			DOCProduction_Controller.prototype.add_get_actions = function(){
	var pm = new PublicMethod('get_actions',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_id",options));
	
			
}

			DOCProduction_Controller.prototype.add_get_print = function(){
	var pm = new PublicMethod('get_print',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_id",options));
	
			
}
									
			DOCProduction_Controller.prototype.add_print_barcode = function(){
	var pm = new PublicMethod('print_barcode',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_id",options));
	
			
}
												
			DOCProduction_Controller.prototype.add_get_details = function(){
	var pm = new PublicMethod('get_details',{controller:this});
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
												
		