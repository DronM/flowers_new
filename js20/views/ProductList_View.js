/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function ProductList_View(id,options){	

	ProductList_View.superclass.constructor.call(this,id,options);
	
	var model = new ProductList_Model({"data":options.modelDataStr});
	var contr = new Product_Controller(options.app);

	var constants = {"grid_refresh_interval":null,"doc_per_page_count":0};
	options.app.getConstantManager().get(constants);
	
	var popup_menu = new PopUpMenu();
	
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"editInline":false,
		"editWinClass":Product_Form,
		"popUpMenu":popup_menu,
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"popUpMenu":popup_menu,
			"colTemplate":"ProductList",
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
		"autoRefresh":false,
		"refreshInterval":constants.grid_refresh_interval.getValue()*1000,
		"pagination":new GridPagination(id+"_page",
			{"countPerPage":constants.doc_per_page_count,"app":options.app}),				
		"rowSelect":false,
		"focus":true,
		"app":options.app
	}));	
	


}
extend(ProductList_View,ViewAjx);
