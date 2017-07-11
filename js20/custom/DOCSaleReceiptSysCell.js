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
function DOCSaleReceiptSysCell(id,options){
	options = options || {};	
	
	var self = this;
	
	options.elements = [
		new ButtonCtrl(id+":del",{
			"glyph":"glyphicon-remove",
			"title":"удалить позицию",
			"onClick":function(){
				self.del(CommonHelper.json2obj(self.m_row.getAttr("keys")));
			},
			"app":options.app
		})		
		
	];
	
	DOCSaleReceiptSysCell.superclass.constructor.call(this,id,options);
}
extend(DOCSaleReceiptSysCell,GridCell);

/* Constants */


/* private members */

/* protected*/


/* public methods */
DOCSaleReceiptSysCell.prototype.del = function(keys){
	var contr = new Receipt_Controller(this.getApp());
	var pm = contr.getPublicMethod("delete");
	pm.setFieldValue("user_id",keys["user_id"]);
	pm.setFieldValue("item_id",keys["item_id"]);
	pm.setFieldValue("item_type",keys["item_type"]);
	pm.run({"async":false});
	this.getGridColumn().m_grid.onRefresh();
}
