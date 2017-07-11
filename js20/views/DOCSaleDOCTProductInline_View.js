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
function DOCSaleDOCTProductInline_View(id,options){
	options = options || {};	
	
	this.m_discountPercent = (options.discountPercent!=undefined)? options.discountPercent:0;
	
	DOCSaleDOCTProductInline_View.superclass.constructor.call(this,id,options);
}
extend(DOCSaleDOCTProductInline_View, ViewGridEditInlineAjx);

/* Constants */


/* private members */

/* protected*/


/* public methods */
DOCSaleDOCTProductInline_View.prototype.addEditControls = function(){
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
	
	this.addElement(new DOCProductionEditRef(this.getId()+":doc_production",{
		"required":true,
		"labelCaption":"",
		"selectWinClass":ProductBalanceList_Form,
		"keyIds":["doc_production_id"],
		"selectKeyIds":["doc_production_id"],
		"formatFunction":function(fields){
			var prod_f = (fields.product_descr)? "product_descr":"name";
			return CommonHelper.format("№ % (%), %",
				[
				fields.doc_production_number.getValue(),
				DateHelper.format(fields.doc_production_date_time.getValue(),this.getApp().getDateFormat()),
				fields[prod_f].getValue()
				]
			);
		},		
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

DOCSaleDOCTProductInline_View.prototype.setWritePublicMethod = function(pm){	
	if (pm){
		var cmd = this.getCommands()[this.CMD_OK];
		
		cmd.setBindings([
			new CommandBinding({"control":this.getElement("quant")}),
			new CommandBinding({"control":this.getElement("price_no_disc")}),
			new CommandBinding({"control":this.getElement("total")}),
			new CommandBinding({"control":this.getElement("disc_percent")}),
			new CommandBinding({"control":this.getElement("doc_production"),"fieldId":"doc_production_id"})
		]);
	
		this.setKeysPublicMethod(pm);
	
		cmd.setPublicMethod(pm);
	}
}

DOCSaleDOCTProductInline_View.prototype.setReadBinds = function(pm){
	
	if (pm){	
		var model = new DOCSaleDOCTProductList_Model();
		this.setDataBindings([
			new DataBinding({"control":this.getElement("line_number"),"model":model}),
			new DataBinding({"control":this.getElement("quant"),"model":model}),
			new DataBinding({"control":this.getElement("price_no_disc"),"model":model}),
			new DataBinding({"control":this.getElement("total"),"model":model}),
			new DataBinding({"control":this.getElement("disc_percent"),"model":model}),
			new DataBinding({"control":this.getElement("doc_production"),"model":model,
				"field":model.getField("doc_production_id"),"keyIds":["doc_production_id"]
			})
		]);
	}
}

