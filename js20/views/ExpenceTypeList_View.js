function ExpenceTypeList_View(id,options){
	options = options || {};
	
	ExpenceTypeList_View.superclass.constructor.call(this,id,options);
	
	var model = new ExpenceType_Model({"data":options.modelDataStr});
	var contr = new ExpenceType_Controller(options.app);
	
	var constants = {"doc_per_page_count":null,"grid_refresh_interval":null};
	options.app.getConstantManager().get(constants);
	
	var popup_menu = new PopUpMenu();
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"keyIds":["id"],
		"controller":contr,
		"editInline":false,
		"editWinClass":Material_Form,
		"popUpMenu":popup_menu,
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"popUpMenu":popup_menu,
			"printObjList":null,
			"filters":null,
			"colTemplate":"ExpenceTypeList",
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
		"refreshInterval":constants.grid_refresh_interval.getValue()*1000,
		"autoRefresh":false,
		"focus":true,
		"app":options.app
	}));	
	


}
extend(ExpenceTypeList_View,ViewAjx);
