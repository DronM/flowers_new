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

function DOCProduction_Controller(app,options){
	options = options || {};
	options.listModel = DOCProductionList_Model;
	options.objModel = DOCProductionList_Model;
	DOCProduction_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.add_before_open();
	this.add_set_unprocessed();
	this.add_fill_on_spec();
	this.add_get_balance_list();
	this.add_get_current_doc_cost();
	this.add_add_to_open_doc();
	this.add_get_actions();
	this.add_get_print();
	this.add_print_barcode();
	this.add_calc_mat_costs();
	this.add_get_details();
		
}
extend(DOCProduction_Controller,ControllerDb);

			DOCProduction_Controller.prototype.addInsert = function(){
	DOCProduction_Controller.superclass.addInsert.call(this);
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
	options.alias = "Флорист";
	var field = new FieldInt("user_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Букет";options.required = true;
	var field = new FieldInt("product_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Количество";
	var field = new FieldFloat("quant",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Цена";
	var field = new FieldFloat("price",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Комментарий";
	var field = new FieldText("florist_comment",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
		var options = {};
		options.required = true;		
		pm.addField(new FieldString("view_id",options));
	
	
}

			DOCProduction_Controller.prototype.addUpdate = function(){
	DOCProduction_Controller.superclass.addUpdate.call(this);
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
	options.alias = "Флорист";
	var field = new FieldInt("user_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Букет";
	var field = new FieldInt("product_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Количество";
	var field = new FieldFloat("quant",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Цена";
	var field = new FieldFloat("price",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Комментарий";
	var field = new FieldText("florist_comment",options);
	
	pm.addField(field);
	
		var options = {};
		options.required = true;		
		pm.addField(new FieldString("view_id",options));
	
	
}

			DOCProduction_Controller.prototype.addDelete = function(){
	DOCProduction_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			DOCProduction_Controller.prototype.addGetList = function(){
	DOCProduction_Controller.superclass.addGetList.call(this);
	
	
	
	var pm = this.getGetList();
	var f_opts = {};
	
	pm.addField(new FieldInt("id",f_opts));
	var f_opts = {};
	f_opts.alias = "Номер";
	pm.addField(new FieldString("number",f_opts));
	var f_opts = {};
	f_opts.alias = "Дата";
	pm.addField(new FieldDateTime("date_time",f_opts));
	var f_opts = {};
	f_opts.alias = "Проведен";
	pm.addField(new FieldString("processed",f_opts));
	var f_opts = {};
	f_opts.alias = "По норме";
	pm.addField(new FieldBool("on_norm",f_opts));
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
	
	pm.addField(new FieldInt("product_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Продукция";
	pm.addField(new FieldString("product_descr",f_opts));
	var f_opts = {};
	f_opts.alias = "Количество";
	pm.addField(new FieldFloat("quant",f_opts));
	var f_opts = {};
	f_opts.alias = "Цена";
	pm.addField(new FieldFloat("price",f_opts));
	var f_opts = {};
	f_opts.alias = "Сумма материалов";
	pm.addField(new FieldFloat("material_retail_cost",f_opts));
	var f_opts = {};
	f_opts.alias = "Себестоимость материалов";
	pm.addField(new FieldFloat("material_cost",f_opts));
	var f_opts = {};
	f_opts.alias = "Наценка,%";
	pm.addField(new FieldFloat("income_percent",f_opts));
	var f_opts = {};
	f_opts.alias = "Наценка,руб";
	pm.addField(new FieldFloat("income",f_opts));
	var f_opts = {};
	f_opts.alias = "Комментарий";
	pm.addField(new FieldText("florist_comment",f_opts));
	var f_opts = {};
	f_opts.alias = "Период после продажи";
	pm.addField(new FieldText("after_prod_interval",f_opts));
	var f_opts = {};
	f_opts.alias = "Представление документа";
	pm.addField(new FieldString("doc_descr",f_opts));
}

			DOCProduction_Controller.prototype.addGetObject = function(){
	DOCProduction_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
}

			
			DOCProduction_Controller.prototype.add_before_open = function(){
	var pm = new PublicMethod('before_open',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_id",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		options.maxlength = "32";
	
		pm.addField(new FieldString("view_id",options));
	
			
}

			DOCProduction_Controller.prototype.add_set_unprocessed = function(){
	var pm = new PublicMethod('set_unprocessed',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldInt("doc_id",options));
	
			
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
	
				
	
	var options = {};
	
		pm.addField(new FieldString("templ",options));
	
			
}
									
			DOCProduction_Controller.prototype.add_print_barcode = function(){
	var pm = new PublicMethod('print_barcode',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_id",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("templ",options));
	
			
}
												
			DOCProduction_Controller.prototype.add_calc_mat_costs = function(){
	var pm = new PublicMethod('calc_mat_costs',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		options.maxlength = "32";
	
		pm.addField(new FieldString("view_id",options));
		
				
	
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
												
		
	
DOCProduction_Controller.prototype.getPrintList = function(){
	return  [
		new PrintObj({
			"caption":"Комплектация",
			"publicMethod":this.getPublicMethod("get_print"),
			"templ":"DOCProductionPrint",
			"publicMethodKeyIds":["doc_id"]
		}),
	
		new PrintObj({
			"caption":"Этикетка",
			"publicMethod":this.getPublicMethod("print_barcode"),
			"templ":"DOCProductionBarcode",
			"publicMethodKeyIds":["doc_id"]
		})
	];
}
	
