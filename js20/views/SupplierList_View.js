/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function SupplierList_View(id,options){	

	SupplierList_View.superclass.constructor.call(this,id,options);
	
	var model = new SupplierList_Model({"data":options.modelDataStr});
	var contr = new Supplier_Controller(options.app);
	
	var constants = {"doc_per_page_count":null,"grid_refresh_interval":null};
	options.app.getConstantManager().get(constants);
	
	var popup_menu = new PopUpMenu();
	
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"editInline":false,
		"editWinClass":Supplier_Form,
		"popUpMenu":popup_menu,
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"popUpMenu":popup_menu,
			"colTemplate":"SupplierList",
			"app":options.app
		}),				
		/*
		"commands":new GridCommandsAjx(id+":grid:cmd",{
			"cmdFilter":true,
			"popUpMenu":popup_menu,
			"filters":{"name":{
					"binding":new CommandBinding({
						"control":new SupplierNameEdit(id+":filter-ctrl-name",{"app":options.app}),
						"field":new FieldString("name")}),
					"sign":"lk",
					"lwcards":true,
					"rwcards":true,
					"icase":true
					}
			},
			"app":options.app
		}),
		*/
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						new GridCellHead(id+":grid:head:name",{
							"columns":[
								new GridColumn("name",{"field":model.getField("name")})
							],
							"sortable":true,
							"sort":"asc"							
						}),
						new GridCellHead(id+":grid:head:tel",{
							"columns":[
								new GridColumnPhone("tel",{"field":model.getField("tel"),"app":options.app})
							]
						}),
						new GridCellHead(id+":grid:head:email",{
							"columns":[
								new GridColumn("email",{"field":model.getField("email")})
							]
						})
						
					]
				})
			]
		}),
		"pagination":new GridPagination(id+"_page",
			{"countPerPage":constants.doc_per_page_count,"app":options.app}),		
		"refreshInterval":constants.grid_refresh_interval.getValue()*1000,
		"autoRefresh":false,
		"rowSelect":false,
		"focus":true,
		"app":options.app
	}));	
	


}
extend(SupplierList_View,ViewAjx);
