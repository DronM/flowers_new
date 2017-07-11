/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function ProductBalanceList_View(id,options){	

	ProductBalanceList_View.superclass.constructor.call(this,id,options);
	
	this.m_model = new ProductBalanceList_Model({"data":options.modelDataStr});
	var contr = new Product_Controller(options.app);
	var doc_contr = new DOCProduction_Controller(options.app); 
	
	var constants = {"grid_refresh_interval":null,"def_store":null};
	options.app.getConstantManager().get(constants);
	
	var popup_menu = new PopUpMenu();
	
	var filters = {};
	
	var multy_store = options.app.getServVars().multy_store;
	
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
	
	filters.name = {
		"binding":new CommandBinding({
			"control":new ProductNameEdit(id+":filter-ctrl-name",{"app":options.app}),
			"field":new FieldString("name")}),
		"sign":"lk",
		"lwcards":true,
		"rwcards":true,
		"icase":true
	};

	
	var grid_rows = [];
	
	if (multy_store == "1"){
		grid_rows.push(new GridCellHead(id+":grid:head:store_descr",{
				"columns":[
					new GridColumn("store",{"field":this.m_model.getField("store_descr")})
				],
				"sortable":true
		}));
	};
	
	grid_rows.push(
		new GridCellHead(id+":grid:head:code",{
			"columns":[
				new GridColumn("code",{"field":this.m_model.getField("code")})
			],
			"sortable":true
		})
	);
	grid_rows.push(
		new GridCellHead(id+":grid:head:name",{
			"columns":[
				new GridColumn("name",{"field":this.m_model.getField("name")})
			],
			"sortable":true,
			"sort":"asc"							
		}),
		new GridCellHead(id+":grid:head:total",{
			"colAttrs":{"align":"right"},
			"columns":[
				new GridColumnFloat("total",{"field":this.m_model.getField("total")})
			],
			"sortable":true
		})
	);
	grid_rows.push(
		new GridCellHead(id+":grid:head:after_production_time",{
			"colAttrs":{"align":"center"},
			"columns":[
				new GridColumnCustomTime("after_production_time",{"field":this.m_model.getField("after_production_time")})
			],
			"sortable":true
		})
	);
	
	this.addElement(new GridAjx(id+":grid",{
		"model":this.m_model,
		"controller":contr,
		"keyIds":["id"],
		"readPublicMethod":contr.getPublicMethod("get_list_with_balance"),
		"popUpMenu":popup_menu,
		"editInline":false,
		"editWinClass":Product_Form,
		/*
		"commands":new GridCommandsAjx(id+":grid:cmd",{
			"cmdInsert":false,
			"cmdEdit":false,
			"cmdDelete":false,
			"cmdFilter":true,
			"popUpMenu":popup_menu,
			"printObjList":doc_contr.getPrintList(),
			"printObjListKeyIds":["doc_production_id"],
			"filters":filters,
			"app":options.app
		}),
		*/
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"printObjList":doc_contr.getPrintList(),
			"popUpMenu":popup_menu,
			"colTemplate":"ProductBalanceList",			
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
		"refreshInterval":constants.grid_refresh_interval.getValue()*1000,
		"focus":true,
		"lastRowFooter":true,
		"rowSelect":false,
		"app":options.app
	}));	
	


}
extend(ProductBalanceList_View,ViewAjx);
