/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function Product_View(id,options){	

	options = options || {};
	
	Product_View.superclass.constructor.call(this,id,options);
		
	this.addElement(new HiddenKey(id+":id"));	

	var self = this;

	this.addElement(new ProductNameEdit(id+":name",{
		"app":options.app,
		"events":{
			"onblur":function(){
				self.fillNameFull();	
			}
		}
	}));	

	this.addElement(new EditString(id+":name_full",{
		"labelCaption":"Полн. наименование:",
		"placeholder":"Полное наименование продукции",
		"maxlength":255,
		"app":options.app
	}));	

	this.addElement(new EditFloat(id+":price",{
		"labelCaption":"Розничная цена:",
		"placeholder":"Розничная цена продукции",
		"precision":2,
		"minVal":0,
		"app":options.app
	}));	

	this.addElement(new EditCheckBox(id+":for_sale",{
		"labelCaption":"Для продажи:",
		"app":options.app
	}));	

	this.addElement(new EditCheckBox(id+":make_order",{
		"labelCaption":"Заказывать автоматически:",
		"app":options.app
	}));	


	this.addElement(new EditFloat(id+":min_stock_quant",{
		"labelCaption":"Минимальный остаток:",
		"precision":3,
		"minVal":0,
		"app":options.app
	}));	
	
	//specification grid
	var specification_model = new SpecificationList_Model();
	var specification_contr = new Specification_Controller(options.app);
	var grid = new GridAjx(id+":specification-grid",{
		"model":specification_model,
		"controller":specification_contr,
		"editInline":true,
		"editWinClass":null,
		"commands":new GridCommandsAjx(id+":specification-grid:cmd",{
			"cmdEdit":false,
			"cmdCopy":false,
			"app":options.app
			}),
		"head":new GridHead(id+":specification-grid:head",{
			"elements":[
				new GridRow(id+":specification-grid:head:row0",{
					"elements":[
						new GridCellHead(id+":specification-grid:head:material_descr",{
							"columns":[
								new GridColumn("material",{
									"field":specification_model.getField("material_descr"),
									"ctrlClass":MaterialEditRef,
									"ctrlOptions":{
										"labelCaption":"",
										"keyIds":["material_id"]
									},
									"ctrlBindField":specification_model.getField("material_id")
									})
							]
						}),
					
						new GridCellHead(id+":specification-grid:head:quant",{
							"columns":[
								new GridColumn("quant",{"field":specification_model.getField("material_quant"),
									"ctrlOptions":{"minValue":"1"}
									})
							]
						})						
					]
				})
			]
		}),
		"autoRefresh":false,
		"enabled":false,
		"app":options.app
	});	
	
	this.addElement(grid);
	
	/*
	grid.initEditWinObj = function(cmd){
		GridAjx.superclass.initEditWinObj.call(this,cmd);
		this.getEditWinObj().setProgId(self.m_model.getFieldValue("id"));
	};
	*/
	//****************************************************
	var contr = new Product_Controller(options.app);
	
	//read
	this.setReadPublicMethod(contr.getPublicMethod("get_object"));
	this.m_model = new Product_Model({"data":options.modelDataStr});
	this.setDataBindings([
		new DataBinding({"control":this.getElement("id"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("name"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("name_full"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("price"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("make_order"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("for_sale"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("min_stock_quant"),"model":this.m_model})
	]);
	
	//write
	this.setController(contr);
	this.getCommand(this.CMD_OK).setBindings([
			new CommandBinding({"control":this.getElement("id")}),
			new CommandBinding({"control":this.getElement("name")}),
			new CommandBinding({"control":this.getElement("name_full")}),
			new CommandBinding({"control":this.getElement("price")}),
			new CommandBinding({"control":this.getElement("make_order")}),
			new CommandBinding({"control":this.getElement("for_sale")}),
			new CommandBinding({"control":this.getElement("min_stock_quant")})
	]);
	
	this.addDetailDataSet({
		"control":grid,
		"controlFieldId":"product_id",
		"field":this.m_model.getField("id")
	});
	
	
}
extend(Product_View,ViewObjectAjx);

/*
Product_View.prototype.setProductId = function(){
	this.getElement("specification-grid").get
}
*/
Product_View.prototype.fillNameFull = function(){
	var name = this.getElement("name").getValue();
	var name_full = this.getElement("name_full").getValue();
	if (name && !name_full){
		this.getElement("name_full").setValue(name);
	}
}
