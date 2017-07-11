/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function ExpenceType_View(id,options){	

	ExpenceType_View.superclass.constructor.call(this,id,options);
	
	var model = new ExpenceType_Model({"data":options.modelDataStr});
	var contr = new ExpenceType_Controller(options.app);
	
	var popup_menu = new PopUpMenu();
	
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"keyIds":["id"],
		"controller":contr,
		"editInline":true,
		"editWinClass":null,
		"commands":new GridCmdContainerAjx(id+"-gridcmd",{
			"popUpMenu":popup_menu,
			"colTemplate":"ExpenceType",
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
extend(ExpenceType_View,ViewAjx);
