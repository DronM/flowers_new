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

function DOCMaterialDisposal_Controller(app,options){
	options = options || {};
	options.listModel = DOCMaterialDisposalList_Model;
	options.objModel = DOCMaterialDisposalList_Model;
	DOCMaterialDisposal_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.add_before_open();
	this.add_get_actions();
	this.add_set_unprocessed();
	this.add_get_print();
	this.add_get_details();
		
}
extend(DOCMaterialDisposal_Controller,ControllerDb);

			DOCMaterialDisposal_Controller.prototype.addInsert = function(){
	DOCMaterialDisposal_Controller.superclass.addInsert.call(this);
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
	options.alias = "Причина списания";
	var field = new FieldText("explanation",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
		var options = {};
		options.required = true;		
		pm.addField(new FieldString("view_id",options));
	
	
}

			DOCMaterialDisposal_Controller.prototype.addUpdate = function(){
	DOCMaterialDisposal_Controller.superclass.addUpdate.call(this);
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
	options.alias = "Причина списания";
	var field = new FieldText("explanation",options);
	
	pm.addField(field);
	
		var options = {};
		options.required = true;		
		pm.addField(new FieldString("view_id",options));
	
	
}

			DOCMaterialDisposal_Controller.prototype.addDelete = function(){
	DOCMaterialDisposal_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			DOCMaterialDisposal_Controller.prototype.addGetList = function(){
	DOCMaterialDisposal_Controller.superclass.addGetList.call(this);
	
	
	
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
	f_opts.alias = "Стоимость";
	pm.addField(new FieldFloat("cost",f_opts));
	var f_opts = {};
	f_opts.alias = "Причина";
	pm.addField(new FieldString("explanation",f_opts));
}

			DOCMaterialDisposal_Controller.prototype.addGetObject = function(){
	DOCMaterialDisposal_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
}

			DOCMaterialDisposal_Controller.prototype.add_before_open = function(){
	var pm = new PublicMethod('before_open',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		options.maxlength = "32";
	
		pm.addField(new FieldString("view_id",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_id",options));
	
			
}

			DOCMaterialDisposal_Controller.prototype.add_get_actions = function(){
	var pm = new PublicMethod('get_actions',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_id",options));
	
			
}

			DOCMaterialDisposal_Controller.prototype.add_set_unprocessed = function(){
	var pm = new PublicMethod('set_unprocessed',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldInt("doc_id",options));
	
			
}
				
			DOCMaterialDisposal_Controller.prototype.add_get_print = function(){
	var pm = new PublicMethod('get_print',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_id",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("templ",options));
	
			
}
									
			DOCMaterialDisposal_Controller.prototype.add_get_details = function(){
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
												
		
	
DOCMaterialDisposal_Controller.prototype.getPrintList = function(){
	return  [
		new PrintObj({
			"caption":"Акт списания",
			"publicMethod":this.getPublicMethod("get_print"),
			"templ":"DOCMaterialDisposalPrint",
			"publicMethodKeyIds":["doc_id"]
		})
	];
}
	
