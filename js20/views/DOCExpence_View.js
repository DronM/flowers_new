/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function DOCExpence_View(id,options){	

	options = options || {};
	
	var contr = new DOCExpence_Controller(options.app);
	this.m_printPublicMethod = contr.getPublicMethod("get_print");
	
	/*
	options.cmdPrint = true;
	options.printList = [
		{"caption":"Печатная форма","publicMethod":this.m_printPublicMethod,"viewId":"DOCExpence"}
	];
	*/
	
	DOCExpence_View.superclass.constructor.call(this,id,options);
	
	//Номер && Дата
	this.addElement(new DOCNumberEdit(id+":number",{"app":options.app}));	
	this.addElement(new DOCDateEdit(id+":date_time",{"app":options.app}));	
	
	var app = options.app;
	var bs = window.getBsCol();
		
	var multy_store = app.getServVars().multy_store;
	
	var self = this;

	if (multy_store=="1"){
		this.addElement(new StoreSelect(id+":store",{
			"app":app
		}));	
	}
	
	//expence grid
	
	var expence_model = new DOCExpenceDOCTExpenceTypeList_Model();
	var expence_contr = new DOCExpenceDOCTExpenceType_Controller(app);
	this.addElement(new GridAjxDOCT(id+":expence-grid",{
		"keyIds":["view_id"],
		"model":expence_model,
		"controller":expence_contr,
		"editInline":true,
		"editWinClass":null,
		"editViewClass":null,
		"commands":new GridCommandsAjx(id+":expence-grid:cmd",{
			"cmdEdit":false,
			"cmdCopy":false,
			"app":app,
			}),
		"head":new GridHead(id+":expence-grid:head",{
			"elements":[
				new GridRow(id+":expence-grid:head:row0",{
					"elements":[
						new GridCellHead(id+":expence-grid:head:line_number",{
							"className":bs+"1",
							"columns":[
								new GridColumn("line_number",{"field":expence_model.getField("line_number"),
									"ctrlClass":Edit,
									"ctrlOptions":{"enabled":false}
								})
							]
						}),
					
						new GridCellHead(id+":expence-grid:head:expence",{
							"className":bs+"2",
							"columns":[
								new GridColumn("expence",{"field":expence_model.getField("expence_type_descr"),
									"ctrlClass":ExpenceTypeEditRef,
									"ctrlOptions":{
										"labelCaption":"",
										"selectWinClass":ExpenceTypeList_Form,
										"keyIds":["expence_type_id"]
									},
									"ctrlBindField":expence_model.getField("expence_type_id")
								})
							]
						}),

						new GridCellHead(id+":expence-grid:head:expence_date",{
							"className":bs+"2",
							"columns":[
								new GridColumnDate("expence_date",{
									"field":expence_model.getField("expence_date"),
									"ctrlOptions":{
										"value":DateHelper.time()
									}									
								})
							]
						}),

						new GridCellHead(id+":expence-grid:head:expence_comment",{
							"className":bs+"4",
							"columns":[
								new GridColumn("expence_comment",{"field":expence_model.getField("expence_comment")})
							]
						}),
					
						new GridCellHead(id+":expence-grid:head:total",{
							"className":bs+"2",
							"colAttrs":{"align":"right"},
							"columns":[
								new GridColumnFloat("total",{"field":expence_model.getField("total")})
							]
						})
						
					]
				})
			]
		}),
		"foot":new GridFoot(id+":expence-grid:foot",{
			"autoCalc":true,			
			"elements":[
				new GridRow(id+":expence-grid:foot:row0",{
					"elements":[
						new GridCell(id+":expence-grid:foot:total_lb",{
							"value":"Итого","colSpan":"4"
						}),
						new GridCellFoot(id+":expence-grid:foot:total_val",{
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
	this.m_model = new DOCExpenceList_Model({"data":options.modelDataStr});
	
	this.setDataBindings([
		new DataBinding({"control":this.getElement("number"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("date_time"),"model":this.m_model})
	]);
	
	//write
	this.setController(contr);
	this.getCommand(this.CMD_OK).setBindings([
		new CommandBinding({"control":this.getElement("number")}),
		new CommandBinding({"control":this.getElement("date_time")})
	]);

	this.addDefDataBindings();
		
	if (multy_store=="1"){
		this.getCommand(this.CMD_OK).getBindings().push((new CommandBinding({"control":this.getElement("store"),"fieldId":"store_descr","keyIds":["store_id"]})));
		this.addDataBinding(new DataBinding({"control":this.getElement("store"),"model":this.m_model,"field":this.m_model.getField("store_id")}));
	}
	
	this.addDetailDataSet(this.getElement("expence-grid"));
	
}
extend(DOCExpence_View,ViewDOC);


DOCExpence_View.prototype.setDefRefVals = function(){
	var constants = {"def_store":null};
	this.getApp().getConstantManager().get(constants);
	var store_ctrl = this.getElement("store");
	if (store_ctrl){
		store_ctrl.setValue(constants.def_store);
	}
}

DOCExpence_View.prototype.onGetData = function(resp,cmd){
	DOCExpence_View.superclass.onGetData.call(this,resp,cmd);
	
	this.m_printPublicMethod.setFieldValue("doc_id",this.getElement("id").getValue());	
}

