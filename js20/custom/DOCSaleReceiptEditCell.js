/* Copyright (c) 2012 
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
//ф
/** Requirements
 * @requires common/functions.js
*/

/* constructor */
function DOCSaleReceiptEditCell(id,options){
	options.value = options.gridColumn.getField().getValue();
	options.attrs = options.attrs || {};
	options.attrs.fieldId = options.gridColumn.getField().getId();
	options.editOptions = {
		"cmdSelect":false,
		"editContClassName":"input-group "+window.getBsCol()+"12"
	}

	this.m_editClass = options.editClass;
	this.m_editOptions = options.editOptions;
	this.m_gridColumn = options.gridColumn;
	this.m_row = options.row;
	this.m_value = options.value;
	options.value = null;
	
	DOCSaleReceiptEditCell.superclass.constructor.call(this,id,"td",options);	
}
extend(DOCSaleReceiptEditCell,Control);

DOCSaleReceiptEditCell.prototype.toDOM = function(parent){

	DOCSaleReceiptEditCell.superclass.toDOM.call(this,parent);
	
	var self = this;
	
	var edit_opts = this.m_editOptions || {};
	edit_opts.value = this.m_value;
	edit_opts.events = {
		"keydown":function(e){
		if (e.keyCode === 13) { 
			var gr = self.m_gridColumn.getGrid();			
			var row_n = self.m_row.getNode();
			gr.setModelToCurrentRow(row_n);
			var m = gr.getModel();
			var quant_old = m.getFieldValue("quant");
			var disc_percent_old = m.getFieldValue("disc_percent");
			var quant = parseFloat(DOMHelper.getElementsByAttr("quant", row_n, "fieldId", true,"td")[0].getElementsByTagName("input")[0].value);
			var disc_percent = parseFloat(DOMHelper.getElementsByAttr("disc_percent", row_n, "fieldId", true,"td")[0].getElementsByTagName("input")[0].value);
			
			if ((quant && quant!=quant_old)
			|| (disc_percent!=disc_percent_old)
			){
				var item_id = m.getFieldValue("item_id");
				var item_type = m.getFieldValue("item_type");
				var doc_production_id = m.getFieldValue("doc_production_id");
				self.updateItem(
					item_id,item_type,doc_production_id,
					quant,disc_percent
				);
			}
		}
	}
	};
	
	
	this.m_edit = new this.m_editClass(this.getId()+"_edit",edit_opts);
	this.m_edit.toDOM(this.m_node);
	
}
DOCSaleReceiptEditCell.prototype.delDOM = function(){
	this.m_edit.delDOM();
	delete this.m_edit;
	DOCSaleReceiptEditCell.superclass.delDOM.call(this);
}
DOCSaleReceiptEditCell.prototype.updateItem = function(
		itemId,item_type,docProductionId,
		quant,disc_percent){
	
	var gr = this.m_gridColumn.getGrid();			
	var pm = gr.getReadPublicMethod().getController().getPublicMethod("edit_item");
	pm.setFieldValue("item_id",itemId);
	pm.setFieldValue("item_type",item_type);
	pm.setFieldValue("doc_production_id",docProductionId);
	pm.setFieldValue("quant",quant);
	pm.setFieldValue("disc_percent",disc_percent);
			
	pm.run({async:false});
	gr.onRefresh();
}

function ReceiptQuantCell(id,options){
	options.editClass = EditInt;
	ReceiptQuantCell.superclass.constructor.call(this,id,options);
}
extend(ReceiptQuantCell,DOCSaleReceiptEditCell);

function ReceiptDiscPercentCell(id,options){
	options.editClass = EditInt;
	
	ReceiptDiscPercentCell.superclass.constructor.call(this,id,options);
}
extend(ReceiptDiscPercentCell,DOCSaleReceiptEditCell);

