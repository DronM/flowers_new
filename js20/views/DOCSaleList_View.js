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
	var period_ctrl = new EditPeriodDateTime(id+":filter-ctrl-period",{
		"app":options.app,
		"valueFrom":options.journDateFrom,
		"valueTo":options.journDateTo,
		"field":new FieldDateTime("date_time"),
		"app":options.app
	});
	
	var constants = {"doc_per_page_count":null};
	options.app.getConstantManager().get(constants);
	
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"editInline":false,
		"editWinClass":DOCSale_Form,
		"commands":new GridCommandsAjx(id+":grid:cmd",{
			"cmdFilter":true,
			"filters":{
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
				},
				"user":{
					"binding":new CommandBinding({
						"control":new UserEditRef(id+":filter-ctrl-user",{
							"app":options.app,
							"labelCaption":"Флорист:",
							"keyIds":["user_id"],
							"app":options.app
							}),
						"field":new FieldInt("user_id")}),
					"sign":"e"
					},
				"payment_type_for_sale":{
					"binding":new CommandBinding({
						"control":new PaymentTypeForSaleSelect(id+":filter-ctrl-paym_tp_for_sale",{
							"app":options.app,
							"keyIds":["payment_type_for_sale_id"],
							"app":options.app
							}),
						"field":new FieldInt("payment_type_for_sale_id")}),
					"sign":"e"
					}
				
			},
			"app":options.app
		}),
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						new GridCellHead(id+":grid:head:date_time",{
							"columns":[
								new GridColumnDate({"field":model.getField("date_time"),"dateFormat":options.app.getJournalDateFormat()})
							],
							"sortable":true
						}),
						new GridCellHead(id+":grid:head:number",{
							"columns":[
								new GridColumn({"field":model.getField("number")})
							],
							"sortable":true
						}),
					
						new GridCellHead(id+":grid:head:store_descr",{
							"columns":[
								new GridColumn({"field":model.getField("store_descr")})
							],
							"sortable":true
						}),
						new GridCellHead(id+":grid:head:user_descr",{
							"columns":[
								new GridColumn({"field":model.getField("user_descr")})
							],
							"sortable":true
						}),
						new GridCellHead(id+":grid:head:payment_type_for_sale_descr",{
							"colAttrs":{"align":"right"},
							"columns":[
								new GridColumn({"field":model.getField("payment_type_for_sale_descr")})
							],
							"sortable":true
						}),
						
						new GridCellHead(id+":grid:head:total",{
							"colAttrs":{"align":"right"},
							"columns":[
								new GridColumnFloat({"field":model.getField("total")})
							]
						}),
						new GridCellHead(id+":grid:head:cost",{
							"colAttrs":{"align":"right"},
							"columns":[
								new GridColumnFloat({"field":model.getField("cost")})
							]
						}),
						new GridCellHead(id+":grid:head:income",{
							"colAttrs":{"align":"right"},
							"columns":[
								new GridColumnFloat({"field":model.getField("income")})
							]
						}),
						new GridCellHead(id+":grid:head:income_percent",{
							"colAttrs":{"align":"right"},
							"columns":[
								new GridColumnFloat({"field":model.getField("income_percent"),"format":"%%"})
							]
						})
						
					]
				})
			]
		}),
		"autoRefresh":false,
		"focus":true,
		"pagination":new GridPagination(id+"_page",
			{"countPerPage":constants.doc_per_page_count,"app":options.app}),		
				
		"app":options.app
	}));	
	


}
extend(DOCSaleList_View,ViewAjx);