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

	MaterialList_View.superclass.constructor.call(this,id,options);
	
	var model = new MaterialList_Model({"data":options.modelDataStr});
	var contr = new Material_Controller(options.app);
	
	var constants = {"doc_per_page_count":null};
	options.app.getConstantManager().get(constants);
	
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"editInline":false,
		"editWinClass":Material_Form,
		"commands":new GridCommandsAjx(id+":grid:cmd",{
			"cmdFilter":true,
			"filters":{"name":{
					"binding":new CommandBinding({
						"control":new MaterialNameEdit(id+":filter-ctrl-name",{"app":options.app}),
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
						new GridCellHead(id+":grid:head:price",{
							"colAttrs":{"align":"right"},
							"columns":[
								new GridColumnFloat({"field":model.getField("price")})
							],
							"sortable":true
						}),
						new GridCellHead(id+":grid:head:for_sale",{
							"colAttrs":{"align":"center"},
							"columns":[
								new GridColumnBool({"field":model.getField("for_sale")})
							],
							"sortable":true
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
extend(MaterialList_View,ViewAjx);
