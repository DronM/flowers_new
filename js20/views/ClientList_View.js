/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function ClientList_View(id,options){	

	ClientList_View.superclass.constructor.call(this,id,options);
	
	var model = new ClientList_Model({"data":options.modelDataStr});
	var contr = new Client_Controller(options.app);
	
	var constants = {"doc_per_page_count":null,"grid_refresh_interval":null};
	options.app.getConstantManager().get(constants);
	
	var popup_menu = new PopUpMenu();
	
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"keyIds":["id"],
		"controller":contr,
		"editInline":false,
		"editWinClass":Client_Form,
		"popUpMenu":popup_menu,
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"popUpMenu":popup_menu,
			"colTemplate":"ClientList",
			"app":options.app
		}),						
		/*
		"commands":new GridCommandsAjx(id+":grid:cmd",{
			"cmdFilter":true,
			"popUpMenu":popup_menu,
			"filters":{"name":{
					"binding":new CommandBinding({
						"control":new MaterialNameEdit(id+":filter-ctrl-name",{"app":options.app}),
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
						new GridCellHead(id+":grid:head:disc_card_percent",{
							"columns":[
								new GridColumn("disc_card_percent",{
									"field":model.getField("disc_card_percent"),
									//"format":"%%",
									"app":options.app})
							]
						})												
					]
				})
			]
		}),
		"pagination":new GridPagination(id+"_page",
			{"countPerPage":constants.doc_per_page_count.getValue(),"app":options.app}),		
		
		"autoRefresh":false,
		"refreshInterval":constants.grid_refresh_interval.getValue()*1000,
		"rowSelect":false,
		"focus":true,
		"app":options.app
	}));	
}
extend(ClientList_View,ViewAjx);
