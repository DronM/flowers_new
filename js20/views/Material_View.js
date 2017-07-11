/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function Material_View(id,options){	

	options = options || {};
	
	var contr = new Material_Controller(options.app);
	options.printList = contr.getPrintList();
	
	Material_View.superclass.constructor.call(this,id,options);
		
	var self = this;

	this.addElement(new HiddenKey(id+":id"));	
	
	this.addElement(new MaterialNameEdit(id+":name",{
		"app":options.app,
		"events":{
			"onblur":function(){
				self.copyControl("name","name_full");	
			}
		}
	}));	

	this.addElement(new EditString(id+":name_full",{
		"labelCaption":"Полн. наименование:",
		"placeholder":"Полное наименование материала",
		"maxlength":255,
		"app":options.app
	}));	

	this.addElement(new EditFloat(id+":price",{
		"labelCaption":"Розничная цена:",
		"placeholder":"Розничная цена материала",
		"precision":2,
		"minVal":0,
		"app":options.app
	}));	

	this.addElement(new EditCheckBox(id+":for_sale",{
		"labelCaption":"Для продажи:",
		"app":options.app
	}));	

	this.addElement(new EditInt(id+":margin_percent",{
		"labelCaption":"Наценка:",
		"app":options.app
	}));	
	
	this.addElement(new MaterialGroupSelect(id+":material_group",{
		"labelCaption":"Группа материалов:",
		"keyIds":["material_group_id"],
		"app":options.app
	}));	
	
	//****************************************************	
	
	//read
	this.setReadPublicMethod(contr.getPublicMethod("get_object"));
	this.m_model = new Material_Model({"data":options.modelDataStr});
	this.setDataBindings([
		new DataBinding({"control":this.getElement("id"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("name"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("name_full"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("price"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("for_sale"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("margin_percent"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("material_group"),"model":this.m_model,"keyIds":["material_group_id"]})
	]);
	
	//write
	this.setController(contr);
	this.getCommand(this.CMD_OK).setBindings([
		new CommandBinding({"control":this.getElement("id")}),
		new CommandBinding({"control":this.getElement("name")}),
		new CommandBinding({"control":this.getElement("name_full")}),
		new CommandBinding({"control":this.getElement("price")}),
		new CommandBinding({"control":this.getElement("for_sale")}),
		new CommandBinding({"control":this.getElement("margin_percent")}),
		new CommandBinding({"control":this.getElement("material_group"),"fieldId":"material_group_id"})
	]);
}
extend(Material_View,ViewObjectAjx);

/*
Material_View.prototype.fillNameFull = function(){
	var name = this.getElement("name").getValue();
	var name_f = this.getElement("name_full").getValue();	
	if (name.length && !name_f.length){
		this.getElement("name_full").setValue(name);
	}
}
*/
