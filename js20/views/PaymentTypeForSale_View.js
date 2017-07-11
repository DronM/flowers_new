/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function PaymentTypeForSale_View(id,options){	

	PaymentTypeForSale_View.superclass.constructor.call(this,id,options);
	
	var model = new PaymentTypeForSale_Model({"data":options.modelDataStr});
	var contr = new PaymentTypeForSale_Controller(options.app);
	
	var constants = {"doc_per_page_count":null};
	options.app.getConstantManager().get(constants);
	
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
			"colTemplate":"PaymentTypeForSale",
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
						new GridCellHead(id+":grid:head:kkm_type_close",{
							"colAttrs":{"align":"center"},
							"columns":[
								new GridColumn("kkm_type_close",{"field":model.getField("kkm_type_close")})
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
extend(PaymentTypeForSale_View,ViewAjx);
