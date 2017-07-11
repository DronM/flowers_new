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

function VariantStorage_Controller(app,options){
	options = options || {};
	options.objModel = VariantStorage_Model;
	VariantStorage_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.add_upsert_filter_data();
	this.add_upsert_col_visib_data();
	this.add_upsert_col_order_data();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.add_get_filter_data();
	this.add_get_col_visib_data();
	this.add_get_col_order_data();
		
}
extend(VariantStorage_Controller,ControllerDb);

			VariantStorage_Controller.prototype.addInsert = function(){
	VariantStorage_Controller.superclass.addInsert.call(this);
	var field;
	
	var pm = this.getInsert();
	var options = {};
	options.primaryKey = true;options.required = true;
	var field = new FieldInt("user_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.primaryKey = true;options.required = true;
	var field = new FieldText("storage_name",options);
	
	pm.addField(field);
	
	var options = {};
	options.primaryKey = true;options.required = true;
	var field = new FieldText("variant_name",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldBool("default_variant",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldText("filter_data",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldText("col_visib_data",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldText("col_order_data",options);
	
	pm.addField(field);
	
	
}

			VariantStorage_Controller.prototype.add_upsert_filter_data = function(){
	var pm = new PublicMethod('upsert_filter_data',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldString("storage_name",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldString("variant_name",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldString("filter_data",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldBool("default_variant",options));
	
			
}
			
			VariantStorage_Controller.prototype.add_upsert_col_visib_data = function(){
	var pm = new PublicMethod('upsert_col_visib_data',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldString("storage_name",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldString("variant_name",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldString("col_visib",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldBool("default_variant",options));
	
			
}
			
			VariantStorage_Controller.prototype.add_upsert_col_order_data = function(){
	var pm = new PublicMethod('upsert_col_order_data',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldString("storage_name",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldString("variant_name",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldString("col_order",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldBool("default_variant",options));
	
			
}
						
			VariantStorage_Controller.prototype.addUpdate = function(){
	VariantStorage_Controller.superclass.addUpdate.call(this);
	var field;	
	var pm = this.getUpdate();
	var options = {};
	options.primaryKey = true;
	var field = new FieldInt("user_id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_user_id",{});
	pm.addField(field);
	
	var options = {};
	options.primaryKey = true;
	var field = new FieldText("storage_name",options);
	
	pm.addField(field);
	
	field = new FieldText("old_storage_name",{});
	pm.addField(field);
	
	var options = {};
	options.primaryKey = true;
	var field = new FieldText("variant_name",options);
	
	pm.addField(field);
	
	field = new FieldText("old_variant_name",{});
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldBool("default_variant",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldText("filter_data",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldText("col_visib_data",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldText("col_order_data",options);
	
	pm.addField(field);
	
	
}

			VariantStorage_Controller.prototype.addDelete = function(){
	VariantStorage_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("user_id",options));
	var options = {"required":true};
		
	pm.addField(new FieldText("storage_name",options));
	var options = {"required":true};
		
	pm.addField(new FieldText("variant_name",options));
}

			VariantStorage_Controller.prototype.addGetList = function(){
	VariantStorage_Controller.superclass.addGetList.call(this);
	
	
	
	var pm = this.getGetList();
		var options = {};
		
			options.required = true;
						
		pm.addField(new FieldString("storage_name",options));
	
		var options = {};
						
		pm.addField(new FieldString("variant_name",options));
	
}

			VariantStorage_Controller.prototype.addGetObject = function(){
	VariantStorage_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("user_id",f_opts));
	var f_opts = {};
		
	pm.addField(new FieldText("storage_name",f_opts));
	var f_opts = {};
		
	pm.addField(new FieldText("variant_name",f_opts));
}

			VariantStorage_Controller.prototype.add_get_filter_data = function(){
	var pm = new PublicMethod('get_filter_data',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldString("storage_name",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("variant_name",options));
	
			
}

			VariantStorage_Controller.prototype.add_get_col_visib_data = function(){
	var pm = new PublicMethod('get_col_visib_data',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldString("storage_name",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("variant_name",options));
	
			
}
			
			VariantStorage_Controller.prototype.add_get_col_order_data = function(){
	var pm = new PublicMethod('get_col_order_data',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldString("storage_name",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("variant_name",options));
	
			
}
			
		