/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function ProductBalanceList_View(id,options){	

	ProductBalanceList_View.superclass.constructor.call(this,id,options);
	
	var model = new ProductBalanceList_Model({"data":options.modelDataStr});
	var contr = new Product_Controller(options.app);
	
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"readPublicMethod":contr.getPublicMethod("get_list_with_balance"),
		"editInline":false,
		"editWinClass":Product_Form,
		"commands":new GridCommandsAjx(id+":grid:cmd",{
			"cmdInsert":false,
			"cmdEdit":false,
			"cmdDelete":false,
			"cmdFilter":true,
			"filters":{"name":{
					"binding":new CommandBinding({
						"control":new ProductNameEdit(id+":filter-ctrl-name",{"app":options.app}),
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
						new GridCellHead(id+":grid:head:code",{
							"columns":[
								new GridColumn({"field":model.getField("code")})
							],
							"sortable":true
						}),
					
						new GridCellHead(id+":grid:head:name",{
							"columns":[
								new GridColumn({"field":model.getField("name")})
							],
							"sortable":true,
							"sort":"asc"							
						}),
						new GridCellHead(id+":grid:head:price",{
							"colAttrs":{"align":"right"},
							"columns":[
								new GridColumnFloat({"field":model.getField("price")})
							],
							"sortable":true
						}),
						new GridCellHead(id+":grid:head:after_production_time",{
							"colAttrs":{"align":"center"},
							"columns":[
								new GridColumnCustomTime({"field":model.getField("after_production_time")})
							],
							"sortable":true
						})
						
					]
				})
			]
		}),
		"autoRefresh":false,
		"focus":true,
		"app":options.app
	}));	
	


}
extend(ProductBalanceList_View,ViewAjx);
