/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function ConstantList_View(id,options){	

	ConstantList_View.superclass.constructor.call(this,id,options);
	
	var model = new ConstantList_Model({"data":options.modelDataStr});
	var contr = new Constant_Controller(options.app);
	
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"editInline":true,
		"editWinClass":null,
		"commands":new GridCommandsAjx(id+"-gridcmd",{"app":options.app}),
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
						new GridCellHead(id+":grid:head:descr",{
							"columns":[
								new GridColumn({"field":model.getField("descr")})
							]
						}),
						new GridCellHead(id+":grid:head:val_descr",{
							"columns":[
								new GridColumn({"field":model.getField("val_descr")})
							]
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
extend(ConstantList_View,ViewAjx);
