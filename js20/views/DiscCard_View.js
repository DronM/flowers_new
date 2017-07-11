/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function DiscCard_View(id,options){	

	options = options || {};
	
	DiscCard_View.superclass.constructor.call(this,id,options);
		
	var self = this;

	this.addElement(new HiddenKey(id+":id"));	
	
	this.addElement(new EditString(id+":barcode",{
		"labelCaption":"Штрихкод:",
		"cmdClear":false,
		"enabled":false,
		"app":options.app
	}));	

	this.addElement(new DiscountSelect(id+":discount",{
		"labelCaption":"Вид скидки:",
		"app":options.app
	}));	

	//****************************************************
	var contr = new DiscCard_Controller(options.app);
	
	//read
	this.setReadPublicMethod(contr.getPublicMethod("get_object"));
	this.m_model = new DiscCard_Model({"data":options.modelDataStr});
	this.setDataBindings([
		new DataBinding({"control":this.getElement("id"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("barcode"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("discount"),"model":this.m_model,"field":this.m_model.getField("discount_id")})
	]);
	
	//write
	this.setController(contr);
	this.getCommand(this.CMD_OK).setBindings([
		new CommandBinding({"control":this.getElement("id")}),
		new CommandBinding({"control":this.getElement("barcode")}),
		new CommandBinding({"control":this.getElement("discount"),"fieldId":"discount_id"})
	]);
}
extend(DiscCard_View,ViewObjectAjx);
