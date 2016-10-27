/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function DOCProductionList_View(id,options){	

	DOCProductionList_View.superclass.constructor.call(this,id,options);
	
	var model = new DOCProductionList_Model({"data":options.modelDataStr});
	var contr = new DOCProduction_Controller(options.app);
	
	var constants = {"doc_per_page_count":null};
	options.app.getConstantManager().get(constants);
	
	var multy_store = options.app.getServVars().multy_store;
	
	var period_ctrl = new EditPeriodDateTime(id+":filter-ctrl-period",{
		"app":options.app,
		"valueFrom":options.journDateFrom,
		"valueTo":options.journDateTo,
		"field":new FieldDateTime("date_time"),
		"app":options.app
	});
	
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
					"labelCaption":"Флорист:",
					"keyIds":["user_id"],
					"app":options.app
					}),
				"field":new FieldInt("user_id")}),
			"sign":"e"
	};
	
	var grid_rows = [
		new GridCellHead(id+":grid:head:date_time",{
			"columns":[
				new GridColumnDate({"field":model.getField("date_time"),"dateFormat":this.getApp().getJournalDateFormat()})
			],
			"sortable":true
		}),
		new GridCellHead(id+":grid:head:number",{
			"columns":[
				new GridColumn({"field":model.getField("number")})
			],
			"sortable":true
		}),
	];
	
	if (multy_store == "1"){
		grid_rows.push(new GridCellHead(id+":grid:head:store_descr",{
				"columns":[
					new GridColumn({"field":model.getField("store_descr")})
				],
				"sortable":true
		}));
	}
	
	grid_rows.push(	
		new GridCellHead(id+":grid:head:user_descr",{
			"columns":[
				new GridColumn({"field":model.getField("user_descr")})
			],
			"sortable":true
		})
	);
	
	grid_rows.push(	
		new GridCellHead(id+":grid:head:product_descr",{
			"columns":[
				new GridColumn({"field":model.getField("product_descr")})
			],
			"sortable":true
		})
	);
	grid_rows.push(	
		new GridCellHead(id+":grid:head:price",{
			"colAttrs":{"align":"right"},
			"columns":[
				new GridColumnFloat({"field":model.getField("price")})
			]
		})
	);
	
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"editInline":false,
		"editWinClass":DOCProduction_Form,
		"commands":new GridCommandsAjx(id+":grid:cmd",{
			"cmdFilter":true,
			"filters":filters,
			"app":options.app
		}),
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":grid_rows
				})
			]
		}),
		"autoRefresh":false,
		"pagination":new GridPagination(id+"_page",
			{"countPerPage":constants.doc_per_page_count,"app":options.app}),		
				
		"focus":true,
		"app":options.app
	}));	
	


}
extend(DOCProductionList_View,ViewAjx);
