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

function Receipt_Controller(app,options){
	options = options || {};
	options.listModel = ReceiptList_Model;
	Receipt_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addGetList();
	this.addDelete();
	this.add_add_material();
	this.add_set_disc_percent();
	this.add_add_product();
	this.add_edit_item();
	this.add_clear();
	this.add_close();
	this.add_add_by_code();
	this.add_fill_on_client_order();
	this.add_save_head();
	this.add_add_payment_type();
	this.add_set_payment_type_total();
	this.add_del_payment_type();
	this.add_get_payment_type_list();
		
}
extend(Receipt_Controller,ControllerDb);

			Receipt_Controller.prototype.addGetList = function(){
	Receipt_Controller.superclass.addGetList.call(this);
	
	
	
	var pm = this.getGetList();
	var f_opts = {};
	
	pm.addField(new FieldInt("user_id",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("item_id",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("item_type",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("doc_production_id",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldString("item_name",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldFloat("quant",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldFloat("price",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldFloat("total",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldFloat("total_no_disc",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldFloat("price_no_disc",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldFloat("disc_percent",f_opts));
}

			Receipt_Controller.prototype.addDelete = function(){
	Receipt_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("user_id",options));
	var options = {"required":true};
		
	pm.addField(new FieldInt("item_id",options));
	var options = {"required":true};
		
	pm.addField(new FieldInt("item_type",options));
}

			Receipt_Controller.prototype.add_add_material = function(){
	var pm = new PublicMethod('add_material',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("item_id",options));
	
			
}
						
			Receipt_Controller.prototype.add_set_disc_percent = function(){
	var pm = new PublicMethod('set_disc_percent',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldFloat("disc_percent",options));
	
			
}
												
			Receipt_Controller.prototype.add_add_product = function(){
	var pm = new PublicMethod('add_product',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("item_id",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_production_id",options));
	
			
}

			Receipt_Controller.prototype.add_edit_item = function(){
	var pm = new PublicMethod('edit_item',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("item_id",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("item_type",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_production_id",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("quant",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldFloat("disc_percent",options));
	
			
}
												
			Receipt_Controller.prototype.add_clear = function(){
	var pm = new PublicMethod('clear',{controller:this});
	this.addPublicMethod(pm);
	
}

			Receipt_Controller.prototype.add_close = function(){
	var pm = new PublicMethod('close',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("payment_type_for_sale_id",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("client_id",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_client_order_id",options));
	
			
}

			Receipt_Controller.prototype.add_add_by_code = function(){
	var pm = new PublicMethod('add_by_code',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldString("barcode",options));
	
			
}
						
			Receipt_Controller.prototype.add_fill_on_client_order = function(){
	var pm = new PublicMethod('fill_on_client_order',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_client_order_id",options));
	
			
}
						
			Receipt_Controller.prototype.add_save_head = function(){
	var pm = new PublicMethod('save_head',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("client_id",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("discount_id",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_client_order_id",options));
	
			
}
									
			Receipt_Controller.prototype.add_add_payment_type = function(){
	var pm = new PublicMethod('add_payment_type',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldInt("payment_type_for_sale_id",options));
	
			
}
												
			Receipt_Controller.prototype.add_set_payment_type_total = function(){
	var pm = new PublicMethod('set_payment_type_total',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldString("dt",options));
	
				
	
	var options = {};
	
		options.maxlength = "15";
	
		pm.addField(new FieldFloat("total",options));
	
			
}
															
			Receipt_Controller.prototype.add_del_payment_type = function(){
	var pm = new PublicMethod('del_payment_type',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldString("dt",options));
	
			
}
															
			Receipt_Controller.prototype.add_get_payment_type_list = function(){
	var pm = new PublicMethod('get_payment_type_list',{controller:this});
	this.addPublicMethod(pm);
	
			
}
															
			
		