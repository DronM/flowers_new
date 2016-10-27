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

function Material_Controller(app,options){
	options = options || {};
	options.listModelId = "MaterialList_Model";
	options.objModelId = "Material_Model";
	Material_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.addComplete();
	this.add_get_list_with_balance();
	this.add_get_balance_list();
	this.add_get_list_for_sale();
	this.add_material_procur_plan_report();
	this.add_procur_avg_price_report();
	this.add_actions_report();
	this.add_print_barcode();
		
}
extend(Material_Controller,ControllerDb);

			Material_Controller.prototype.addInsert = function(){
	Material_Controller.superclass.addInsert.call(this);
	var field;
	var options;
	
	var pm = this.getInsert();
	options = {};
	options.alias = "Код";options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Наименование";options.required = true;
	var field = new FieldString("name",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Описание";options.required = true;
	var field = new FieldText("name_full",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Розничная цена";options.required = true;
	var field = new FieldFloat("price",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Для продажи";
	var field = new FieldBool("for_sale",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Наценка (%)";
	var field = new FieldInt("margin_percent",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Группа";options.required = true;
	var field = new FieldInt("material_group_id",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			Material_Controller.prototype.addUpdate = function(){
	Material_Controller.superclass.addUpdate.call(this);
	var field;
	var options;	
	var pm = this.getUpdate();
	options = {"sendNulls":true};
	options.alias = "Код";options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	options = {"sendNulls":true};
	options.alias = "Наименование";
	var field = new FieldString("name",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Описание";
	var field = new FieldText("name_full",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Розничная цена";
	var field = new FieldFloat("price",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Для продажи";
	var field = new FieldBool("for_sale",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Наценка (%)";
	var field = new FieldInt("margin_percent",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Группа";
	var field = new FieldInt("material_group_id",options);
	
	pm.addField(field);
	
	
	
}

			Material_Controller.prototype.addDelete = function(){
	Material_Controller.superclass.addDelete.call(this);
	var options = {"required":true};
	
	var pm = this.getDelete();
	pm.addField(new FieldInt("id",options));
}

			Material_Controller.prototype.addGetList = function(){
	Material_Controller.superclass.addGetList.call(this);
	var options = {};
	
	var pm = this.getGetList();
	pm.addField(new FieldInt("id",options));
	pm.addField(new FieldString("name",options));
	pm.addField(new FieldFloat("price",options));
	pm.addField(new FieldBool("for_sale",options));
	pm.addField(new FieldString("material_group_id",options));
}

			Material_Controller.prototype.addGetObject = function(){
	Material_Controller.superclass.addGetObject.call(this);
	var options = {};
	
	var pm = this.getGetObject();
	pm.addField(new FieldInt("id",options));
}

			Material_Controller.prototype.addComplete = function(){
	Material_Controller.superclass.addComplete.call(this);
	
	var options = {};
	
	var pm = this.getComplete();
	pm.addField(new FieldString("name",options));
	pm.getField(this.PARAM_ORD_FIELDS).setValue("name");
}

			Material_Controller.prototype.add_get_list_with_balance = function(){
	var pm = new PublicMethod('get_list_with_balance',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldString("cond_fields",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("cond_vals",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("cond_sgns",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("cond_ic",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("field_sep",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("from",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("count",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("ord_fields",options));
				
				
	
	var options = {};
	
		pm.addField(new FieldString("ord_directs",options));
								
			
}

			Material_Controller.prototype.add_get_balance_list = function(){
	var pm = new PublicMethod('get_balance_list',{controller:this});
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
			
			Material_Controller.prototype.add_get_list_for_sale = function(){
	var pm = new PublicMethod('get_list_for_sale',{controller:this});
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
			
			Material_Controller.prototype.add_material_procur_plan_report = function(){
	var pm = new PublicMethod('material_procur_plan_report',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldString("cond_fields",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("cond_vals",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("cond_sgns",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("cond_ic",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("templ",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("ord_fields",options));
				
				
	
	var options = {};
	
		pm.addField(new FieldString("ord_directs",options));
								
			
}
			
			Material_Controller.prototype.add_procur_avg_price_report = function(){
	var pm = new PublicMethod('procur_avg_price_report',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldString("cond_fields",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("cond_vals",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("cond_sgns",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("cond_ic",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("templ",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("ord_fields",options));
				
				
	
	var options = {};
	
		pm.addField(new FieldString("ord_directs",options));
								
			
}
						
			Material_Controller.prototype.add_actions_report = function(){
	var pm = new PublicMethod('actions_report',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldString("cond_fields",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("cond_vals",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("cond_sgns",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("cond_ic",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("templ",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("ord_fields",options));
				
				
	
	var options = {};
	
		pm.addField(new FieldString("ord_directs",options));
								
			
}
									
			Material_Controller.prototype.add_print_barcode = function(){
	var pm = new PublicMethod('print_barcode',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("material_id",options));
	
			
}
			
		