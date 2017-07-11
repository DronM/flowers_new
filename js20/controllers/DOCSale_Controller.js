/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2017
 
 * @class
 * @classdesc controller
 
 * @requires ../core/extend.js
 * @requires ../core/ControllerDb.js 
  
 * @param {App} app - app instance
 * @param {namespase} options
 * @param {Model} options.listModel
 * @param {Model} options.objModel 
 */ 

function DOCSale_Controller(app,options){
	options = options || {};
	options.listModel = DOCSaleList_Model;
	options.objModel = DOCSaleDialog_Model;
	DOCSale_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.add_before_open();
	this.add_set_unprocessed();
	this.add_get_actions();
	this.add_get_print();
	this.add_get_mat_details();
	this.add_get_prod_details();
		
}
extend(DOCSale_Controller,ControllerDb);

			DOCSale_Controller.prototype.addInsert = function(){
	DOCSale_Controller.superclass.addInsert.call(this);
	var field;
	
	var pm = this.getInsert();
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Дата";options.required = true;
	var field = new FieldDateTime("date_time",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Номер";
	var field = new FieldInt("number",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Проведен";
	var field = new FieldBool("processed",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Магазин";
	var field = new FieldInt("store_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Продавец";
	var field = new FieldInt("user_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Магазин";
	var field = new FieldInt("payment_type_for_sale_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Сумма";
	var field = new FieldFloat("total",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Себест.материалов";
	var field = new FieldFloat("total_material_cost",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Себест.продукции";
	var field = new FieldFloat("total_product_cost",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Клиент";
	var field = new FieldInt("client_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Вид скидки";
	var field = new FieldInt("discount_id",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
		var options = {};
		options.required = true;		
		pm.addField(new FieldString("view_id",options));
	
	
}

			DOCSale_Controller.prototype.addUpdate = function(){
	DOCSale_Controller.superclass.addUpdate.call(this);
	var field;	
	var pm = this.getUpdate();
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	var options = {};
	options.alias = "Дата";
	var field = new FieldDateTime("date_time",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Номер";
	var field = new FieldInt("number",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Проведен";
	var field = new FieldBool("processed",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Магазин";
	var field = new FieldInt("store_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Продавец";
	var field = new FieldInt("user_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Магазин";
	var field = new FieldInt("payment_type_for_sale_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Сумма";
	var field = new FieldFloat("total",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Себест.материалов";
	var field = new FieldFloat("total_material_cost",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Себест.продукции";
	var field = new FieldFloat("total_product_cost",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Клиент";
	var field = new FieldInt("client_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Вид скидки";
	var field = new FieldInt("discount_id",options);
	
	pm.addField(field);
	
		var options = {};
		options.required = true;		
		pm.addField(new FieldString("view_id",options));
	
	
}

			DOCSale_Controller.prototype.addDelete = function(){
	DOCSale_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			DOCSale_Controller.prototype.addGetList = function(){
	DOCSale_Controller.superclass.addGetList.call(this);
	
	
	
	var pm = this.getGetList();
	var f_opts = {};
	
	pm.addField(new FieldInt("id",f_opts));
	var f_opts = {};
	f_opts.alias = "Дата";
	pm.addField(new FieldDateTime("date_time",f_opts));
	var f_opts = {};
	f_opts.alias = "Номер";
	pm.addField(new FieldString("number",f_opts));
	var f_opts = {};
	f_opts.alias = "Проведен";
	pm.addField(new FieldString("processed",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("store_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Салон";
	pm.addField(new FieldString("store_descr",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("user_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Автор";
	pm.addField(new FieldString("user_descr",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("payment_type_for_sale_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Вид оплаты";
	pm.addField(new FieldString("payment_type_for_sale_descr",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("client_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Клиент";
	pm.addField(new FieldString("client_descr",f_opts));
	var f_opts = {};
	f_opts.alias = "Доставка";
	pm.addField(new FieldString("delivery",f_opts));
	var f_opts = {};
	f_opts.alias = "Сумма";
	pm.addField(new FieldFloat("total",f_opts));
	var f_opts = {};
	f_opts.alias = "Стоимость";
	pm.addField(new FieldFloat("cost",f_opts));
	var f_opts = {};
	f_opts.alias = "Наценка,руб";
	pm.addField(new FieldFloat("income",f_opts));
	var f_opts = {};
	f_opts.alias = "Наценка,%";
	pm.addField(new FieldFloat("income_percent",f_opts));
}

			DOCSale_Controller.prototype.addGetObject = function(){
	DOCSale_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
}

			DOCSale_Controller.prototype.add_before_open = function(){
	var pm = new PublicMethod('before_open',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		options.maxlength = "32";
	
		pm.addField(new FieldString("view_id",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_id",options));
	
			
}

			DOCSale_Controller.prototype.add_set_unprocessed = function(){
	var pm = new PublicMethod('set_unprocessed',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
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
	
				
	
	var options = {};
	
		pm.addField(new FieldString("templ",options));
	
			
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
															
		
	
DOCSale_Controller.prototype.getPrintList = function(){
	return  [
		new PrintObj({
			"caption":"Товарный чек",
			"publicMethod":this.getPublicMethod("get_print"),
			"templ":"DOCSalePrint",
			"publicMethodKeyIds":["doc_id"]
		})
	];
}

