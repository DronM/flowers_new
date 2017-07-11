/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function UserList_View(id,options){	

	UserList_View.superclass.constructor.call(this,id,options);
	
	var model = new UserList_Model({"data":options.modelDataStr});
	var contr = new User_Controller(options.app);
	
	var constants = {"grid_refresh_interval":null};
	options.app.getConstantManager().get(constants);
	
	var popup_menu = new PopUpMenu();
	
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"editInline":false,
		"editWinClass":User_Form,
		"keyIds":["id"],
		//"onSelect":window.onSelect,
		//"multySelect":window.multySelect,
		"popUpMenu":popup_menu,
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"popUpMenu":popup_menu,
			"colTemplate":"UserList",
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
						new GridCellHead(id+":grid:head:role",{
							"columns":[
								new GridColumn("role",{"field":model.getField("role_descr")})
							]
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
extend(UserList_View,ViewAjx);
