/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function ClientDialog_View(id,options){	

	options = options || {};
	
	ClientDialog_View.superclass.constructor.call(this,id,options);
		
	var self = this;

	this.addElement(new HiddenKey(id+":id"));	
	
	this.addElement(new ClientNameEdit(id+":name",{
		"app":options.app,
		"events":{
			"onblur":function(){
				self.copyControl("name","name_full");	
			}
		}
	}));	

	this.addElement(new EditString(id+":name_full",{
		"labelCaption":"Полн. наименование:",
		"placeholder":"Полное наименование клиента",
		"maxlength":255,
		"app":options.app
	}));	

	this.addElement(new EditPhone(id+":tel",{
		"labelCaption":"Телефон:",
		"app":options.app
	}));	

	this.addElement(new EditEmail(id+":email",{
		"labelCaption":"Email:",
		"app":options.app
	}));	

	this.addElement(new DiscCardEditRef(id+":disc_card",{"app":options.app}));	

	//****************************************************
	var contr = new Client_Controller(options.app);
	
	//read
	this.setReadPublicMethod(contr.getPublicMethod("get_object"));
	this.m_model = new ClientDialog_Model({"data":options.modelDataStr});
	this.setDataBindings([
		new DataBinding({"control":this.getElement("id"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("name"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("name_full"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("tel"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("email"),"model":this.m_model}),
		new DataBinding({
			"control":this.getElement("disc_card"),
			"model":this.m_model,
			"field":this.m_model.getField("disc_card_barcode"),
			"keyIds":["disc_card_id"]}
		),		
	]);
	
	//write
	this.setController(contr);
	this.getCommand(this.CMD_OK).setBindings([
		new CommandBinding({"control":this.getElement("id")}),
		new CommandBinding({"control":this.getElement("name")}),
		new CommandBinding({"control":this.getElement("name_full")}),
		new CommandBinding({"control":this.getElement("tel")}),
		new CommandBinding({"control":this.getElement("email")}),
		new CommandBinding({"control":this.getElement("disc_card"),"fieldId":"disc_card_id"})
	]);
}
extend(ClientDialog_View,ViewObjectAjx);
