/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function SupplierList_View(id,options){	

	SupplierList_View.superclass.constructor.call(this,id,options);
	
	var model = new SupplierList_Model({"data":options.modelDataStr});
	var contr = new Supplier_Controller(options.app);
	
	var constants = {"doc_per_page_count":null};
	options.app.getConstantManager().get(constants);
	
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"editInline":false,
		"editWinClass":Supplier_Form,
		"onSelect":window.onSelect,
		"multySelect":window.multySelect,
		
		"commands":new GridCommandsAjx(id+":grid:cmd",{
			"cmdFilter":true,
			"filters":{"name":{
					"binding":new CommandBinding({
						"control":new SupplierNameEdit(id+":filter-ctrl-name",{"app":options.app}),
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
						new GridCellHead(id+":grid:head:tel",{
							"columns":[
								new GridColumnPhone({"field":model.getField("tel"),"app":options.app})
							]
						}),
						new GridCellHead(id+":grid:head:email",{
							"columns":[
								new GridColumn({"field":model.getField("email")})
							]
						})
						
					]
				})
			]
		}),
		"pagination":new GridPagination(id+"_page",
			{"countPerPage":constants.doc_per_page_count,"app":options.app}),		
		
		"autoRefresh":false,
		"focus":true,
		"app":options.app
	}));	
	


}
extend(SupplierList_View,ViewAjx);
