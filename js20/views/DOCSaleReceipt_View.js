/* Copyright (c) 2016 
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
 * @requires 
 * @requires core/extend.js  
*/

/* constructor
@param string id
@param object options{

}
*/
function DOCSaleReceipt_View(id,options){
	options = options || {};	
	
	var bs = window.getBsCol();
	var receipt_model = new ReceiptList_Model({"data":options.ReceiptList_Model});
	
	var pay_type_model = new ReceiptPaymentTypeList_Model({"data":options.ReceiptPaymentTypeList_Model});
	var pay_types_model = new PaymentTypeForSale_Model({"data":options.PaymentTypeForSale_Model});
	
	var receipt_head_model = new ReceiptHeadList_Model({"data":options.ReceiptHeadList_Model});
	var receipt_contr = new Receipt_Controller(options.app);
	var self = this;
	
	options.elements = [
		new EditString(id+":barcode",{
			"placeholder":"Штрих-код",
			"contClassName":bs+"4",
			"editContClassName":"input-group "+bs+"12",
			"cmdClear":true,
			"attrs":{"maxlength":"13"},
			"buttonOpen":new ButtonCtrl(id+":barcode_find",{
				"glyph":"glyphicon-search",
				"onClick":function(){
					if (self.getElement("barcode").getValue().length){
						self.findByBarcode();
					}
				},
				"app":options.app
			}),
			"events":{
				"input":function(){
					var val = self.getElement("bercode").getValue();
					if ((val.substr(0,1)==9 && val.length==12) || val.length==13){
						self.findByBarcode();
					}
				},
				"keypress":function(e){
					e = EventHelper.fixKeyEvent(e);
					if (e.keyCode==13){
						self.findByBarcode();
					}
				}			
			},
			"app":options.app
		}
		),
		
		/*
		new PaymentTypeForSaleSelect(id+":payment_type_for_sale",{
			//"contClassName":bs+"2",			
			//"editContClassName":"input-group "+bs+"12",
			"app":options.app
		}),
		*/
		
		new ClientEditRef(id+":client",{
			"placeholder":"Клиент",
			"labelCaption":"Клиент:",
			"contClassName":bs+"4",
			"editContClassName":"input-group "+bs+"12",
			"onSelect":function(fields){
				var v = fields.discount_id.getValue();
				self.getElement("discount").setValue(new RefType({"keys":{"discount_id":v}}));
				m = self.getElement("discount").getModel();
				self.setDiscountPercent(m.getFieldValue("percent"));
				self.saveHead();
			},	
			"app":options.app		
		}),

		new DiscountSelect(id+":discount",{
			"labelCaption":"Вид скидки:",
			"contClassName":bs+"4",
			"labelClassName":"control-label "+bs+12,
			"editContClassName":"input-group "+bs+"12",
			"keyIds":["id"],
			"keyFieldId":["id"],
			"onSelect":function(fields){
				self.setDiscountPercent(fields.percent.getValue());
				self.saveHead();
			},
			"app":options.app
		}),

		new DOCClientOrderEditRef(id+":doc_client_order",{
			"labelCaption":"Заказ:",
			"contClassName":bs+"4",
			"editContClassName":"input-group "+bs+"12",
			"onSelect":function(fields){
				self.onDOCClientSelected();
				//self.saveHead();
			},
			"app":options.app
		}),
		
		new GridAjxDOCT(id+":receipt-grid",{
			"keyIds":["user_id","item_id","item_type"],
			"model":receipt_model,
			"controller":receipt_contr,
			"navigate":false,
			"cmdEdit":false,
			"editInline":null,
			"editWinClass":null,
			"editViewClass":null,
			"editViewOptions":null,
			"commands":null,
			"head":new GridHead(id+":receipt-grid:head",{
				"elements":[
					new GridRow(id+":receipt-grid:head:row0",{
						"elements":[
							new GridCellHead(id+":receipt-grid:head:receipt",{
								"value":"Номенклатура",
								"className":bs+"4",
								"columns":[
									new GridColumn("item_name",{"field":receipt_model.getField("item_name")
									})
								]
							}),
					
							new GridCellHead(id+":receipt-grid:head:quant",{
								"value":"Количество",
								"className":bs+"1",
								"colAttrs":{"align":"right"},
								"columns":[
									new GridColumnFloat("quant",{"field":receipt_model.getField("quant"),
									"cellClass":ReceiptQuantCell
									})
								]
							}),
							new GridCellHead(id+":receipt-grid:head:price_no_disc",{
								"value":"Цена",
								"className":bs+"2",
								"colAttrs":{"align":"right"},
								"columns":[
									new GridColumnFloat("price_no_disc",{"field":receipt_model.getField("price_no_disc")
									})
								]
							}),
							new GridCellHead(id+":receipt-grid:head:disc_percent",{
								"value":"Скидка,%",
								"className":bs+"1",
								"colAttrs":{"align":"right"},
								"columns":[
									new GridColumnFloat("disc_percent",{"field":receipt_model.getField("disc_percent"),
									"cellClass":ReceiptDiscPercentCell
									})
								]
							}),						
							new GridCellHead(id+":receipt-grid:head:total",{
								"value":"Итого",
								"className":bs+"3",
								"colAttrs":{"align":"right"},
								"columns":[
									new GridColumnFloat("total",{"field":receipt_model.getField("total")
									})
								]
							})
							//sys col
							,new GridCellHead(id+":receipt-grid:head:sys-cmd",{
								"value":"...",
								"className":bs+"1",
								"columns":[new GridColumn("sys-cmd",{"cellClass":DOCSaleReceiptSysCell
								})]							
							})						
						]
					})
				]
			}),
			"foot":new GridFoot(id+":receipt-grid:foot",{
				"className":"receipt_totals",
				"autoCalc":true,			
				"elements":[
					new GridRow(id+":receipt-grid:foot:row0",{
						"elements":[
							new GridCell(id+":receipt-grid:foot:row0:total_lb",{
								"value":"Итого к оплате:","colSpan":"4"
							}),
							new GridCellFoot(id+":receipt-grid:foot:row0:total_val",{
								"colSpan":"2",
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
			"app":options.app
		}),
		
		new GridAjx(id+":payment_type-grid",{
			"className":"table table-bordered table-responsive table-striped payment_type_grid",
			"keyIds":["dt"],
			"model":pay_type_model,
			"controller":receipt_contr,
			"readPublicMethod":receipt_contr.getPublicMethod("get_payment_type_list"),
			"navigate":false,
			"cmdEdit":false,
			"editInline":null,
			"editWinClass":null,
			"editViewClass":null,
			"editViewOptions":null,
			"commands":new GridCommands(id+":material-grid:cmd",{
				"controlInsert":new ReceiptPayTypeAddBtn(id+":material-grid:cmd:cmdInsert",{
					"model":pay_types_model,
					"pm":receipt_contr.getPublicMethod("add_payment_type"),
					"refresh":function(){
						self.getElement("payment_type-grid").onRefresh();
					}
				}),
				"cmdInsert":true,
				"cmdEdit":false,
				"cmdCopy":false,
				"cmdDelete":false,
				"cmdRefresh":false,
				"cmdFilter":false,
				"cmdPrint":false,
				"cmdPrintObj":false,
				"app":options.app
			}),
			"head":new GridHead(id+":payment_type-grid:head",{
				"attrs":{"class":"hidden"},
				"elements":[
					new GridRow(id+":payment_type-grid:head:row0",{
						"elements":[
							new GridCellHead(id+":payment_type-grid:head:payment_type_for_sale",{
								"value":"Тип оплаты",
								"className":bs+"7",
								"columns":[
									new GridColumn("payment_type_for_sale",{"field":pay_type_model.getField("payment_type_for_sale_descr")
									//,"cellClass":DOCSalePayTypePayTypeCell,
									//"cellOptions":{"app":options.app}
									})
								]
							}),
					
							new GridCellHead(id+":payment_type-grid:head:total",{
								"value":"Получено",
								"className":bs+"4",
								"colAttrs":{"align":"right"},
								"columns":[
									new GridColumnFloat("total",{"field":pay_type_model.getField("total"),
									"cellClass":DOCSalePayTypeTotalCell
									})
								]
							})
							//sys col
							,new GridCellHead(id+":receipt-grid:head:sys-cmd",{
								"value":"...",
								"className":bs+"1",
								"columns":[new GridColumn("sys-cmd",{"cellClass":DOCSalePayTypeSysCell
								})]							
							})													
						]
					})
				]
			}),
			"foot":new GridFoot(id+":payment_type:foot",{
				//"className":"receipt_totals",
				"autoCalc":true,			
				"elements":[
					new GridRow(id+":payment_type:foot:row0",{
						"elements":[
							new GridCell(id+":payment_type:foot:row0:change_lb",{
								"value":"Сдача:"
							}),
							new GridCellFoot(id+":payment_type:foot:row0:change_val",{
								"colSpan":"2",
								"attrs":{"align":"right"},
								"calcOper":"sum",
								"calcFieldId":"total",
								"calcEnd":function(){
									//console.log("total="+this.getTotal());
									var purch_total = self.getElement("receipt-grid").getFoot().getElement("row0").getElement("total_val").getValue();
									this.setValue(this.getTotal()-purch_total);
								},
								"gridColumn":new GridColumnFloat("change_val",{})
							})						
						]
					})		
				]
			}),							
			"autoRefresh":false,
			"refreshInterval":0,
			"app":options.app
		}),
		
		new ButtonCmd(id+":btnClear",		
			{"caption":"Очистить",
			"onClick":function(){
				var contr = new Receipt_Controller(self.getApp());
				contr.run("clear",{async:false});
				self.getElement("receipt-grid").onRefresh();
				self.getElement("payment_type-grid").onRefresh();								
				self.getElement("client").reset();
				self.getElement("discount").reset();
				self.getElement("doc_client_order").reset();
				self.getElement("barcode").focus();
			},
			"attrs":{
				"title":"удалить все строки"}
			}
		),
		new ButtonCmd(id+":btnProcess",		
			{"caption":"Пробить",
			"onClick":function(){
				self.process();
			},
			"attrs":{
				"title":"пробить чек по ККМ"}
			}
		)
		
	];
	
	DOCSaleReceipt_View.superclass.constructor.call(this,id,options);

	//ПЕРЕКРЫТОЕ ОБНОВЛЕНИЕ ГРИДА ЧЕКА ЧТОБЫ ОБНОВЛЯТЬ СДАЧУ!!!
	var gr = this.getElement("receipt-grid");
	this.m_receiptRefresh = gr.onRefresh;
	gr.onRefresh = function(){
		self.m_receiptRefresh.call(self.getElement("receipt-grid"));
		self.getElement("payment_type-grid").onRefresh();
	}
	//**************************************
	
	//save_head
	this.setDataBindings([
		new DataBinding({"control":this.getElement("client"),"model":receipt_head_model,"field":receipt_head_model.getField("client_descr"),"keyIds":["client_id"]}),
		new DataBinding({"control":this.getElement("discount"),"model":receipt_head_model,"field":receipt_head_model.getField("discount_descr"),"keyIds":["discount_id"]}),
		new DataBinding({"control":this.getElement("doc_client_order"),"model":receipt_head_model,"field":receipt_head_model.getField("doc_client_order_descr"),"keyIds":["doc_client_order_id"]})
	]);
	this.addCommand(new Command({
		"publicMethod":receipt_contr.getPublicMethod("save_head"),
		"async":true,
		"bindings":[
			new CommandBinding({"control":this.getElement("client"),"fieldId":"client_id"}),
			new CommandBinding({"control":this.getElement("discount"),"fieldId":"discount_id"}),
			new CommandBinding({"control":this.getElement("doc_client_order"),"fieldId":"doc_client_order_id"})
		]
	}));
	

	//clear
	this.addCommand(new Command({
		"publicMethod":receipt_contr.getPublicMethod("clear"),
		"async":true
	}));
	
	//add_by_code
	this.addCommand(new Command({
		"publicMethod":receipt_contr.getPublicMethod("add_by_code"),
		"async":false,
		"bindings":[
			new CommandBinding({"control":this.getElement("barcode"),"fieldId":"barcode"})
		]
	}));

	//fill_on_client_order
	this.addCommand(new Command({
		"publicMethod":receipt_contr.getPublicMethod("fill_on_client_order"),
		"async":false,
		"bindings":[
			new CommandBinding({"control":this.getElement("doc_client_order"),"fieldId":"doc_client_order_id"})
		]
	}));

	//close
	this.addCommand(new Command({
		"publicMethod":receipt_contr.getPublicMethod("close"),
		"async":false,
		"bindings":[
			new CommandBinding({"control":this.getElement("client"),"fieldId":"client_id"}),
			new CommandBinding({"control":this.getElement("doc_client_order"),"fieldId":"doc_client_order_id"})
		]
	}));

}
extend(DOCSaleReceipt_View,ViewAjx);

/* Constants */


/* private members */

/* protected*/


/* public methods */
DOCSaleReceipt_View.prototype.findByBarcode = function(){
	var self = this;	
	this.execCommand("add_by_code",
		function(resp){
			self.setHeadFromResp(resp);
			self.getElement("receipt-grid").onRefresh();			
			var ctrl = self.getElement("barcode");
			ctrl.setValue("");
			ctrl.focus();
		}	
	)
}

DOCSaleReceipt_View.prototype.setDiscountPercent = function(v){	
	v = (isNaN(v))? 0:v;
	var gr = this.getElement("receipt-grid");
	gr.setEditViewOptions({"discountPercent":v});
	var pm = gr.getReadPublicMethod().getController().getPublicMethod("set_disc_percent");
	pm.setFieldValue("disc_percent",v);
			
	pm.run({async:false});
	gr.onRefresh();	
}

DOCSaleReceipt_View.prototype.process = function(){

	var CACH_CLOSE_TYPE = 0;
	
	var payment_type_grid =  this.getElement("payment_type-grid");
	
	var change = payment_type_grid.getFoot().getElement("row0").getElement("change_val").getValue();
	
	var close_types = {};
	var cash_total=0;//весть нал
	
	var m = payment_type_grid.getModel();
	
	m.reset();
	while(m.getNextRow()){
		var close_t = m.getFieldValue("kkm_type_close");
		var total_t = m.getFieldValue("total");
		
		if (close_types[close_t]){
			close_types[close_t]+=total_t;
		}
		else{
			close_types[close_t] = total_t;
		}
		
		if (close_t==CACH_CLOSE_TYPE){
			cash_total+= total_t;
		}
	}
	
	if (change>0 && cash_total<change){
		//оплата за нал и есть сдача
		throw new Error("Оплата за наличный расчет меньше сдачи!");
	}
	else if (change>0){
		close_types[CACH_CLOSE_TYPE]-= change;//без сдачи
	}
	
	this.m_cashRegData = [];

	//проверка общего количества
	var m = this.getElement("receipt-grid").getModel();
	
	var total_q = 0;
	var total_total = 0;
	
	//проверки && общее количество
	m.reset();
	while(m.getNextRow()){
		total_q+= m.getFieldValue("quant");
		total_total+= m.getFieldValue("total");
	}
	
	if (total_q==0){
		throw new Error("Количество равно нулю!");
	}

	//Распределение видов оплат по товарам
	for (close_t in close_types){
		
		close_t_sruc = 	{
			"typeClose":parseInt(close_t),
			"items":[],
			"total":0,
			"change":(close_t == CACH_CLOSE_TYPE)? change:0,
			"pwd":this.getApp().getCachierSalePwd()
			//"1"
		};

		//Коэффициент типа оплаты из всей суммы
		var close_t_k = close_types[close_t]/total_total;
		
		//закрыли по типу оплаты
		var close_t_total = 0;
		
		m.reset();
		while(m.getNextRow()){
			var item_total = Math.round(m.getFieldValue("total")*close_t_k*100)/100;
			
			close_t_sruc.items.push({
				"Name":m.getFieldValue("item_name"),
				"Quantity":m.getFieldValue("quant"),
				"Price": Math.round(item_total/m.getFieldValue("quant")*100)/100,
				"Department":1
			});

			close_t_sruc.total+= item_total;
			
			close_t_total+= item_total;
		}
		if (close_t_sruc.total != close_t_total){
			close_t_sruc.total = close_types[close_t] - close_t_sruc.total + close_t_total;
		}
		
		this.m_cashRegData.push(close_t_sruc);
	}
	
	var self = this;
	this.execCommand("close",function(){
			self.processOnKKM();
		}	
	);	
}

DOCSaleReceipt_View.prototype.processOnKKM = function(){	
	this.getElement("client").reset();
	this.getElement("discount").reset();
	this.getElement("doc_client_order").reset();
	this.saveHead();

	//throw new Error(JSON.stringify({"checks":this.m_cashRegData}));
	//Чек по кассе
	var reg = this.getApp().getCachRegister();
	if (reg){
		reg.printCheck({"checks":this.m_cashRegData});
	}
	else{
		window.showError("ККМ не инициализирована!");
	}	
	
	this.getElement("receipt-grid").onRefresh();	
	this.getElement("barcode").focus();

}
DOCSaleReceipt_View.prototype.saveHead = function(){	
	this.execCommand("save_head");
}

DOCSaleReceipt_View.prototype.setHeadFromResp = function(resp){		
	var m = new ReceiptHeadList_Model({"data":resp.getModelData("ReceiptHeadList_Model")});
	if (m.getRowCount()){
		m.getRow(0);
		this.getElement("client").setValue(
			new RefType({
				"keys":{"client_id":m.getFieldValue("client_id")},
				"descr":m.getFieldValue("client_descr")
			})		
		);
		this.getElement("discount").setValue(
			new RefType({
				"keys":{"discount_id":m.getFieldValue("discount_id")},
				"descr":m.getFieldValue("discount_descr")
			})		
		);		
	}
}

DOCSaleReceipt_View.prototype.onDOCClientSelected = function(){		
	var self = this;
	this.execCommand("fill_on_client_order",
		function(resp){
			self.setHeadFromResp(resp);
			self.getElement("receipt-grid").onRefresh();	
		}	
	);
}

DOCSaleReceipt_View.prototype.getModified = function(cmd){
	return true;
}
