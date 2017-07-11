function DOCClientOrderList_View(id,options){	

	DOCClientOrderList_View.superclass.constructor.call(this,id,options);
	
	var model = new DOCClientOrderList_Model({"data":options.modelDataStr});
	var contr = new DOCClientOrder_Controller(options.app);
	
	var constants = {"doc_per_page_count":null,"def_store":null,"grid_refresh_interval":null};
	options.app.getConstantManager().get(constants);
	
	var multy_store = options.app.getServVars().multy_store;
	var period_ctrl = new EditPeriodDateTime(id+":filter-ctrl-period",{
		"app":options.app,
		"valueFrom":(options.templateParams)? options.templateParams.date_from:"",
		"valueTo":(options.templateParams)? options.templateParams.date_to:"",
		"field":new FieldDateTime("date_time"),
		"app":options.app
	});
	
	var popup_menu = new PopUpMenu();
	
	var filters = {
		"period":{
			"binding":new CommandBinding({
				"control":period_ctrl,
				"field":period_ctrl.getField()
			}),
			"bindings":[
				{"binding":new CommandBinding({
					"control":period_ctrl.getControlFrom(),
					"field":period_ctrl.getField()
					}),
				"sign":"ge"
				},
				{"binding":new CommandBinding({
					"control":period_ctrl.getControlTo(),
					"field":period_ctrl.getField()
					}),
				"sign":"le"
				}
			]
		}
	};
	
	if (multy_store=="1"){
		filters.store = {
			"binding":new CommandBinding({
				"control":new StoreSelect(id+":filter-ctrl-store",{
					"contClassName":"form-group "+window.getBsCol(12),
					"value":constants.def_store.getValue(),
					"keyIds":["store_id"],
					"app":options.app
					}),
				"field":new FieldInt("store_id")}),
			"sign":"e"
		};
	}

	filters.delivery_hour = {
		"binding":new CommandBinding({
			"control":new DeliveryHourSelect(id+":filter-delivery_hour",{
				"labelCaption":"Время доставки:",
				"contClassName":"form-group "+window.getBsCol(12),
				"keyIds":["delivery_hour_id"],
				"app":options.app
				}),
			"field":new FieldInt("delivery_hour_id")}),
		"sign":"e"
	};
	filters.recipient_type = {
		"binding":new CommandBinding({
			"control":new Enum_recipient_types(id+":filter-recipient_type",{
				"labelCaption":"Вид получателя:",
				"contClassName":"form-group "+window.getBsCol(12),
				"app":options.app
				}),
			"field":new FieldInt("recipient_type")}),
		"sign":"e"
	};

	filters.client_order_state = {
		"binding":new CommandBinding({
			"control":new Enum_client_order_states(id+":filter-client_order_state",{
				"labelCaption":"Статус:",
				"contClassName":"form-group "+window.getBsCol(12),
				"app":options.app
				}),
			"field":new FieldInt("client_order_state")}),
		"sign":"e"
	};

	filters.payed = {
		"binding":new CommandBinding({
			"control":new EditCheckSelect(id+":filter-payed",{
				"labelCaption":"Оплачен:",
				"contClassName":"form-group "+window.getBsCol(12),
				"app":options.app
				}),
			"field":new FieldInt("payed")}),
		"sign":"e"
	};

	filters.payment_type = {
		"binding":new CommandBinding({
			"control":new Enum_payment_types(id+":filter-payment_type",{
				"labelCaption":"Вид оплаты:",
				"contClassName":"form-group "+window.getBsCol(12),
				"app":options.app
				}),
			"field":new FieldInt("payment_type")}),
		"sign":"e"
	};
	
	var grid_rows = [
		new GridCellHeadDOCProcessed(id+":grid:head:0:processed",{"model":model}),
		new GridCellHeadDOCDate(id+":grid:head:0:date_time",{"model":model,"app":options.app}),
		new GridCellHeadDOCNumber(id+":grid:head:0:number_from_site",{"model":model,"app":options.app})
	];
	
	if (multy_store == "1"){
		grid_rows.push(new GridCellHead(id+":grid:head:0:store_descr",{
			"value":"Салон",
			"columns":[
				new GridColumn("store",{"field":model.getField("store_descr")})
			],
			"sortable":true
		}));
	}
	/*
	grid_rows.push(	
		new GridCellHead(id+":grid:head:0:delivery_type_descr",{
			"value":"Доставка",
			"columns":[
				new GridColumn("delivery_type",{"field":model.getField("delivery_type_descr")})
			],
			"sortable":true
		})
	);
	*/
	grid_rows.push(	
		new GridCellHead(id+":grid:head:0:client_name",{
			"value":"Имя",
			"columns":[
				new GridColumn("client_name",{"field":model.getField("client_name")})
			],
			"sortable":true
		})
	);
	grid_rows.push(	
		new GridCellHead(id+":grid:head:0:client_tel",{
			"className":window.getBsCol(2),
			"value":"Телефон",
			"columns":[
				new GridColumnPhone("client_tel",{"field":model.getField("client_tel"),
				"app":options.app
				})
			]
		})
	);

	grid_rows.push(	
		new GridCellHead(id+":grid:head:0:delivery_date",{
			"colAttrs":{"align":"center"},
			"value":"Дата дост.",
			"columns":[
				new GridColumnDate("delivery_date",{"field":model.getField("delivery_date"),"dateFormat":options.app.getJournalDateFormat()})
			]
		})
	);
	grid_rows.push(	
		new GridCellHead(id+":grid:head:0:delivery_hour",{
			"value":"Время дост.",
			"colAttrs":{"align":"center"},
			"columns":[
				new GridColumn("delivery_hour",{"field":model.getField("delivery_hour_descr")})
			]
		})
	);
	grid_rows.push(	
		new GridCellHead(id+":grid:head:0:delivery_comment",{
			"value":"Примеч.",
			"columns":[
				new GridColumn("delivery_comment",{"field":model.getField("delivery_comment")})
			]
		})
	);
	grid_rows.push(	
		new GridCellHead(id+":grid:head:0:payment_type",{
			"value":"Оплата",			
			"columns":[
				new EnumGridColumn_payment_types("payment_type",{
					"field":model.getField("payment_type"),
					"app":options.app
				})
			]
		})
	);
	grid_rows.push(	
		new GridCellHead(id+":grid:head:0:payed",{
			"value":"Оплачен",
			"columns":[
				new GridColumnBool("payed",{"field":model.getField("payed")})
			]
		})
	);
	grid_rows.push(	
		new GridCellHead(id+":list-grid:head:client_order_state",{		
			"value":"Статус",
			"colAttrs":{
				"order_state":function(fields){
					return fields.client_order_state.getValue();
				}
			},
			"columns":[
				new EnumGridColumn_client_order_states("client_order_state",{"field":model.getField("client_order_state"),
					"app":options.app})
			]
		})												
	);
	grid_rows.push(	
		new GridCellHead(id+":grid:head:total",{
			"className":window.getBsCol(2),
			"colAttrs":{"align":"right"},
			"columns":[
				new GridColumnFloat("total",{"field":model.getField("total")})
			]
		})
	);
	
	/*
	grid_rows.push(	
		new GridCellHead(id+":list-grid:head:state_id",{
			//"visible":false,
			//"colAttrs":{"visible":false},
			"columns":[
				new GridColumn({"field":model.getField("client_order_state")})
			]
		})												
	);
	*/
	
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"keyIds":["id"],
		"editInline":false,
		"editWinClass":DOCClientOrder_Form,
		"popUpMenu":popup_menu,
		"commands":new DOCClientOrderGridCommand(id+":grid:cmd",{
			"printObjList":contr.getPrintList(),
			"filters":filters,
			"popUpMenu":popup_menu,
			"colTemplate":"DOCClientOrderList",
			"cmdDOCUnprocess":true,
			"popUpMenu":popup_menu,
			"app":options.app
		}),
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:0",{
					"elements":grid_rows
				})
			]
		}),
		"foot":null,
		"autoRefresh":false,
		"pagination":new GridPagination(id+"_page",
			{"countPerPage":constants.doc_per_page_count.getValue(),"app":options.app}),		
		"refreshInterval":constants.grid_refresh_interval.getValue()*1000,		
		"rowSelect":false,
		"refreshAfterDelRow":true,		
		"focus":true,
		"app":options.app
	}));	
	
}
extend(DOCClientOrderList_View,ViewAjx);
