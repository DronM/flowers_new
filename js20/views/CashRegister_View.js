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
	
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"editInline":true,
		"editWinClass":null,
		"commands":new GridCommandsAjx(id+"-gridcmd",{"app":options.app}),
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						/*
						new GridCellHead(id+":grid:head:id",{
							"columns":[
								new GridColumn({"field":model.getField("id")})
							],
							"sortable":true
						}),
						*/
						new GridCellHead(id+":grid:head:name",{
							"columns":[
								new GridColumn({"field":model.getField("name")})
							],
							"sortable":true,
							"sort":"asc"							
						}),
						new GridCellHead(id+":grid:head:port",{
							"colAttrs":{"align":"center"},
							"columns":[
								new GridColumn({"field":model.getField("port")})
							]
						}),
						new GridCellHead(id+":grid:head:baud_rate",{
							"colAttrs":{"align":"center"},
							"columns":[
								new GridColumn({"field":model.getField("baud_rate")})
							]
						})
						
					]
				})
			]
		}),
		"pagination":null,		
		"autoRefresh":false,
		"focus":true,
		"app":options.app
	}));	
}
extend(CashRegister_View,ViewAjx);
