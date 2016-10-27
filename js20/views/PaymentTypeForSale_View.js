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
	
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"editInline":true,
		"editWinClass":null,
		"commands":new GridCommandsAjx(),
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
						new GridCellHead(id+":grid:head:kkm_type_close",{
							"colAttrs":{"align":"center"},
							"columns":[
								new GridColumn({"field":model.getField("kkm_type_close")})
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
extend(PaymentTypeForSale_View,ViewAjx);
