/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function DOCSale_View(id,options){	

	options = options || {};
	
	var contr = new DOCSale_Controller(options.app);
	this.m_printPublicMethod = contr.getPublicMethod("get_print");
	
	options.cmdPrint = true;
	options.printList = contr.getPrintList();	
	
	DOCSale_View.superclass.constructor.call(this,id,options);
	
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
	
	//this.addElement(new PaymentTypeForSaleSelect(id+":payment_type_for_sale",{"app":app}));
	
	this.addElement(new ClientEditRef(id+":client",{
		"onSelect":function(fields){
			debugger
			self.getElement("discount").setValue(fields.discount_id.getValue());
			self.setDiscountPercent(fields.disc_card_percent.getValue());
		},	
		"app":app		
	}));		

	this.addElement(new DiscountSelect(id+":discount",{
		"onSelect":function(fields){
			self.setDiscountPercent(fields.percent.getValue());
		},
		"app":app
	}));	

	//product grid	
	var product_model = new DOCSaleDOCTProductList_Model();
	var product_contr = new DOCSaleDOCTProduct_Controller(app);
	this.addElement(new GridAjxDOCT(id+":product-grid",{
		"keyIds":["view_id"],
		"model":product_model,
		"controller":product_contr,
		"editInline":true,
		"editWinClass":null,
		"editViewClass":DOCSaleDOCTProductInline_View,
		"commands":new DOCCommands(id+":product-grid:cmd",{
			"detailFillWinClass":ProductBalanceList_Form,
			"detailOnSelect":function(fields,q){
				var gr_opts = self.getElement("product-grid").getEditViewOptions();
				var disc_percent = (gr_opts)? gr_opts.discountPercent:0;
				
				var contr = new DOCSaleDOCTProduct_Controller(this.getApp());
				var pm = contr.getPublicMethod("insert");
				var price = fields.price.getValue();
				pm.setFieldValue("view_id", self.getElement("view_id").getValue());
				pm.setFieldValue("doc_production_id", fields.doc_production_id.getValue());
				
				pm.setFieldValue("price_no_disc", price);
				pm.setFieldValue("quant", q);
				
				pm.setFieldValue("disc_percent", disc_percent);
				var tot_no_disc = q*price;
				pm.setFieldValue("total", (Math.round(parseFloat(tot_no_disc - tot_no_disc*disc_percent/100)*100))/100);
				
				pm.run({"async":false});
				this.m_grid.onRefresh();			
			},
			"viewId":this.getElement("view_id").getValue(),
			"cmdEdit":false,
			"cmdCopy":false,
			"app":app
			}),
		"head":new GridHead(id+":product-grid:head",{
			"elements":[
				new GridRow(id+":product-grid:head:row0",{
					"elements":[
						new GridCellHead(id+":product-grid:head:line_number",{
							"className":bs+"1",
							"columns":[
								new GridColumn("line_number",{"field":product_model.getField("line_number"),
									"ctrlClass":Edit,
									"ctrlOptions":{"tagName":"div"}
								})
							]
						}),
					
						new GridCellHead(id+":product-grid:head:doc_production",{
							"className":bs+"3",
							"columns":[
								new GridColumn("doc_production",{
									"field":product_model.getField("doc_production_id"),
									"formatFunction":function(model){
										return CommonHelper.format("№ % (%), %",
											[
											model.getFieldValue("doc_production_number"),
											DateHelper.format(model.getFieldValue("doc_production_date_time"),this.getApp().getDateFormat()),
											model.getFieldValue("product_descr")
											]
										);
									},
									"ctrlBindField":product_model.getField("doc_production_id")
								})
							]
						}),
					
						new GridCellHead(id+":product-grid:head:quant",{
							"className":bs+"1",
							"colAttrs":{"align":"right"},
							"columns":[
								new GridColumnFloat("quant",{"field":product_model.getField("quant"),
								"ctrlId":"quant",
								})
							]
						}),
						new GridCellHead(id+":product-grid:head:price_no_disc",{
							"className":bs+"2",
							"colAttrs":{"align":"right"},
							"columns":[
								new GridColumnFloat("price_no_disc",{"field":product_model.getField("price_no_disc"),
								"ctrlId":"price_no_disc",
								})
							]
						}),
						new GridCellHead(id+":product-grid:head:disc_percent",{
							"className":bs+"1",
							"colAttrs":{"align":"right"},
							"columns":[
								new GridColumnFloat("disc_percent",{"field":product_model.getField("disc_percent"),
								"ctrlId":"disc_percent",
								})
							]
						}),						
						new GridCellHead(id+":product-grid:head:total",{
							"className":bs+"2",
							"colAttrs":{"align":"right"},
							"columns":[
								new GridColumnFloat("total",{"field":product_model.getField("total")
								})
							]
						})												
					]
				})
			]
		}),
		"foot":new GridFoot(id+":product-grid:foot",{
			"autoCalc":true,			
			"elements":[
				new GridRow(id+":product-grid:foot:row0",{
					"elements":[
						new GridCell(id+":product-grid:foot:row0:total_lb",{
							"value":"Итого","colSpan":"5"
						}),
						new GridCellFoot(id+":product-grid:foot:row0:total_val",{
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

	//material grid	
	var material_model = new DOCSaleDOCTMaterialList_Model();
	var material_contr = new DOCSaleDOCTMaterial_Controller(app);
	this.addElement(new GridAjxDOCT(id+":material-grid",{
		"keyIds":["view_id"],
		"model":material_model,
		"controller":material_contr,
		"editInline":true,
		"editWinClass":null,
		"editViewClass":DOCSaleDOCTMaterialInline_View,
		"editViewOptions":null,
		"commands":new DOCCommands(id+":material-grid:cmd",{
			"detailFillWinClass":MaterialBalanceList_Form,
			"detailOnSelect":function(fields,q){
				var gr_opts = self.getElement("material-grid").getEditViewOptions();
				var disc_percent = (gr_opts)? gr_opts.discountPercent:0;
			
				var contr = new DOCSaleDOCTMaterial_Controller(this.getApp());
				var pm = contr.getPublicMethod("insert");
				var price = fields.price.getValue();
				pm.setFieldValue("view_id", self.getElement("view_id").getValue());
				pm.setFieldValue("material_id", fields.id.getValue());
				pm.setFieldValue("price_no_disc", price);
				pm.setFieldValue("quant", q);
				
				pm.setFieldValue("disc_percent", disc_percent);
				var tot_no_disc = q*price;
				pm.setFieldValue("total", (Math.round(parseFloat(tot_no_disc - tot_no_disc*disc_percent/100)*100))/100);
				
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
							"className":bs+"1",
							"columns":[
								new GridColumn("line_number",{"field":material_model.getField("line_number"),
									"ctrlClass":Edit,
									"ctrlOptions":{"tagName":"div"}
								})
							]
						}),
					
						new GridCellHead(id+":material-grid:head:material",{
							"className":bs+"3",
							"columns":[
								new GridColumn("material",{"field":material_model.getField("material_descr"),
									"ctrlBindField":material_model.getField("material_id")
								})
							]
						}),
					
						new GridCellHead(id+":material-grid:head:quant",{
							"className":bs+"1",
							"colAttrs":{"align":"right"},
							"columns":[
								new GridColumnFloat("quant",{"field":material_model.getField("quant")
								})
							]
						}),
						new GridCellHead(id+":material-grid:head:price_no_disc",{
							"className":bs+"2",
							"colAttrs":{"align":"right"},
							"columns":[
								new GridColumnFloat("price_no_disc",{"field":material_model.getField("price_no_disc")
								})
							]
						}),
						new GridCellHead(id+":material-grid:head:disc_percent",{
							"className":bs+"1",
							"colAttrs":{"align":"right"},
							"columns":[
								new GridColumnFloat("disc_percent",{"field":material_model.getField("disc_percent")
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
						new GridCell(id+":material-grid:foot:row0:total_lb",{
							"value":"Итого","colSpan":"5"
						}),
						new GridCellFoot(id+":material-grid:foot:row0:total_val",{
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
	
	this.addElement(new Control(id+":total","h1",{"value":"","app":options.app}));
		
	//****************************************************	
	
	//read
	this.setReadPublicMethod(contr.getPublicMethod("get_object"));
	this.m_model = new DOCSaleDialog_Model({"data":options.modelDataStr});
	
	this.setDataBindings([
		new DataBinding({"control":this.getElement("number"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("date_time"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("client"),"model":this.m_model,"field":this.m_model.getField("client_descr"),"keyIds":["client_id"]}),
		new DataBinding({"control":this.getElement("payment_type_for_sale"),"model":this.m_model,"field":this.m_model.getField("payment_type_for_sale_id"),"keyIds":["payment_type_for_sale_id"]}),
		new DataBinding({"control":this.getElement("discount"),"model":this.m_model,"field":this.m_model.getField("discount_id"),"keyIds":["discount_id"]})
	]);
	
	//write
	this.setController(contr);
	this.getCommand(this.CMD_OK).setBindings([
		new CommandBinding({"control":this.getElement("number")}),
		new CommandBinding({"control":this.getElement("date_time")}),
		new CommandBinding({"control":this.getElement("client"),"fieldId":"client_id"}),
		new CommandBinding({"control":this.getElement("discount"),"fieldId":"discount_id"})
	]);
	
	this.addDefDataBindings();
	
	if (multy_store=="1"){
		this.getCommand(this.CMD_OK).getBindings().push((new CommandBinding({"control":this.getElement("store"),"fieldId":"store_id","keyIds":["store_id"]})));
		this.addDataBinding(new DataBinding({"control":this.getElement("store"),"model":this.m_model,"field":this.m_model.getField("store_id")}));
	}
	
	var gr_product = this.getElement("product-grid");
	var gr_material = this.getElement("material-grid");
	this.addDetailDataSet(gr_product);
	this.addDetailDataSet(gr_material);
	
	
	this.m_prodOnGetData = gr_product.onGetData;
	gr_product.onGetData = function(resp){
		self.m_prodOnGetData.call(self.getElement("product-grid"),resp);
		self.refreshTotal();
	}
	this.m_matOnGetData = gr_material.onGetData;
	gr_material.onGetData = function(resp){
		self.m_matOnGetData.call(self.getElement("material-grid"),resp);
		self.refreshTotal();
	}
	
}
extend(DOCSale_View,ViewDOC);


DOCSale_View.prototype.setDefRefVals = function(){	
	var constants = {"def_store":null,"def_payment_type_for_sale":null,"def_discount":null};
	this.getApp().getConstantManager().get(constants);
	var ctrl = this.getElement("store");
	if (ctrl){
		ctrl.setValue(constants.def_store.getValue());
	}
	
	this.getElement("discount").setValue(constants.def_discount.getValue());
	//this.getElement("payment_type_for_sale").setValue(constants.def_payment_type_for_sale.getValue());	
}

DOCSale_View.prototype.setDiscountPercent = function(v){	
	this.getElement("product-grid").setEditViewOptions({"discountPercent":v});
	this.getElement("material-grid").setEditViewOptions({"discountPercent":v});
}

DOCSale_View.prototype.refreshTotal = function(){	
	//var f = this.getElement("product-grid").getFoot();
	
	
	var tot = 
		this.getElement("product-grid").getFoot().getElement("row0").getElement("total_val").getValue()+
		this.getElement("material-grid").getFoot().getElement("row0").getElement("total_val").getValue()
	;
	
	var c = this.getElement("total");
	var vl = this.getApp().numberFormat(tot,2);
	c.setValue("ИТОГО: "+vl+" руб.");
	
}

DOCSale_View.prototype.onGetData = function(resp,cmd){
	DOCSale_View.superclass.onGetData.call(this,resp,cmd);
	
	this.m_printPublicMethod.setFieldValue("doc_id",this.getElement("id").getValue());	
}

