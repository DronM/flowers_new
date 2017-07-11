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
	
	var contr = new DOCProduction_Controller(options.app);
	options.printList = contr.getPrintList();
	
	DOCProduction_View.superclass.constructor.call(this,id,options);
	
	//Номер && Дата
	this.addElement(new DOCNumberEdit(id+":number",{"app":options.app}));	
	this.addElement(new DOCDateEdit(id+":date_time",{"app":options.app}));	
	
	var app = options.app;
	var bs = app.getBsCol();
		
	var multy_store = app.getServVars().multy_store;
	
	var self = this;

	if (multy_store=="1"){
		this.addElement(new StoreSelect(id+":store",{
			"app":app
		}));	
	}
	
	this.addElement(new ProductEditRef(id+":product",{
		"onSelect":function(fields){
			self.onSetProduct(fields);
		},
		"app":app
	}));	

	this.addElement(new EditFloat(id+":quant",{
		"labelCaption":"Количество:",
		"value":1,
		"presicion":"3",
		"maxlength":"19",
		"app":app
	}));	

	this.addElement(new EditMoney(id+":price",{
		"labelCaption":"Цена:",
		"app":app
	}));	

	this.addElement(new EditMoney(id+":material_retail_cost",{
		"labelCaption":"Стоимость материалов:",
		"enabled":false,
		"cmdSelect":false,
		"app":app
	}));	

	this.addElement(new EditMoney(id+":material_cost",{
		"labelCaption":"Себестоимость материалов:",
		"enabled":false,
		"cmdSelect":false,
		"app":app
	}));	

	this.addElement(new EditText(id+":florist_comment",{
		"labelCaption":"Комментарий:",
		"editContClassName":"input-group "+bs+"10",
		"labelClassName":"control-label "+bs+"2",
		"rows":"2",
		"app":app
	}));	

	//material grid
	
	var material_model = new DOCProductionDOCTMaterialList_Model();
	var material_contr = new DOCProductionDOCTMaterial_Controller(app);
	this.addElement(new GridAjxDOCT(id+":material-grid",{
		"keyIds":["view_id"],
		"model":material_model,
		"controller":material_contr,
		"editInline":true,
		"editWinClass":null,
		"commands":new DOCCommands(id+":material-grid:cmd",{
			"detailFillWinClass":MaterialBalanceList_Form,
			"detailOnSelect":function(fields,q){
				var contr = new DOCProductionDOCTMaterial_Controller(this.getApp());
				var pm = contr.getPublicMethod("insert");
				pm.setFieldValue("view_id", self.getElement("view_id").getValue());
				pm.setFieldValue("material_id", fields.id.getValue());
				pm.setFieldValue("quant", q);
				pm.run({"async":false});
				this.m_grid.onRefresh();			
			},
			"viewId":this.getElement("view_id").getValue(),
			"cmdEdit":false,
			"cmdCopy":false,
			"app":app
			}),
		"head":new GridHead(id+":material-grid:head",{
			"elements":[
				new GridRow(id+":material-grid:head:row0",{
					"elements":[
						new GridCellHead(id+":material-grid:head:line_number",{
							"columns":[
								new GridColumn("line_number",{"field":material_model.getField("line_number"),
									"ctrlClass":Edit,
									"ctrlOptions":{"tagName":"div"}
								})
							]
						}),
					
						new GridCellHead(id+":material-grid:head:material",{
							"columns":[
								new GridColumn("material",{"field":material_model.getField("material_descr"),
									"ctrlClass":MaterialEditRef,
									"ctrlOptions":{
										"labelCaption":"",										
										"selectWinClass":MaterialBalanceList_Form,
										"keyIds":["material_id"]
									},
									"ctrlBindField":material_model.getField("material_id")
								})
							]
						}),
					
						new GridCellHead(id+":material-grid:head:quant",{
							"colAttrs":{"align":"right"},
							"columns":[
								new GridColumnFloat("quant",{"field":material_model.getField("quant"),
									"ctrlOptions":{"value":"1"}
								})
							]
						})
						//sys col
						,new GridCellHead(id+":material-grid:head:sys-cmd",{
							"value":"...",
							"columns":[new GridColumn("sys-cmd",{"cellClass":DOCProductionDetMatSysCell
							})]							
						})						
					]
				})
			]
		}),
		"autoRefresh":false,
		"refreshInterval":0,
		"enabled":true,
		"onRefresh":function(){
			self.calcMatCosts();
		},
		"app":app
	}));		
	
	//****************************************************	
	
	//read
	this.setReadPublicMethod(contr.getPublicMethod("get_object"));
	this.m_model = new DOCProductionList_Model({"data":options.modelDataStr});
	
	this.setDataBindings([
		new DataBinding({"control":this.getElement("number"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("date_time"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("product"),"model":this.m_model,"field":this.m_model.getField("product_descr"),"keyIds":["product_id"]}),
		new DataBinding({"control":this.getElement("quant"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("price"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("florist_comment"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("material_cost"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("material_retail_cost"),"model":this.m_model})
	]);
	
	//write
	this.setController(contr);
	this.getCommand(this.CMD_OK).setBindings([
		new CommandBinding({"control":this.getElement("number")}),
		new CommandBinding({"control":this.getElement("date_time")}),
		new CommandBinding({"control":this.getElement("product"),"fieldId":"product_id"}),
		new CommandBinding({"control":this.getElement("quant")}),
		new CommandBinding({"control":this.getElement("price")}),
		new CommandBinding({"control":this.getElement("florist_comment")})
	]);
	
	this.addDefDataBindings();
	
	if (multy_store=="1"){
		this.getCommand(this.CMD_OK).getBindings().push((new CommandBinding({"control":this.getElement("store"),"fieldId":"store_id","keyIds":["store_id"]})));
		this.addDataBinding(new DataBinding({"control":this.getElement("store"),"model":this.m_model,"field":this.m_model.getField("store_id")}));
	}
	
	this.addDetailDataSet(this.getElement("material-grid"));
	
}
extend(DOCProduction_View,ViewDOC);


DOCProduction_View.prototype.setDefRefVals = function(){
	var constants = {"def_store":null};
	this.getApp().getConstantManager().get(constants);
	var store_ctrl = this.getElement("store");
	if (store_ctrl){
		store_ctrl.setValue(constants.def_store);
	}
}
DOCProduction_View.prototype.onSetProduct = function(fields){
	this.getElement("price").setValue(fields.price.getValue());	
}

DOCProduction_View.prototype.calcMatCosts = function(){
	if (!this.getElement("material-grid").getModified())return;
	
	var pm = this.getController().getPublicMethod("calc_mat_costs");
	pm.setFieldValue("view_id",this.getElement("view_id").getValue());
	pm.setFieldValue("doc_id",this.getElement("id").getValue());
	
	var self = this;
	pm.run({
		"async":true,
		"ok":function(resp){
			var m = new ModelXML("MatCosts_Model",{
				"fields":{
					"material_retail_cost":new FieldFloat("material_retail_cost"),
					"material_cost":new FieldFloat("material_cost")
				},
				"data":resp.getModelData("MatCosts_Model")
			});
			if (m.getRowCount()){
				m.getRow(0);
				var v = m.getFieldValue("material_cost");
				self.getElement("material_retail_cost").setValue(m.getFieldValue("material_retail_cost"));
				self.getElement("material_cost").setValue(v);
			}
		}
	})
}

