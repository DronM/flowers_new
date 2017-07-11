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
function DOCProductionDetMatSysCell(id,options){
	options = options || {};	
	
	var self = this;
	
	options.elements = [
		new ButtonCtrl(id+":inc",{
			"glyph":"glyphicon-plus",
			"title":this.BTN_INC_TITLE,
			"onClick":function(){				
				self.inc(CommonHelper.json2obj(self.m_row.getAttr("keys")));
			}
		}),
		new ButtonCtrl(id+":dec",{
			"glyph":"glyphicon-minus",
			"title":this.BTN_DEC_TITLE,
			"onClick":function(){
				self.dec(CommonHelper.json2obj(self.m_row.getAttr("keys")));
			}
		}),
		new ButtonCtrl(id+":del",{
			"glyph":"glyphicon-remove",
			"title":this.BTN_DEL_TITLE,
			"onClick":function(){
				self.del(CommonHelper.json2obj(self.m_row.getAttr("keys")));
			}
		})		
		
	];
	
	DOCProductionDetMatSysCell.superclass.constructor.call(this,id,options);
}
extend(DOCProductionDetMatSysCell,GridCell);

/* Constants */


/* private members */

/* protected*/


/* public methods */
DOCProductionDetMatSysCell.prototype.updateGrid = function(keys,newQuant){
	var contr = new DOCProductionDOCTMaterial_Controller(this.getApp());
	var pm = contr.getPublicMethod("update");
	pm.setFieldValue("old_view_id",keys["view_id"]);
	pm.setFieldValue("old_line_number",keys["line_number"]);
	pm.setFieldValue("quant",newQuant);
	pm.run({"async":false});
	this.getGridColumn().m_grid.setModified(true);
	this.getGridColumn().m_grid.onRefresh();
}

DOCProductionDetMatSysCell.prototype.inc = function(keys){	
	var m = this.getGridColumn().m_grid.getModel();
	m.getRow(this.m_modelIndex);
	var v = m.getFieldValue("quant") + 1;
	this.updateGrid(keys,v);
}
DOCProductionDetMatSysCell.prototype.dec = function(keys){
	var m = this.getGridColumn().m_grid.getModel();
	m.getRow(this.m_modelIndex);
	var v = m.getFieldValue("quant") - 1;
	if (v)this.updateGrid(keys,v);
}
DOCProductionDetMatSysCell.prototype.del = function(keys){
	//var v = this.getGridColumn().m_grid.getModel().getFieldValue("quant") + 1;
	var contr = new DOCProductionDOCTMaterial_Controller(this.getApp());
	var pm = contr.getPublicMethod("delete");
	pm.setFieldValue("view_id",keys["view_id"]);
	pm.setFieldValue("line_number",keys["line_number"]);
	pm.run({"async":false});
	this.getGridColumn().m_grid.setModified(true);
	this.getGridColumn().m_grid.onRefresh();
}
