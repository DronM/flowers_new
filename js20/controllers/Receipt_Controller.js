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

function Receipt_Controller(app,options){
	options = options || {};
	options.listModelId = "ReceiptList_Model";
	Receipt_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addGetList();
	this.addDelete();
	this.add_add_material();
	this.add_add_product();
	this.add_edit_item();
	this.add_clear();
	this.add_close();
	this.add_add_by_code();
	this.add_fill_on_client_order();
		
}
extend(Receipt_Controller,ControllerDb);

			Receipt_Controller.prototype.addGetList = function(){
	Receipt_Controller.superclass.addGetList.call(this);
	var options = {};
	
	var pm = this.getGetList();
	pm.addField(new FieldInt("user_id",options));
	pm.addField(new FieldInt("item_id",options));
	pm.addField(new FieldInt("item_type",options));
	pm.addField(new FieldInt("doc_production_id",options));
	pm.addField(new FieldString("item_name",options));
	pm.addField(new FieldFloat("quant",options));
	pm.addField(new FieldFloat("price",options));
	pm.addField(new FieldFloat("total",options));
	pm.addField(new FieldFloat("total_no_disc",options));
	pm.addField(new FieldFloat("price_no_disc",options));
	pm.addField(new FieldFloat("disc_percent",options));
}

			Receipt_Controller.prototype.addDelete = function(){
	Receipt_Controller.superclass.addDelete.call(this);
	var options = {"required":true};
	
	var pm = this.getDelete();
	pm.addField(new FieldInt("user_id",options));
	pm.addField(new FieldInt("item_id",options));
	pm.addField(new FieldInt("item_type",options));
}

			Receipt_Controller.prototype.add_add_material = function(){
	var pm = new PublicMethod('add_material',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("item_id",options));
	
			
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
	
		pm.addField(new FieldString("code",options));
	
			
}
						
			Receipt_Controller.prototype.add_fill_on_client_order = function(){
	var pm = new PublicMethod('fill_on_client_order',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("doc_client_order_id",options));
	
			
}
						
		