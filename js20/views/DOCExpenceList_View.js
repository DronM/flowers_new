/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function DOCExpenceList_View(id,options){	

	DOCExpenceList_View.superclass.constructor.call(this,id,options);
	
	var model = new DOCExpenceList_Model({"data":options.modelDataStr});
	var contr = new DOCExpence_Controller(options.app);
		
	var multy_store = options.app.getServVars().multy_store;
	
	var constants = {"doc_per_page_count":null,"def_store":null,"grid_refresh_interval":null};
	options.app.getConstantManager().get(constants);
	
	var period_ctrl = new EditPeriodDateTime(id+":filter-ctrl-period",{
		"app":options.app,
		"valueFrom":(options.templateParams)? options.templateParams.date_from:"",
		"valueTo":(options.templateParams)? options.templateParams.date_to:"",
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
					"labelCaption":"Автор:",
					"keyIds":["user_id"],
					"app":options.app
					}),
				"field":new FieldInt("user_id")}),
			"sign":"e"
	};

	var grid_rows = [
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
		new GridCellHead(id+":grid:head:total",{
			"colAttrs":{"align":"right"},
			"columns":[
				new GridColumnFloat("total",{"field":model.getField("total")})
			]
		})
	);
	
	var popup_menu = new PopUpMenu();
		
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"keyIds":["id"],
		"editInline":false,
		"editWinClass":DOCExpence_Form,
		"onSelect":window.onSelect,
		"multySelect":window.multySelect,		
		"popUpMenu":popup_menu,
		"commands":new GridCmdContainerDOC(id+":grid:cmd",{
			"cmdFilter":true,
			"filters":filters,
			"popUpMenu":popup_menu,
			"colTemplate":"DOCExpenceList",
			"cmdDOCUnprocess":true,
			"app":options.app
		}),
		"head":new GridHead(id+":grid:head",{
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
							"value":"Итого","colSpan":(multy_store == "1")? "4":"3"
						}),
						new GridCellFoot(id+":grid:foot:total_val",{
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
		"pagination":new GridPagination(id+"_page",
			{"countPerPage":constants.doc_per_page_count.getValue(),"app":options.app}),		
		"refreshInterval":constants.grid_refresh_interval.getValue()*1000,		
		"rowSelect":false,
		"focus":true,
		"app":options.app
	}));	
	


}
extend(DOCExpenceList_View,ViewAjx);
