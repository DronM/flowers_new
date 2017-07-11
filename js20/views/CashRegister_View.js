/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function CashRegister_View(id,options){	

	CashRegister_View.superclass.constructor.call(this,id,options);
	
	var model = new CashRegister_Model({"data":options.modelDataStr});
	var contr = new CashRegister_Controller(options.app);
	
	var popup_menu = new PopUpMenu();
	
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"keyIds":["id"],
		"editInline":true,
		"editWinClass":null,
		"popUpMenu":popup_menu,
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"popUpMenu":popup_menu,
			"colTemplate":"CashRegister",
			"app":options.app
		}),				
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
						/*
						new GridCellHead(id+":grid:head:port",{
							"colAttrs":{"align":"center"},
							"columns":[
								new GridColumn("port",{"field":model.getField("port")})
							]
						}),
						new GridCellHead(id+":grid:head:baud_rate",{
							"colAttrs":{"align":"center"},
							"columns":[
								new GridColumn("baud_rate",{"field":model.getField("baud_rate")})
							]
						}),
						*/
						new GridCellHead(id+":grid:head:eq_server",{
							"columns":[
								new GridColumn("eq_server",{"field":model.getField("eq_server")})
							]
						}),
						new GridCellHead(id+":grid:head:eq_port",{
							"columns":[
								new GridColumn("eq_port",{"field":model.getField("eq_port")})
							]
						}),
						new GridCellHead(id+":grid:head:eq_id",{
							"columns":[
								new GridColumn("eq_id",{"field":model.getField("eq_id")})
							]
						})
						
					]
				})
			]
		}),
		"pagination":null,		
		"autoRefresh":false,
		"rowSelect":false,
		"focus":true,
		"app":options.app
	}));	
}
extend(CashRegister_View,ViewAjx);
