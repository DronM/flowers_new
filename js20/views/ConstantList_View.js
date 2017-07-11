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
	
	var popup_menu = new PopUpMenu();
	
	var ctrlColumnClasses = {
		"def_store":{
			"ctrlClass":StoreSelect,
			"ctrlOptions":{
				"labelCaption":"",
				"keyIds":["val_id"],
				"ctrlBindFieldId":"val_id"				
			}
		},
		"cel_phone_for_sms":{"ctrlClass":EditPhone,"columnClass":GridColumnPhone},
		"def_material_group":{"ctrlClass":MaterialGroupSelect},
		"def_payment_type_for_sale":{"ctrlClass":PaymentTypeForSaleSelect},
		"def_client":{"ctrlClass":ClientEditRef},
		"def_discount":{"ctrlClass":DiscountSelect}
	};			
	
	//
	this.addElement(new ConstantGrid(id+":grid",{
		"model":model,
		"controller":contr,
		"editInline":true,
		"editWinClass":null,
		"keyIds":["id"],		
		"commands":new GridCommandsAjx(id+"-gridcmd",{
			"cmdInsert":false,
			"cmdCopy":false,
			"cmdDelete":false,
			"popUpMenu":popup_menu,
			"app":options.app
		}),
		//"popUpMenu":popup_menu,
		
		"updatePublicMethod":contr.getPublicMethod("set_value"),
		"ctrlColumnClasses":ctrlColumnClasses,
		//"editViewClass":ConstantEditInlineAjx,
		"editViewOptions":{
			"ctrlColumnClasses":ctrlColumnClasses			
		},	
			
		"head":new GridHead(id+":grid:head",{
			"elements":[
				new GridRow(id+":grid:head:0",{
					"elements":[
						new GridCellHead(id+":grid:head:0:name",{
							"columns":[
								new GridColumn("name",{"field":model.getField("name"),
								"ctrlOptions":{
									"enabled":false,
									"cmdClear":false
									}
								})
							],
							"sortable":true,
							"sort":"asc"							
						}),
						new GridCellHead(id+":grid:head:0:descr",{
							"columns":[
								new GridColumn("descr",{"field":model.getField("descr"),
								"ctrlOptions":{
									"enabled":false,
									"cmdClear":false
									}
								})
							]
						}),
						new GridCellHead(id+":grid:head:0:val_descr",{
							"columns":[
								new GridColumn("val_descr",{"field":model.getField("val_descr")})
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
