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
function DOCSaleDOCTMaterialInline_View(id,options){
	options = options || {};	
	
	this.m_discountPercent = (options.discountPercent!=undefined)? options.discountPercent:0;
	
	DOCSaleDOCTMaterialInline_View.superclass.constructor.call(this,id,options);
}
extend(DOCSaleDOCTMaterialInline_View, ViewGridEditInlineAjx);

/* Constants */


/* private members */

/* protected*/


/* public methods */
DOCSaleDOCTMaterialInline_View.prototype.addEditControls = function(){
	var self = this;
	var recalc = function(){
		var tot_no_disc = self.getElement("price_no_disc").getValue()*self.getElement("quant").getValue();
		self.getElement("total").setValue(
			(Math.round(parseFloat(tot_no_disc - tot_no_disc*self.getElement("disc_percent").getValue()/100)*100))/100
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
		"selectWinClass":MaterialBalanceList_Form,
		"keyIds":["material_id"],
		"onSelect":function(fields){
			self.getElement("quant").setValue(1);
			self.getElement("price_no_disc").setValue(fields.price.getValue());
			recalc();
		},	
		"app":this.getApp()
	}));
	
	
	this.addElement(new EditFloat(this.getId()+":quant",{
		"value":1,
		"events":{
			"keypress":recalc_key,
			"blur":recalc,
			"change":recalc
		},
		"app":this.getApp()
	}));
	
	this.addElement(new EditFloat(this.getId()+":price_no_disc",{
		"value":0,
		"events":{
			"keypress":recalc_key,
			"blur":recalc,		
			"change":recalc
		},	
		"app":this.getApp()
	}));

	this.addElement(new EditFloat(this.getId()+":disc_percent",{
		"value":this.m_discountPercent,
		"events":{
			"keypress":recalc_key,
			"blur":recalc,		
			"change":recalc
		},	
		"app":this.getApp()
	}));
	
	this.addElement(new EditFloat(this.getId()+":total",{"app":this.getApp()}));

}

DOCSaleDOCTMaterialInline_View.prototype.setWritePublicMethod = function(pm){	
	if (pm){
		var cmd = this.getCommands()[this.CMD_OK];
		
		cmd.setBindings([
			new CommandBinding({"control":this.getElement("quant")}),
			new CommandBinding({"control":this.getElement("price_no_disc")}),
			new CommandBinding({"control":this.getElement("total")}),
			new CommandBinding({"control":this.getElement("disc_percent")}),
			new CommandBinding({"control":this.getElement("material"),"fieldId":"material_id"})
		]);
	
		this.setKeysPublicMethod(pm);
	
		cmd.setPublicMethod(pm);
	}
}
