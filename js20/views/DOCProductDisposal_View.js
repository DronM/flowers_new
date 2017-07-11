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
	
	var contr = new DOCProductDisposal_Controller(options.app);
	this.m_printPublicMethod = contr.getPublicMethod("get_print");
	
	options.detailDataSetsExist = false;
	options.cmdPrint = true;
	options.printList = contr.getPrintList();	
		
	DOCProductDisposal_View.superclass.constructor.call(this,id,options);

	//Номер && Дата
	this.addElement(new DOCNumberEdit(id+":number",{"app":options.app}));	
	this.addElement(new DOCDateEdit(id+":date_time",{"app":options.app}));	
	
	var self = this;
	var multy_store = (this.getApp().getServVars().multy_store);

	if (multy_store=="1"){
		this.addElement(new StoreSelect(id+":store",{"app":options.app}));
	}

	var ctrl_docProduction = new DOCProductionEditRef(id+":doc_production",{
		"selectWinClass":ProductBalanceList_Form,
		"keyIds":["doc_production_id"],
		"selectKeyIds":["doc_production_id"],
		"app":options.app
	});
	
	this.addElement(ctrl_docProduction);
	
	this.addElement(new EditText(id+":explanation",{
		"labelCaption":this.CTRL_EXPL_CAP,
		"app":options.app}));
	
	//****************************************************	
	
	//read
	this.setReadPublicMethod(contr.getPublicMethod("get_object"));
	this.m_model = new DOCProductDisposalList_Model({"data":options.modelDataStr});
	this.setDataBindings([
		new DataBinding({"control":this.getElement("number"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("date_time"),"model":this.m_model}),
		new DataBinding({
			"control":ctrl_docProduction,
			"model":this.m_model,
			"keyIds":["doc_production_id"]}
		),
		new DataBinding({"control":this.getElement("explanation"),"model":this.m_model})		
	]);
		
	//write
	this.setController(contr);
	this.getCommand(this.CMD_OK).setBindings([
		new CommandBinding({"control":this.getElement("number")}),
		new CommandBinding({"control":this.getElement("date_time")}),
		new CommandBinding({"control":this.getElement("doc_production"),"fieldId":"doc_production_id"}),
		new CommandBinding({"control":this.getElement("explanation")})
	]);
	
	this.addDefDataBindings();
	
	if (multy_store=="1"){
		this.getCommand(this.CMD_OK).getBindings().push((new CommandBinding({"control":this.getElement("store"),"fieldId":"store_id","keyIds":["store_id"]})));
		this.addDataBinding(new DataBinding({"control":this.getElement("store"),"model":this.m_model,"field":this.m_model.getField("store_id")}));
	}
	
}
extend(DOCProductDisposal_View,ViewDOC);

/* Constants */


/* private members */

/* protected*/


/* public methods */
DOCProductDisposal_View.prototype.onGetData = function(resp,cmd){
	DOCProductDisposal_View.superclass.onGetData.call(this,resp,cmd);
	
	this.m_printPublicMethod.setFieldValue("doc_id",this.getElement("id").getValue());	
}

