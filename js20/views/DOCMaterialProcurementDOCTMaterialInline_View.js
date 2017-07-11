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
function DOCMaterialProcurementDOCTMaterialInline_View(id,options){
	options = options || {};	
	
	DOCMaterialProcurementDOCTMaterialInline_View.superclass.constructor.call(this,id,options);
}
extend(DOCMaterialProcurementDOCTMaterialInline_View, ViewGridEditInlineAjx);

/* Constants */


/* private members */

/* protected*/


/* public methods */
DOCMaterialProcurementDOCTMaterialInline_View.prototype.addEditControls = function(){
	var self = this;
	var recalc = function(){
		self.getElement("total").setValue(
			(Math.round(parseFloat(self.getElement("price").getValue()*self.getElement("quant").getValue())*100))/100
		);
	}
	var recalc_key = function(e){
		e = EventHelper.fixMouseEvent(e);
		if (e.keyCode == 13) {
			recalc();
		}
	}
	

	this.addElement(new Edit(this.getId()+":line_number",{"enabled":false,"app":this.getApp()}));
	
	this.addElement(new MaterialEditRef(this.getId()+":material",{
		"required":true,
		"labelCaption":"",
		"selectWinClass":MaterialList_Form,
		"keyIds":["material_id"],
		"onSelect":function(fields){
			self.getElement("quant").setValue(1);
			self.getElement("price").setValue(fields.price.getValue());
			recalc();
		},	
		"app":this.getApp()
	}));
	
	
	this.addElement(new EditFloat(this.getId()+":quant",{
		"events":{
			"keypress":recalc_key,
			"blur":recalc,
			"change":recalc
		},
		"app":this.getApp()
	}));
	
	this.addElement(new EditFloat(this.getId()+":price",{
		"events":{
			"keypress":recalc_key,
			"blur":recalc,		
			"change":recalc
		},	
		"app":this.getApp()
	}));
	
	this.addElement(new EditFloat(this.getId()+":total",{"app":this.getApp()}));

}

DOCMaterialProcurementDOCTMaterialInline_View.prototype.setWritePublicMethod = function(pm){	
	if (pm){
		var cmd = this.getCommands()[this.CMD_OK];
		
		cmd.setBindings([
			new CommandBinding({"control":this.getElement("quant")}),
			new CommandBinding({"control":this.getElement("price")}),
			new CommandBinding({"control":this.getElement("total")}),
			new CommandBinding({"control":this.getElement("material"),"fieldId":"material_id"})
		]);
	
		this.setKeysPublicMethod(pm);
	
		cmd.setPublicMethod(pm);
	}
}
