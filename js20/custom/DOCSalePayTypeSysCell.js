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
function DOCSalePayTypeSysCell(id,options){
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
	
	DOCSalePayTypeSysCell.superclass.constructor.call(this,id,options);
}
extend(DOCSalePayTypeSysCell,GridCell);

/* Constants */


/* private members */

/* protected*/


/* public methods */
DOCSalePayTypeSysCell.prototype.del = function(keys){
	var contr = new Receipt_Controller(this.getApp());
	var pm = contr.getPublicMethod("del_payment_type");
	pm.setFieldValue("dt",keys["dt"]);
	pm.run({"async":false});
	this.getGridColumn().m_grid.onRefresh();
}
