/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function MaterialBalanceList_View(id,options){	

	MaterialBalanceList_View.superclass.constructor.call(this,id,options);
	
	var model = new MaterialBalanceList_Model({"data":options.modelDataStr});
	var contr = new Material_Controller(options.app);
	
	var constants = {"grid_refresh_interval":null,"def_store":null};
	options.app.getConstantManager().get(constants);
	
	var self = this;
	
	//быстрый фильтр
	var mat_groups = new MaterialGroupRadio(id+":mat-groups",{
		"onSelect":function(){
			self.m_grid.onRefresh();
		},
		"app":options.app
	});
	
	var mat_name = new MaterialNameEdit(id+":mat-name",{
		"events":{
			"keyup":function(e){
				self.m_grid.onRefresh();
			}
		},
		"app":options.app
		});
	
	this.m_fastFilter = new GridFilter(CommonHelper.uniqid(),{
			"filters":{
				"material_group":{
					"binding":new CommandBinding({
						"control":mat_groups,
						"field":new FieldInt("material_group_id")}),
					"sign":"e"
				},
				"material_name":{
					"binding":new CommandBinding({
						"control":mat_name,
						"field":new FieldString("name")}),
					"sign":"lk",
					"lwcards":true,
					"rwcards":true,
					"icase":true
				}
			},
			"app":options.app
	});	
	
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
	
	filters.on_date = {
		"binding":new CommandBinding({
			"control":new EditDateTime(id+":mat-bal_date",{
				"labelCaption":"Дата остатков:",
				"app":options.app}),
		"field":new FieldDateTime("date_time")}),
		"sign":"e"				
	};

	var grid_rows = [];
	
	if (multy_store == "1"){
		grid_rows.push(new GridCellHead(id+":grid:head:store_descr",{
				"columns":[
					new GridColumn("store",{"field":model.getField("store_descr")})
				],
				"sortable":true
		}));
	};
	
	grid_rows.push(
		new GridCellHead(id+":grid:head:name",{
			"columns":[
				new GridColumn("name",{"field":model.getField("name")})
			],
			"sortable":true,
			"sort":"asc"							
		})
	);
	grid_rows.push(
		new GridCellHead(id+":grid:head:main_quant",{
			"colAttrs":{"align":"right"},
			"columns":[
				new GridColumnFloat("main_quant",{"field":model.getField("main_quant")})
			],
			"sortable":true
		})
	);
	grid_rows.push(	
		new GridCellHead(id+":grid:head:price",{
			"colAttrs":{"align":"right"},
			"columns":[
				new GridColumnFloat("price",{"field":model.getField("price")})
			],
			"sortable":true
		})
	);
	grid_rows.push(
		new GridCellHead(id+":grid:head:main_total",{
			"colAttrs":{"align":"right"},
			"columns":[
				new GridColumnFloat("main_total",{"field":model.getField("main_total")})
			],
			"sortable":true
		})
	);
	
	this.m_grid = new GridAjx(id+":grid",{
		"keyIds":["id"],
		"model":model,
		"controller":contr,
		"readPublicMethod":contr.getPublicMethod("get_list_with_balance"),
		"editInline":false,
		//"cmdEdit":false,
		"editWinClass":Product_Form,
		"commands":new GridCommandsAjx(id+":grid:cmd",{
			"cmdInsert":false,
			"cmdEdit":false,
			"cmdDelete":false,
			"cmdFilter":true,
			"popUpMenu":popup_menu,
			"printObjList":contr.getPrintList(),
			"printObjListKeyIds":["id"],
			
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
		"refreshInterval":constants.grid_refresh_interval.getValue()*1000,
		"focus":true,
		"lastRowFooter":true,
		"app":options.app
	});
	
	this.m_gridRefresh = this.m_grid.onRefresh;
	this.m_gridSetFilters = this.m_grid.setFilters;

	this.m_grid.setFilters = function(){
		self.m_gridSetFilters.call(self.m_grid);
		self.m_fastFilter.getFilter().applyFilters(self.m_grid.getReadPublicMethod(),true);
	}
	
	this.m_grid.onRefresh = function(){
		self.refreshGrid();
	}

	this.addElement(mat_groups);
	this.addElement(mat_name);
	this.addElement(this.m_grid);
}
extend(MaterialBalanceList_View,ViewAjx);

MaterialBalanceList_View.prototype.refreshGrid = function(){		
	/*
	console.log("mat-groups="+this.getElement("mat-groups").getValue());
	console.log("mat-name="+this.getElement("mat-name").getValue());
	console.log("REFRESH!");
	*/	
	this.m_gridRefresh.call(this.m_grid);
}
