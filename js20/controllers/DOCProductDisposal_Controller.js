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

function DOCProductDisposal_Controller(app,options){
	options = options || {};
	options.listModel = DOCProductDisposalList_Model;
	options.objModel = DOCProductDisposalList_Model;
	DOCProductDisposal_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.add_get_actions();
	this.add_set_unprocessed();
	this.add_get_print();
		
}
extend(DOCProductDisposal_Controller,ControllerDb);

			DOCProductDisposal_Controller.prototype.addInsert = function(){
	DOCProductDisposal_Controller.superclass.addInsert.call(this);
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
	options.alias = "Комплектация";options.required = true;
	var field = new FieldInt("doc_production_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Причина списания";
	var field = new FieldText("explanation",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			DOCProductDisposal_Controller.prototype.addUpdate = function(){
	DOCProductDisposal_Controller.superclass.addUpdate.call(this);
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
	options.alias = "Комплектация";
	var field = new FieldInt("doc_production_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Причина списания";
	var field = new FieldText("explanation",options);
	
	pm.addField(field);
	
	
}

			DOCProductDisposal_Controller.prototype.addDelete = function(){
	DOCProductDisposal_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			DOCProductDisposal_Controller.prototype.addGetList = function(){
	DOCProductDisposal_Controller.superclass.addGetList.call(this);
	
	
	
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
	f_opts.alias = "Дата";
	pm.addField(new FieldString("date_time_descr",f_opts));
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
	
	pm.addField(new FieldInt("product_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Продукция";
	pm.addField(new FieldString("product_descr",f_opts));
	var f_opts = {};
	f_opts.alias = "Причина списания";
	pm.addField(new FieldString("explanation",f_opts));
	var f_opts = {};
	f_opts.alias = "Поставка";
	pm.addField(new FieldString("doc_production_descr",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("doc_production_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Номер комеплектации";
	pm.addField(new FieldString("doc_production_number",f_opts));
	var f_opts = {};
	f_opts.alias = "Дата комеплектации";
	pm.addField(new FieldDateTime("doc_production_date_time",f_opts));
}

			DOCProductDisposal_Controller.prototype.addGetObject = function(){
	DOCProductDisposal_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
}

			DOCProductDisposal_Controller.prototype.add_get_actions = function(){
	var pm = new PublicMethod('get_actions',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_id",options));
	
			
}

			DOCProductDisposal_Controller.prototype.add_set_unprocessed = function(){
	var pm = new PublicMethod('set_unprocessed',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldInt("doc_id",options));
	
			
}

			
			DOCProductDisposal_Controller.prototype.add_get_print = function(){
	var pm = new PublicMethod('get_print',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_id",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("templ",options));
	
			
}

		
	
DOCProductDisposal_Controller.prototype.getPrintList = function(){
	return  [
		new PrintObj({
			"caption":"Акт списания",
			"publicMethod":this.getPublicMethod("get_print"),
			"templ":"DOCProductDisposalPrint",
			"publicMethodKeyIds":["doc_id"]
		})
	];
}
	
