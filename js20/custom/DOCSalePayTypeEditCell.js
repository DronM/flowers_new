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
function DOCSalePayTypeEditCell(id,options){
	options.value = options.gridColumn.getField().getValue();
	options.attrs = options.attrs || {};
	options.attrs.fieldId = options.gridColumn.getField().getId();
	options.editOptions = {
		"cmdSelect":false,
		"editContClassName":"input-group "+window.getBsCol()+"12",
		"app":options.app
	}

	this.m_editClass = options.editClass;
	this.m_editOptions = options.editOptions;
	this.m_gridColumn = options.gridColumn;
	this.m_row = options.row;
	this.m_value = options.value;
	options.value = null;
	
	DOCSalePayTypeEditCell.superclass.constructor.call(this,id,"td",options);	
}
extend(DOCSalePayTypeEditCell,Control);

DOCSalePayTypeEditCell.prototype.toDOM = function(parent){

	DOCSalePayTypeEditCell.superclass.toDOM.call(this,parent);
	
	var self = this;
	
	var edit_opts = this.m_editOptions || {};
	edit_opts.value = this.m_value;
	edit_opts.events = {
		"blur":function(){
			self.update();
		},		
		"keydown":function(e){
			if (e.keyCode === 13) { 
				self.update();
			}
		}
	};
	
	this.m_edit = new this.m_editClass(this.getId()+"_edit",edit_opts);
	this.m_edit.toDOM(this.m_node);
	
}
DOCSalePayTypeEditCell.prototype.delDOM = function(){
	this.m_edit.delDOM();
	delete this.m_edit;
	DOCSalePayTypeEditCell.superclass.delDOM.call(this);
}

DOCSalePayTypeEditCell.prototype.update = function(){
	var gr = this.m_gridColumn.getGrid();			
	var row_n = this.m_row.getNode();
	gr.setModelToCurrentRow(row_n);
	var m = gr.getModel();
	var total_old = m.getFieldValue("total");
	var total = parseFloat(DOMHelper.getElementsByAttr("total", row_n, "fieldId", true,"td")[0].getElementsByTagName("input")[0].value);

	if (!isNaN(total) && total && total!=total_old){
		var pm = gr.getReadPublicMethod().getController().getPublicMethod("set_payment_type_total");
		pm.setFieldValue("dt",m.getFieldValue("dt"));
		pm.setFieldValue("total",total);

		pm.run({async:false});
		gr.onRefresh();				
	}
}

function DOCSalePayTypeTotalCell(id,options){
	options.editClass = EditMoney;
	options.className = "form-control input-lg";
	DOCSalePayTypeTotalCell.superclass.constructor.call(this,id,options);
}
extend(DOCSalePayTypeTotalCell,DOCSalePayTypeEditCell);
