/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function DiscountList_View(id,options){	

	DiscountList_View.superclass.constructor.call(this,id,options);
	
	var model = new Discount_Model({"data":options.modelDataStr});
	var contr = new Discount_Controller(options.app);
	
	var constants = {"grid_refresh_interval":null};
	options.app.getConstantManager().get(constants);
	
	var popup_menu = new PopUpMenu();
	
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"keyIds":["id"],
		"controller":contr,
		"editInline":true,
		"editWinClass":null,
		"popUpMenu":popup_menu,
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"popUpMenu":popup_menu,
			"colTemplate":"DiscountList",
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
							"sortable":true
						}),
						new GridCellHead(id+":grid:head:percent",{
							"columns":[
								new GridColumn("percent",{"field":model.getField("percent")})								
							],
							"sortable":true,
							"sort":"asc"
						})						
					]
				})
			]
		}),
		"pagination":null,				
		"autoRefresh":false,
		"refreshInterval":constants.grid_refresh_interval.getValue()*1000,
		"rowSelect":false,
		"focus":true,
		"app":options.app
	}));	
}
extend(DiscountList_View,ViewAjx);
