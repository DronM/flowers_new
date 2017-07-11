/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function MaterialList_View(id,options){	
	options = options || {};
	
	MaterialList_View.superclass.constructor.call(this,id,options);
	
	var model = new MaterialList_Model({"data":options.modelDataStr});
	var contr = new Material_Controller(options.app);
	
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
			"printObjList":contr.getPrintList(),
			"popUpMenu":popup_menu,
			"colTemplate":"MaterialList",			
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
						new GridCellHead(id+":grid:head:price",{
							"colAttrs":{"align":"right"},
							"columns":[
								new GridColumnFloat("price",{"field":model.getField("price")})
							],
							"sortable":true
						}),
						new GridCellHead(id+":grid:head:for_sale",{
							"colAttrs":{"align":"center"},
							"columns":[
								new GridColumnBool("for_sale",{"field":model.getField("for_sale")})
							],
							"sortable":true
						})
						
					]
				})
			]
		}),
		"pagination":new GridPagination(id+"_page",
			{"countPerPage":constants.doc_per_page_count.getValue(),"app":options.app}),		
		"refreshInterval":constants.grid_refresh_interval.getValue()*1000,
		"autoRefresh":false,
		"rowSelect":false,
		"focus":true,
		"app":options.app
	}));	
	


}
extend(MaterialList_View,ViewAjx);
