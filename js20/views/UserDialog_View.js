/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function UserDialog_View(id,options){	

	options = options || {};
	
	UserDialog_View.superclass.constructor.call(this,id,options);
		
	var self = this;

	this.addElement(new HiddenKey(id+":id"));	
	
	this.addElement(new UserNameEdit(id+":name",{
		"app":options.app
	}));	

	this.addElement(new Enum_role_types(id+":role",{
		"labelCaption":"Роль:",
		"required":true,
		"app":options.app
	}));	
	
	/*
	this.addElement(new EditString(id+":pwd",{
		"labelCaption":"Пароль:",
		"app":options.app,
		"events":{
			"onblur":function(){
				self.checkPass();	
			}
		}
	}));	
	this.addElement(new EditString(id+":pwd-confirm",{
		"labelCaption":"Подтверждение пароля:",
		"app":options.app,
		"events":{
			"onblur":function(){
				self.checkPass();	
			}
		}
	}));	
*/
	this.addElement(new EditCheckBox(id+":constrain_to_store",{
		"labelCaption":"Привязывать к магазину:",
		"app":options.app
	}));	

	this.addElement(new CashRegisterSelect(id+":cash_register",{
		"labelCaption":"ККМ:",
		"app":options.app
	}));	

	this.addElement(new EditEmail(id+":email",{
		"labelCaption":"Эл.почта:",
		"app":options.app
	}));	

	this.addElement(new EditPhone(id+":phone_cel",{
		"labelCaption":"Моб.телефон:",
		"app":options.app
	}));	

	//****************************************************
	var contr = new User_Controller(options.app);
	
	//read
	this.setReadPublicMethod(contr.getPublicMethod("get_object"));
	this.m_model = new UserDialog_Model({"data":options.modelDataStr});
	this.setDataBindings([
		new DataBinding({"control":this.getElement("id"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("name"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("role"),"model":this.m_model,"field":this.m_model.getField("role_id")}),
		new DataBinding({"control":this.getElement("constrain_to_store"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("cash_register"),"model":this.m_model,"field":this.m_model.getField("cash_register_id")}),
		new DataBinding({"control":this.getElement("email"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("phone_cel"),"model":this.m_model})
	]);
	
	//write
	this.setController(contr);
	this.getCommand(this.CMD_OK).setBindings([
		new CommandBinding({"control":this.getElement("id")}),
		new CommandBinding({"control":this.getElement("name")}),
		new CommandBinding({"control":this.getElement("role"),"fieldId":"role_id"}),
		new CommandBinding({"control":this.getElement("constrain_to_store")}),
		new CommandBinding({"control":this.getElement("cash_register"),"fieldId":"cash_register_id"}),
		new CommandBinding({"control":this.getElement("email")}),
		new CommandBinding({"control":this.getElement("phone_cel")})
	]);
}
extend(UserDialog_View,ViewObjectAjx);

/*
UserDialog_View.prototype.TXT_PWD_ER = "Пароли не совпадают";


UserDialog_View.prototype.checkPass = function(){
	var pwd = this.getElement("pwd").getValue();
	if (pwd.length){
		var pwd_conf = this.getElement("pwd-confirm").getValue();
		if (pwd_conf.length && pwd!=pwd_conf){
			this.getElement("pwd-confirm").setNotValid(this.TXT_PWD_ER);
		}
		else if (pwd_conf.length){
			this.getElement("pwd-confirm").setValid();
		}
	}
}
*/
