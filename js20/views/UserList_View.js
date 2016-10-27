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
	
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"editInline":false,
		"editWinClass":User_Form,
		//"onSelect":window.onSelect,
		//"multySelect":window.multySelect,
		"commands":new GridCommandsAjx(id+":grid:cmd",{
			"cmdFilter":true,
			"filters":{"name":{
					"binding":new CommandBinding({
						"control":new UserNameEdit(id+":filter-ctrl-name",{"app":options.app}),
						"field":new FieldString("name")}),
					"sign":"lk",
					"lwcards":true,
					"rwcards":true,
					"icase":true
					}
			},
			"app":options.app
		}),
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						new GridCellHead(id+":grid:head:name",{
							"columns":[
								new GridColumn({"field":model.getField("name")})
							],
							"sortable":true,
							"sort":"asc"							
						}),
						new GridCellHead(id+":grid:head:role",{
							"columns":[
								new GridColumn({"field":model.getField("role_descr")})
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
extend(UserList_View,ViewAjx);
