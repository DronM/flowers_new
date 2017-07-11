/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function DOCClientOrder_View(id,options){	

	options = options || {};
	
	options.processable = false;
	
	var contr = new DOCClientOrder_Controller(options.app);
	
	options.cmdPrint = true;
	options.printList = contr.getPrintList();	
	
	DOCClientOrder_View.superclass.constructor.call(this,id,options);
	
	//Номер && Дата
	this.addElement(new DOCDateEdit(id+":date_time",{"app":options.app}));
	this.addElement(new DOCNumberEdit(id+":number",{"app":options.app}));		
	
	var app = options.app;
	var bs = app.getBsCol();
		
	var multy_store = app.getServVars().multy_store;
	
	var self = this;

	if (multy_store=="1"){
		this.addElement(new StoreSelect(id+":store",{
			"app":app
		}));	
	}
	
	this.addElement(new EditString(id+":number_from_site",{
		"labelCaption":"Номер с сайта:",
		"app":options.app
	}));	

	this.addElement(new Enum_delivery_types(id+":delivery_type",{
		"labelCaption":"Вид доставки:",
		"required":true,
		"app":options.app
	}));	

	//Покупатель
	this.addElement(new EditString(id+":client_name",{
		"labelCaption":"Покупатель:",
		"attrs":{"maxlength":200},
		"app":options.app
	}));	

	this.addElement(new EditPhone(id+":client_tel",{
		"labelCaption":"Телефон:",
		"app":options.app
	}));	

	this.addElement(new ClientEditRef(id+":client",{
		"app":options.app
	}));	

	this.addElement(new Enum_recipient_types(id+":recipient_type",{
		"labelCaption":"Вид получателя:",
		"required":true,
		"app":options.app
	}));	

	//Получатель
	this.addElement(new EditString(id+":recipient_name",{
		"labelCaption":"Получатель:",
		"attrs":{"maxlength":200},
		"app":options.app
	}));	

	this.addElement(new EditPhone(id+":recipient_tel",{
		"labelCaption":"Телефон:",
		"app":options.app
	}));	

	//Адрес
	this.addElement(new EditString(id+":address",{
		"labelCaption":"Адрес:",
		"attrs":{"maxlength":500},
		"required":true,
		"app":options.app
	}));	

	//Дата
	this.addElement(new EditDate(id+":delivery_date",{
		"labelCaption":"Дата доставки:",
		"required":true,
		"app":options.app
	}));	

	//Время
	this.addElement(new DeliveryHourSelect(id+":delivery_hour",{
		"labelCaption":"Время доставки:",
		"keyIds":["delivery_hour_id"],
		"required":true,
		"app":options.app
	}));	
	
	//Коммент доставки
	this.addElement(new EditString(id+":delivery_comment",{
		"labelCaption":"Коммент.доставки:",
		"attrs":{"maxlength":100},
		"app":options.app
	}));	

	//Открытка
	this.addElement(new EditCheckBox(id+":card",{
		"labelCaption":"Открытка:",
		"app":options.app
	}));	
	//Текст
	this.addElement(new EditText(id+":card_text",{
		"labelCaption":"Текст открытки:",
		"rows":2,
		"app":options.app
	}));	
	
	//Анонимный подарок
	this.addElement(new EditCheckBox(id+":anonym_gift",{
		"labelCaption":"Анонимный подарок:",
		"app":options.app
	}));	
	
	this.addElement(new Enum_delivery_note_types(id+":delivery_note_type",{
		"labelCaption":"Уведомление о доставке:",
		"app":options.app
	}));	
	
	//Текст
	this.addElement(new EditText(id+":extra_comment",{
		"labelCaption":"Комментарий:",
		"rows":2,
		"app":options.app
	}));	
	
	this.addElement(new Enum_payment_types(id+":payment_type",{
		"labelCaption":"Вид оплаты:",
		"app":options.app
	}));	

	this.addElement(new Enum_client_order_states(id+":client_order_state",{
		"labelCaption":"Статус:",
		"app":options.app
	}));	

	//product grid	
	var product_model = new DOCClientOrderDOCTProductList_Model();
	var product_contr = new DOCClientOrderDOCTProduct_Controller(app);
	this.addElement(new GridAjxDOCT(id+":product-grid",{
		"keyIds":["view_id"],
		"model":product_model,
		"controller":product_contr,
		"editInline":true,
		"editWinClass":null,
		"editViewClass":DOCClientOrderDOCTProductInline_View,
		"commands":new DOCCommands(id+":product-grid:cmd",{
			"detailFillWinClass":ProductList_Form,
			"detailOnSelect":function(fields,q){
				var contr = new DOCClientOrderDOCTProduct_Controller(this.getApp());
				var pm = contr.getPublicMethod("insert");
				var price = fields.price.getValue();
				pm.setFieldValue("view_id", self.getElement("view_id").getValue());
				pm.setFieldValue("product_id", fields.id.getValue());
				pm.setFieldValue("price_no_disc", price);
				pm.setFieldValue("disc_percent", 0);
				pm.setFieldValue("quant", q);
				pm.setFieldValue("total", q*price);
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
					
						new GridCellHead(id+":product-grid:head:product",{
							"className":bs+"3",
							"columns":[
								new GridColumn("product",{
									"field":product_model.getField("product_descr"),
									"ctrlBindField":product_model.getField("product_id")
								})
							]
						}),
					
						new GridCellHead(id+":product-grid:head:quant",{
							"className":bs+"1",
							"colAttrs":{"align":"right"},
							"columns":[
								new GridColumnFloat("quant",{"model":product_model})
							]
						}),
						new GridCellHead(id+":product-grid:head:price_no_disc",{
							"className":bs+"2",
							"colAttrs":{"align":"right"},
							"columns":[
								new GridColumnFloat("price_no_disc",{"model":product_model})
							]
						}),
						new GridCellHead(id+":product-grid:head:disc_percent",{
							"className":bs+"1",
							"colAttrs":{"align":"right"},
							"columns":[
								new GridColumnFloat("disc_percent",{"model":product_model})
							]
						}),						
						new GridCellHead(id+":product-grid:head:total",{
							"className":bs+"2",
							"colAttrs":{"align":"right"},
							"columns":[
								new GridColumnFloat("total",{"model":product_model})
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
		"enabled":true,
		"app":app
	}));		
	//****************************************************

	//material grid	
	var material_model = new DOCClientOrderDOCTMaterialList_Model();
	var material_contr = new DOCClientOrderDOCTMaterial_Controller(app);
	this.addElement(new GridAjxDOCT(id+":material-grid",{
		"keyIds":["view_id"],
		"model":material_model,
		"controller":material_contr,
		"editInline":true,
		"editWinClass":null,
		"editViewClass":DOCClientOrderDOCTMaterialInline_View,
		"editViewOptions":null,
		"commands":new DOCCommands(id+":material-grid:cmd",{
			"detailFillWinClass":MaterialBalanceList_Form,
			"detailOnSelect":function(fields,q){						
				var gr_opts = self.getElement("material-grid").getEditViewOptions();
				var disc_percent = (gr_opts)? gr_opts.discountPercent:0;
			
				var contr = new DOCClientOrderDOCTMaterial_Controller(this.getApp());
				var pm = contr.getPublicMethod("insert");
				var price = fields.price.getValue();
				pm.setFieldValue("view_id", self.getElement("view_id").getValue());
				pm.setFieldValue("material_id", fields.id.getValue());
				pm.setFieldValue("price_no_disc", price);
				pm.setFieldValue("quant", q);
				
				pm.setFieldValue("disc_percent", disc_percent);
				var tot_no_disc = q*price;
				pm.setFieldValue("total", (Math.round(parseFloat(tot_no_disc - tot_no_disc*disc_percent/100)*100))/100);
				
				pm.run({"async":true});
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
									"ctrlId":"material",
									"ctrlBindField":material_model.getField("material_id")
								})
							]
						}),
					
						new GridCellHead(id+":material-grid:head:quant",{
							"className":bs+"1",
							"colAttrs":{"align":"right"},
							"columns":[
								new GridColumnFloat("quant",{"field":material_model.getField("quant")})
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
		"enabled":true,
		"app":app
	}));		
	
	this.addElement(new Control(id+":total","h1",{"value":"","app":options.app}));
		
	//****************************************************	
	
	//read
	this.setReadPublicMethod(contr.getPublicMethod("get_object"));
	this.m_model = new DOCClientOrderList_Model({"data":options.modelDataStr});
	
	this.setDataBindings([
		new DataBinding({"control":this.getElement("number_from_site"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("date_time"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("client_name"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("client_tel"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("recipient_name"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("recipient_tel"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("address"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("delivery_date"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("delivery_comment"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("card"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("card_text"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("anonym_gift"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("extra_comment"),"model":this.m_model}),
		new DataBinding({"control":this.getElement("delivery_type"),"model":this.m_model,"field":this.m_model.getField("delivery_type")}),
		new DataBinding({"control":this.getElement("recipient_type"),"model":this.m_model,"field":this.m_model.getField("recipient_type")}),
		new DataBinding({"control":this.getElement("delivery_note_type"),"model":this.m_model,"field":this.m_model.getField("delivery_note_type")}),
		new DataBinding({"control":this.getElement("payment_type"),"model":this.m_model,"field":this.m_model.getField("payment_type")}),
		new DataBinding({"control":this.getElement("delivery_hour"),"model":this.m_model,"field":this.m_model.getField("delivery_hour_id"),"keyIds":["delivery_hour_id"]})
	]);
	
	//write
	this.setController(contr);
	this.getCommand(this.CMD_OK).setBindings([
		new CommandBinding({"control":this.getElement("number_from_site")}),
		new CommandBinding({"control":this.getElement("date_time")}),
		new CommandBinding({"control":this.getElement("client_name")}),
		new CommandBinding({"control":this.getElement("client_tel")}),
		new CommandBinding({"control":this.getElement("recipient_name")}),
		new CommandBinding({"control":this.getElement("recipient_tel")}),
		new CommandBinding({"control":this.getElement("address")}),
		new CommandBinding({"control":this.getElement("delivery_date")}),
		new CommandBinding({"control":this.getElement("delivery_comment")}),
		new CommandBinding({"control":this.getElement("card")}),
		new CommandBinding({"control":this.getElement("card_text")}),
		new CommandBinding({"control":this.getElement("anonym_gift")}),
		new CommandBinding({"control":this.getElement("extra_comment")}),
		new CommandBinding({"control":this.getElement("delivery_type")}),
		new CommandBinding({"control":this.getElement("recipient_type")}),
		new CommandBinding({"control":this.getElement("delivery_note_type")}),
		new CommandBinding({"control":this.getElement("payment_type")}),
		new CommandBinding({"control":this.getElement("delivery_hour"),"fieldId":"delivery_hour_id"})
	]);
	
	this.addDefDataBindings();
	
	if (multy_store=="1"){
		this.getCommand(this.CMD_OK).getBindings().push((new CommandBinding({"control":this.getElement("store"),"fieldId":"store_descr","keyIds":["store_id"]})));
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
extend(DOCClientOrder_View,ViewDOC);


DOCClientOrder_View.prototype.setDefRefVals = function(){	
	var constants = {"def_store":null,"def_payment_type_for_sale":null,"def_discount":null};
	this.getApp().getConstantManager().get(constants);
	var ctrl = this.getElement("store");
	if (ctrl){
		ctrl.setValue(constants.def_store.getValue());
	}	
}

DOCClientOrder_View.prototype.refreshTotal = function(){	
	//var f = this.getElement("product-grid").getFoot();
	
	
	var tot = 
		this.getElement("product-grid").getFoot().getElement("row0").getElement("total_val").getValue()+
		this.getElement("material-grid").getFoot().getElement("row0").getElement("total_val").getValue()
	;
	
	var c = this.getElement("total");
	var vl = this.getApp().numberFormat(tot,2);
	c.setValue("ИТОГО: "+vl+" руб.");
	
}
