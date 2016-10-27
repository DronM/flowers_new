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
function DOCProductDisposal_View(id,options){
	options = options || {};	
		
	DOCProductDisposal_View.superclass.constructor.call(this,id,options);
	
	var self = this;
	var multy_store = (this.getApp().getServVars().multy_store);

	this.addElement(new HiddenKey(id+":id"));	
	
	this.addElement(new DOCNumberEdit(id+":number",{"app":options.app}));
	
	this.addElement(new DOCDateEdit(id+":date_time",{"app":options.app}));
	
	
	if (multy_store){
		this.addElement(new StoreSelect(id+":store",{"app":options.app}));
	}
	
	this.addElement(new EditText(id+":explanation",{"app":options.app}));
	
	//****************************************************
	var contr = new DOCProductDisposal_Controller(options.app);
	
	//read
	this.setReadPublicMethod(contr.getPublicMethod("get_object"));
	this.m_model = new DOCProductDisposalList_Model({"data":options.modelDataStr});
	this.setDataBindings([
		new DataBinding({"control":this.getElement("id"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("number"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("date_time"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("explanation"),"model":this.m_model})		
	]);
		
	//write
	this.setController(contr);
	this.getCommand(this.CMD_OK).setBindings([
		new CommandBinding({"control":this.getElement("id")}),
		new CommandBinding({"control":this.getElement("number")}),
		new CommandBinding({"control":this.getElement("date_time")}),
		new CommandBinding({"control":this.getElement("explanation")})
	]);
	
	if (multy_store){
		this.addDataBinding(new DataBinding({"control":this.getElement("store"),"model":this.m_model,"field":this.m_model.getField("store_id")}));
		this.getCommand(this.CMD_OK).addBinding(new CommandBinding({"store":this.getElement("store"),"fieldId":"store_id"}));
	}
	
}
extend(DOCProductDisposal_View,ViewDOC);

/* Constants */


/* private members */

/* protected*/


/* public methods */

