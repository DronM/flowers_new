/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function DOCProduction_View(id,options){	

	options = options || {};
	
	DOCProduction_View.superclass.constructor.call(this,id,options);
	
	var bs = options.app.getBsCol();
		
	var multy_store = options.app.getServVars().multy_store;
	
	var self = this;
		
	this.addElement(new HiddenKey(id+":id"));

	this.addElement(new DOCNumberEdit(id+":number",{"app":options.app,"labelCaption":"№"}));	

	var tm = DateHelper.time();
	tm.setHours(0,0,0,0);
	this.addElement(new EditDateTime(id+":date_time",{
		"value":tm,
		"labelCaption":"от",
		"app":options.app
	}));	

	if (multy_store=="1"){
		this.addElement(new StoreSelect(id+":store",{
			"app":options.app
		}));	
	}
	
	this.addElement(new ProductEditRef(id+":product",{
		"onSelect":function(model){
			self.onSetProduct(model);
		},
		"app":options.app
	}));	

	this.addElement(new EditFloat(id+":quant",{
		"labelCaption":"Количество:",
		"value":1,
		"presicion":"3",
		"maxlength":"19",
		"app":options.app
	}));	

	this.addElement(new EditMoney(id+":price",{
		"labelCaption":"Цена:",
		"app":options.app
	}));	

	this.addElement(new EditMoney(id+":mat_sum",{
		"labelCaption":"Стоимость материалов:",
		"enabled":false,
		"cmdSelect":false,
		"app":options.app
	}));	

	this.addElement(new EditMoney(id+":mat_cost",{
		"labelCaption":"Себестоимость материалов:",
		"enabled":false,
		"cmdSelect":false,
		"app":options.app
	}));	

	this.addElement(new EditText(id+":florist_comment",{
		"labelCaption":"Комментарий:",
		"editContClassName":"input-group "+bs+"10",
		"labelClassName":"control-label "+bs+"2",
		"rows":"2",
		"app":options.app
	}));	

	//material grid
	
	var material_model = new DOCProductionDOCTMaterialList_Model();
	var material_contr = new DOCProductionDOCTMaterial_Controller(options.app);
	var grid = new GridAjx(id+":material-grid",{
		"model":material_model,
		"controller":material_contr,
		"editInline":true,
		"editWinClass":null,
		"commands":new GridCommandsAjx(id+":material-grid:cmd",{
			"cmdEdit":false,
			"cmdCopy":false,
			"app":options.app
			}),
		"head":new GridHead(id+":material-grid:head",{
			"elements":[
				new GridRow(id+":material-grid:head:row0",{
					"elements":[
						new GridCellHead(id+":material-grid:head:line_number",{
							"columns":[
								new GridColumn({"field":material_model.getField("line_number"),
									"ctrlClass":Edit,
									"ctrlOptions":{"tagName":"div"}
								})
							]
						}),
					
						new GridCellHead(id+":material-grid:head:material",{
							"columns":[
								new GridColumn({"field":material_model.getField("material_descr"),
									"ctrlClass":MaterialEditRef,
									"ctrlOptions":{"labelCaption":"","selectWinClass":MaterialBalanceList_Form}
								})
							]
						}),
					
						new GridCellHead(id+":material-grid:head:quant",{
							"columns":[
								new GridColumnFloat({"field":material_model.getField("quant"),
									"ctrlOptions":{"value":"1"}
								})
							]
						})						
					]
				})
			]
		}),
		"autoRefresh":false,
		"refreshInterval":0,
		"enabled":true,
		"app":options.app
	});	
	
	this.addElement(grid);
		
		
	//****************************************************
	var contr = new DOCProduction_Controller(options.app);
	
	//read
	this.setReadPublicMethod(contr.getPublicMethod("get_object"));
	this.m_model = new DOCProductionList_Model({"data":options.modelDataStr});
	this.setDataBindings([
		new DataBinding({"control":this.getElement("id"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("number"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("date_time"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("product"),"model":this.m_model,"field":this.m_model.getField("product_id")}),
		new DataBinding({"control":this.getElement("quant"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("price"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("mat_sum"),"model":this.m_model}),		
		new DataBinding({"control":this.getElement("mat_cost"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("florist_comment"),"model":this.m_model})
	]);
	
	if (multy_store=="1"){
		this.addDataBinding(new DataBinding({"control":this.getElement("store"),"model":this.m_model,"field":this.m_model.getField("store_id")}));
	}
	
	//write
	this.setController(contr);
	this.getCommand(this.CMD_OK).setBindings([
			new CommandBinding({"control":this.getElement("id")}),
			new CommandBinding({"control":this.getElement("number")}),
			new CommandBinding({"control":this.getElement("date_time")}),
			new CommandBinding({"control":this.getElement("product"),"fieldId":"product_id"}),
			new CommandBinding({"control":this.getElement("quant")}),
			new CommandBinding({"control":this.getElement("price")}),
			new CommandBinding({"control":this.getElement("mat_sum")}),
			new CommandBinding({"control":this.getElement("mat_cost")}),
			new CommandBinding({"control":this.getElement("florist_comment")})
	]);
	
	if (multy_store=="1"){
		this.getCommand(this.CMD_OK).getBindings().push((new CommandBinding({"control":this.getElement("store"),"fieldId":"store_id"})));
	}
	
	//this.addDetailDataSet(grid);
	
}
extend(DOCProduction_View,ViewObjectAjx);


DOCProduction_View.prototype.setDefRefVals = function(){
	var constants = {"def_store":null};
	this.getApp().getConstantManager().get(constants);
	var store_ctrl = this.getElement("store");
	if (store_ctrl){
		store_ctrl.setValue(constants.def_store);
	}
}
DOCProduction_View.prototype.onSetProduct = function(model){
	this.getElement("price").setValue(model.getField("price").getValue());	
}
