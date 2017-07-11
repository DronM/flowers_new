/* Copyright (c) 2016 
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
 * @requires 
 * @requires core/extend.js  
*/

/* constructor
@param string id
@param object options{

}
*/
function ItemsForSaleGrid(id,options){
	options = options || {};	
	
	options.tagName = "div";
	options.autoRefresh = false;
	options.navigate = false;
	
	var constants = {"sale_item_cols":null};
	options.app.getConstantManager().get(constants);
	
	this.m_saleItemCols = constants.sale_item_cols;
	
	ItemsForSaleGrid.superclass.constructor.call(this,id,options);
}
extend(ItemsForSaleGrid,GridAjx);

/* Constants */


/* private members */

/* protected*/
ItemsForSaleGrid.prototype.onGetData = function(){
	if (this.m_model){
		//refresh from model
		var self = this;
		var body = this.getBody();
		var foot = this.getFoot();
		body.delDOM();
		body.clear();
	
		
		var field_cnt;
		var row,row_keys;
		this.m_model.reset();

		//******* added ************
		this.m_addedItems = {};
		var self = this;
		
		var hor_item_index = 0;
		var item_index = 0;
		var item_row = null;
		var item_row_count = 0;
		//******* added ************
		
		var set_add_item = function(grid,node,item_id,doc_production_id){
			EventHelper.add(node,"click",
			function(){
				grid.onAddItem.call(self,item_id,doc_production_id);
			}
			,true);
		}
		var set_add_material = function(grid,node,item_id){
			EventHelper.add(node,"click",
			function(){
				grid.onAddMaterial.call(self,item_id);
			}
			,true);
		}

		while(this.m_model.getNextRow()){
			var item_id = this.m_model.getFieldValue('id');
		
			var class_name = "productForSale item_col";
			var not_in_stock = (this.m_model.getFieldValue("quant")<=0);
			if (not_in_stock){
				class_name+=" not_in_stock";
			}
			var row_id = this.getId()+"_prod_"+item_index;
			var row = new GridRow(row_id,{
				"tagName":"div",
				"className":class_name,
				"elements":[
					new GridCell(row_id+":name",{
						"value":this.m_model.getFieldValue("name"),
						"tagName":"div"
						}
					),				
					new GridCell(row_id+":price",{
						"value":this.m_model.getFieldValue("price"),
						"tagName":"div"
						}
					),
					new GridCell(row_id+":quant_descr",{
						"value":this.m_model.getFieldValue("quant_descr"),
						"tagName":"div"
						}
					)					
					
				],
				"attrs":{"item_id":item_id}
			});
			
			if (hor_item_index==0){
				//new row
				if (item_row){				
					body.addElement(item_row);
				}
				item_row = new ControlContainer(this.getId()+"_row_"+item_row_count,"div",{className:"item_row"});						
				item_row_count++;
			}
			//alert("row "+row_id);
			item_row.addElement(row);
		
			hor_item_index++;
			if (hor_item_index==this.m_saleItemCols){
				hor_item_index = 0;
			}
			
			item_index++;
			
			if (!not_in_stock){
				if (this.m_model.getFieldValue("item_type")==1){
					//materials
					this.m_addedItems[row_id] =
						new set_add_material(this,row.m_node,item_id);		
					
				}
				else{
					//products
					this.m_addedItems[row_id] =
						new set_add_item(this,row.m_node,item_id,
							this.m_model.getFieldValue("doc_production_id"));		
					
				}
			}
			
		}
		
		if (item_row){
			body.addElement(item_row);
		}

		body.toDOM(this.m_node);
		
	}
}

ItemsForSaleGrid.prototype.onAddItem = function(itemId,docProductionId){
	var self = this;
	var contr = new Receipt_Controller(this.getApp());
	var pm = contr.getPublicMethod("add_product");
	pm.setFieldValue("doc_production_id",docProductionId);
	pm.setFieldValue("item_id",itemId);
	
	pm.run({
		"async":false,
		"ok":function(){
			self.m_receiptGrid.onRefresh();	
		}
	});
}

ItemsForSaleGrid.prototype.onAddMaterial = function(itemId){
	var self = this;
	var contr = new Receipt_Controller(this.getApp());
	var pm = contr.getPublicMethod("add_material");
	pm.setFieldValue("item_id",itemId);
	
	pm.run({
		"async":false,
		"ok":function(){
			self.m_receiptGrid.onRefresh();	
		}
	});
}

