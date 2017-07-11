/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function DOCMaterialProcurement_View(id,options){	

	options = options || {};
	
	var contr = new DOCMaterialProcurement_Controller(options.app);
	this.m_printPublicMethod = contr.getPublicMethod("get_print");

	options.printList = contr.getPrintList();	
	
	DOCMaterialProcurement_View.superclass.constructor.call(this,id,options);
	
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
	
	this.addElement(new SupplierEditRef(id+":supplier",{"app":app}));	

	//material grid
	
	var material_model = new DOCMaterialProcurementDOCTMaterialList_Model();
	var material_contr = new DOCMaterialProcurementDOCTMaterial_Controller(app);
	this.addElement(new GridAjxDOCT(id+":material-grid",{
		"keyIds":["view_id"],
		"model":material_model,
		"controller":material_contr,
		"editInline":true,
		"editWinClass":null,
		"editViewClass":DOCMaterialProcurementDOCTMaterialInline_View,
		"commands":new DOCCommands(id+":material-grid:cmd",{
			"detailFillWinClass":MaterialList_Form,
			"detailOnSelect":function(fields,q){
				var contr = new DOCMaterialProcurementDOCTMaterial_Controller(this.getApp());
				var pm = contr.getPublicMethod("insert");
				var price = fields.price.getValue();
				pm.setFieldValue("view_id", self.getElement("view_id").getValue());
				pm.setFieldValue("material_id", fields.id.getValue());
				pm.setFieldValue("price", price);
				pm.setFieldValue("quant", q);
				pm.setFieldValue("total", q*price);
				pm.run({"async":false});
				this.m_grid.onRefresh();			
			},
			"cmdEdit":true,
			"cmdCopy":false,
			"app":app,
			}),
		"head":new GridHead(id+":material-grid:head",{
			"elements":[
				new GridRow(id+":material-grid:head:row0",{
					"elements":[
						new GridCellHead(id+":material-grid:head:line_number",{
							"className":bs+"1",
							"columns":[
								new GridColumn("line_number",{"field":material_model.getField("line_number"),
								"ctrlId":"line_number"
								})
							]
						}),
					
						new GridCellHead(id+":material-grid:head:material",{
							"className":bs+"4",
							"columns":[
								new GridColumn("material",{
									"field":material_model.getField("material_descr"),
									"ctrlBindField":material_model.getField("material_id")
								})
							]
						}),
					
						new GridCellHead(id+":material-grid:head:quant",{
							"className":bs+"2",
							"colAttrs":{"align":"right"},
							"columns":[
								new GridColumnFloat("quant",{"field":material_model.getField("quant")
								})
							]
						}),
						new GridCellHead(id+":material-grid:head:price",{
							"className":bs+"2",
							"colAttrs":{"align":"right"},
							"columns":[
								new GridColumnFloat("price",{"field":material_model.getField("price")
								})
							]
						}),
						new GridCellHead(id+":material-grid:head:total",{
							"className":bs+"2",
							"colAttrs":{"align":"right"},
							"columns":[
								new GridColumnFloat("total",{"field":material_model.getField("total")
								})
							]
						})						
					]
				})
			]
		}),
		"foot":new GridFoot(id+":material-grid:foot",{
			"autoCalc":true,			
			"elements":[
				new GridRow(id+":material-grid:foot:row0",{
					"elements":[
						new GridCell(id+":material-grid:foot:total_lb",{
							"value":"Итого","colSpan":"4"
						}),
						new GridCellFoot(id+":material-grid:foot:total_val",{
							"attrs":{"align":"right"},
							"calcOper":"sum",
							"calcFieldId":"total",
							"gridColumn":new GridColumnFloat("total_val",{})
						})						
					]
				})		
			]
		}),
		"autoRefresh":false,
		"refreshInterval":0,
		"enabled":true,
		"app":app
	}));		
	
	//****************************************************	
	
	//read
	this.setReadPublicMethod(contr.getPublicMethod("get_object"));
	this.m_model = new DOCMaterialProcurementList_Model({"data":options.modelDataStr});
	
	this.setDataBindings([
		new DataBinding({"control":this.getElement("number"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("date_time"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("supplier"),"model":this.m_model,"field":this.m_model.getField("supplier_descr"),"keyIds":["supplier_id"]})
	]);
	
	//write
	this.setController(contr);
	this.getCommand(this.CMD_OK).setBindings([
		new CommandBinding({"control":this.getElement("number")}),
		new CommandBinding({"control":this.getElement("date_time")}),
		new CommandBinding({"control":this.getElement("supplier"),"fieldId":"supplier_id"})
	]);
	
	this.addDefDataBindings();
	
	if (multy_store=="1"){
		this.getCommand(this.CMD_OK).getBindings().push((new CommandBinding({"control":this.getElement("store"),"fieldId":"store_id","keyIds":["store_id"]})));
		this.addDataBinding(new DataBinding({"control":this.getElement("store"),"model":this.m_model,"field":this.m_model.getField("store_id")}));
	}
	
	this.addDetailDataSet(this.getElement("material-grid"));
	
}
extend(DOCMaterialProcurement_View,ViewDOC);


DOCMaterialProcurement_View.prototype.setDefRefVals = function(){
	var constants = {"def_store":null};
	this.getApp().getConstantManager().get(constants);
	var store_ctrl = this.getElement("store");
	if (store_ctrl){
		store_ctrl.setValue(constants.def_store);
	}
}

DOCMaterialProcurement_View.prototype.onGetData = function(resp,cmd){
	DOCMaterialProcurement_View.superclass.onGetData.call(this,resp,cmd);
	
	this.m_printPublicMethod.setFieldValue("doc_id",this.getElement("id").getValue());	
}

