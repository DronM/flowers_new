/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function DOCMaterialDisposal_View(id,options){	

	options = options || {};
	
	var contr = new DOCMaterialDisposal_Controller(options.app);
	this.m_printPublicMethod = contr.getPublicMethod("get_print");
	
	options.cmdPrint = true;
	options.printList = contr.getPrintList();
	
	DOCMaterialDisposal_View.superclass.constructor.call(this,id,options);
	
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
	
	this.addElement(new EditText(id+":explanation",{"labelCaption":this.CTRL_EXPL_CAP,"app":app}));	

	//material grid
	
	var material_model = new DOCMaterialDisposalDOCTMaterialList_Model();
	var material_contr = new DOCMaterialDisposalDOCTMaterial_Controller(app);
	this.addElement(new GridAjxDOCT(id+":material-grid",{
		"keyIds":["view_id"],
		"model":material_model,
		"controller":material_contr,
		"editInline":true,
		"editWinClass":null,
		"editViewClass":null,
		"commands":new DOCCommands(id+":material-grid:cmd",{
			"detailFillWinClass":MaterialBalanceList_Form,
			"detailOnSelect":function(fields,q){
				var contr = new DOCMaterialDisposalDOCTMaterial_Controller(this.getApp());
				var pm = contr.getPublicMethod("insert");
				var price = fields.price.getValue();
				pm.setFieldValue("view_id", self.getElement("view_id").getValue());
				pm.setFieldValue("material_id", fields.id.getValue());
				pm.setFieldValue("quant", q);
				pm.run({"async":false});
				this.m_grid.onRefresh();			
			},
			"cmdEdit":false,
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
									"ctrlOptions":{"enabled":false}
								})
							]
						}),
					
						new GridCellHead(id+":material-grid:head:material",{
							"className":bs+"8",
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
							"className":bs+"2",
							"colAttrs":{"align":"right"},
							"columns":[
								new GridColumnFloat("quant",{"field":material_model.getField("quant"),
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
		"app":app
	}));		
	
	//****************************************************	
	
	//read
	this.setReadPublicMethod(contr.getPublicMethod("get_object"));
	this.m_model = new DOCMaterialDisposalList_Model({"data":options.modelDataStr});
	
	this.setDataBindings([
		new DataBinding({"control":this.getElement("number"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("date_time"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("explanation"),"model":this.m_model})
	]);
	
	//write
	this.setController(contr);
	this.getCommand(this.CMD_OK).setBindings([
		new CommandBinding({"control":this.getElement("number")}),
		new CommandBinding({"control":this.getElement("date_time")}),
		new CommandBinding({"control":this.getElement("explanation")})
	]);
	
	this.addDefDataBindings();
	
	if (multy_store=="1"){
		this.getCommand(this.CMD_OK).getBindings().push((new CommandBinding({"control":this.getElement("store"),"fieldId":"store_descr","keyIds":["store_id"]})));
		this.addDataBinding(new DataBinding({"control":this.getElement("store"),"model":this.m_model,"field":this.m_model.getField("store_id")}));
	}
	
	this.addDetailDataSet(this.getElement("material-grid"));
	
}
extend(DOCMaterialDisposal_View,ViewDOC);


DOCMaterialDisposal_View.prototype.setDefRefVals = function(){
	var constants = {"def_store":null};
	this.getApp().getConstantManager().get(constants);
	var store_ctrl = this.getElement("store");
	if (store_ctrl){
		store_ctrl.setValue(constants.def_store);
	}
}

DOCMaterialDisposal_View.prototype.onGetData = function(resp,cmd){
	DOCMaterialDisposal_View.superclass.onGetData.call(this,resp,cmd);
	
	this.m_printPublicMethod.setFieldValue("doc_id",this.getElement("id").getValue());	
}

