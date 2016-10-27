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

function Product_Controller(app,options){
	options = options || {};
	options.listModelId = "ProductList_Model";
	options.objModelId = "Product_Model";
	Product_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.addComplete();
	this.add_complete_for_spec();
	this.add_get_list_with_balance();
	this.add_get_list_for_sale();
	this.add_get_price();
		
}
extend(Product_Controller,ControllerDb);

			Product_Controller.prototype.addInsert = function(){
	Product_Controller.superclass.addInsert.call(this);
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
	options.alias = "Заказывать автоматически";
	var field = new FieldBool("make_order",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Минимальный остаток";
	var field = new FieldFloat("min_stock_quant",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			Product_Controller.prototype.addUpdate = function(){
	Product_Controller.superclass.addUpdate.call(this);
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
	options.alias = "Заказывать автоматически";
	var field = new FieldBool("make_order",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Минимальный остаток";
	var field = new FieldFloat("min_stock_quant",options);
	
	pm.addField(field);
	
	
	
}

			Product_Controller.prototype.addDelete = function(){
	Product_Controller.superclass.addDelete.call(this);
	var options = {"required":true};
	
	var pm = this.getDelete();
	pm.addField(new FieldInt("id",options));
}

			Product_Controller.prototype.addGetList = function(){
	Product_Controller.superclass.addGetList.call(this);
	var options = {};
	
	var pm = this.getGetList();
	pm.addField(new FieldInt("id",options));
	pm.addField(new FieldString("name",options));
	pm.addField(new FieldFloat("price",options));
	pm.addField(new FieldBool("for_sale",options));
}

			Product_Controller.prototype.addGetObject = function(){
	Product_Controller.superclass.addGetObject.call(this);
	var options = {};
	
	var pm = this.getGetObject();
	pm.addField(new FieldInt("id",options));
}

			Product_Controller.prototype.addComplete = function(){
	Product_Controller.superclass.addComplete.call(this);
	
	var options = {};
	
	var pm = this.getComplete();
	pm.addField(new FieldFloat("price",options));
	pm.getField(this.PARAM_ORD_FIELDS).setValue("price");
}

			Product_Controller.prototype.add_complete_for_spec = function(){
	var pm = new PublicMethod('complete_for_spec',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldString("name",options));
	
			
}

			Product_Controller.prototype.add_get_list_with_balance = function(){
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

			Product_Controller.prototype.add_get_list_for_sale = function(){
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
			
			Product_Controller.prototype.add_get_price = function(){
	var pm = new PublicMethod('get_price',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldInt("product_id",options));
	
			
}
	
		