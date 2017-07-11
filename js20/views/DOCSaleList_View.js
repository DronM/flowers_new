/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function DOCSaleList_View(id,options){	

	DOCSaleList_View.superclass.constructor.call(this,id,options);
	
	var model = new DOCSaleList_Model({"data":options.modelDataStr});
	var contr = new DOCSale_Controller(options.app);
	
	//var param_model = new TemplateParamValList_Model({"data":options.templateParamDataStr});
	
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
	
	filters.user = {
			"binding":new CommandBinding({
				"control":new UserEditRef(id+":filter-ctrl-user",{
					"contClassName":"form-group "+window.getBsCol(12),
					"labelCaption":"Флорист:",
					"keyIds":["user_id"],
					"app":options.app
					}),
				"field":new FieldInt("user_id")}),
			"sign":"e"	
	};
	/*
	filters.payment_type_for_sale = {
		"binding":new CommandBinding({
			"control":new PaymentTypeForSaleSelect(id+":filter-ctrl-paym_tp_for_sale",{
				"contClassName":"form-group "+window.getBsCol(12),
				"app":options.app,
				"keyIds":["payment_type_for_sale_id"],
				"app":options.app
				}),
			"field":new FieldInt("payment_type_for_sale_id")}),
		"sign":"e"
		}
	*/
	var grid_rows = [
		new GridCellHeadDOCProcessed(id+":grid:head:processed",{"model":model}),
		new GridCellHeadDOCDate(id+":grid:head:date_time",{"model":model,"app":options.app}),
		new GridCellHeadDOCNumber(id+":grid:head:number",{"model":model,"app":options.app})
	];
	
	if (multy_store == "1"){
		grid_rows.push(new GridCellHead(id+":grid:head:store_descr",{
				"columns":[
					new GridColumn("store",{"field":model.getField("store_descr")})
				],
				"sortable":true
		}));
	}
	
	grid_rows.push(	
		new GridCellHead(id+":grid:head:user_descr",{
			"columns":[
				new GridColumn("user",{"field":model.getField("user_descr")})
			],
			"sortable":true
		})
	);
	
	grid_rows.push(	
		new GridCellHead(id+":grid:head:payment_type_for_sale_descr",{
			"colAttrs":{"align":"right"},
			"columns":[
				new GridColumn("payment_type_for_sale",{"field":model.getField("payment_type_for_sale_descr")})
			],
			"sortable":true
		})
	);
	grid_rows.push(	
		new GridCellHead(id+":grid:head:total",{
			"colAttrs":{"align":"right"},
			"columns":[
				new GridColumnFloat("total",{"field":model.getField("total")})
			]
		})
	);

	grid_rows.push(	
		new GridCellHead(id+":grid:head:cost",{
			"colAttrs":{"align":"right"},
			"columns":[
				new GridColumnFloat("cost",{"field":model.getField("cost")})
			]
		})
	);

	grid_rows.push(	
		new GridCellHead(id+":grid:head:income",{
			"colAttrs":{"align":"right"},
			"columns":[
				new GridColumnFloat("income",{"field":model.getField("income")})
			]
		})
	);

	grid_rows.push(	
		new GridCellHead(id+":grid:head:income_percent",{
			"colAttrs":{"align":"right"},
			"columns":[
				new GridColumnFloat("income_percent",{"field":model.getField("income_percent"),"format":"%%"})
			]
		})
	);
	
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"keyIds":["id"],
		"editInline":false,
		"editWinClass":DOCSale_Form,
		"popUpMenu":popup_menu,
		"commands":new GridCmdContainerDOC(id+":grid:cmd",{
			"printObjList":contr.getPrintList(),
			"filters":filters,
			"popUpMenu":popup_menu,
			"colTemplate":"DOCSaleList",
			"cmdDOCUnprocess":true,
			"app":options.app
		}),
		"filters":filters,
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":grid_rows
				})
			]
		}),
		"foot":new GridFoot(id+":grid:foot",{
			"autoCalc":true,			
			"elements":[
				new GridRow(id+":grid:foot:row0",{
					"elements":[
						new GridCell(id+":grid:foot:total_lb",{
							"value":"Итого","colSpan":(multy_store == "1")? "6":"5"
						}),
						new GridCellFoot(id+":grid:foot:total_val",{
							"attrs":{"align":"right"},
							//"calcOper":"sum",
							//"calcFieldId":"total",
							"calcEnd":function(m){
								this.setValue(m.getAttr("total_total"));
							},							
							"gridColumn":new GridColumnFloat("total_val",{})
						}),
						new GridCellFoot(id+":grid:foot:cost_val",{
							"attrs":{"align":"right"},
							//"calcOper":"sum",
							//"calcFieldId":"cost",
							"calcEnd":function(m){
								this.setValue(m.getAttr("total_cost"));
							},							
							"gridColumn":new GridColumnFloat("cost_val",{})
						}),
						new GridCellFoot(id+":grid:foot:income_val",{
							"attrs":{"align":"right"},
							//"calcOper":"avg",
							//"calcFieldId":"income",
							"calcEnd":function(m){
								this.setValue(m.getAttr("avg_income"));
							},							
							"gridColumn":new GridColumnFloat("income_val",{})
						}),
						new GridCellFoot(id+":grid:foot:income_percent_val",{
							"attrs":{"align":"right"},
							//"calcOper":"avg",
							//"calcFieldId":"income_percent",
							"calcEnd":function(m){
								this.setValue(m.getAttr("avg_income_percent"));
							},														
							"gridColumn":new GridColumnFloat("income_percent_val",{})
						})																		
					]
				})		
			]
		}),
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
extend(DOCSaleList_View,ViewAjx);
