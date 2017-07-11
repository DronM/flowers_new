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
	
	var bs = window.getBsCol();
	
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
		new GridCellHead(id+":grid:head:product_descr",{
			"columns":[
				new GridColumn("product",{"field":model.getField("product_descr")})
			],
			"sortable":true
		})
	);
	grid_rows.push(	
		new GridCellHead(id+":grid:head:price",{
			"colAttrs":{"align":"right"},
			"columns":[
				new GridColumnFloat("price",{"field":model.getField("price")})
			]
		})
	);
	
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"keyIds":["id"],
		"editInline":false,
		"editWinClass":DOCProduction_Form,
		"popUpMenu":popup_menu,
		"commands":new GridCmdContainerDOC(id+":grid:cmd",{
			"colTemplate":"DOCProductionList",			
			"filters":filters,
			"cmdDOCUnprocess":true,
			"printObjList":contr.getPrintList(),
			"popUpMenu":popup_menu,
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
			{"countPerPage":constants.doc_per_page_count.getValue(),"app":options.app}),		
		"refreshInterval":constants.grid_refresh_interval.getValue()*1000,		
		"rowSelect":false,
		"refreshAfterDelRow":true,
		"focus":true,
		"app":options.app
	}));	
	


}
extend(DOCProductionList_View,ViewAjx);
