function RepBalance_View(id,options){

	options = options || {};
	
	var contr = new RepBalance_Controller(options.app);	
	options.publicMethod = contr.getPublicMethod("balance");
	options.reportViewId = "ViewHTMLXSLT";
	options.templateId = "RepBalance";
	
	options.cmdMake = true;
	options.cmdPrint = true;
	options.cmdFilter = true;
	options.cmdExcel = false;
	options.cmdPdf = false;
	
	var multy_store = options.app.getServVars().multy_store;
	var period_ctrl = new EditPeriodDateTime(id+":filter-ctrl-period",{
		"app":options.app,
		"valueFrom":(options.templateParams)? options.templateParams.date_from:"",
		"valueTo":(options.templateParams)? options.templateParams.date_to:"",
		"field":new FieldDateTime("date_time"),
		"app":options.app
	});
	
	options.filters = {
		"period":{
			"binding":new CommandBinding({
				"control":period_ctrl,
				"field":period_ctrl.getField()
			}),
			"bindings":[
				{"binding":new CommandBinding({
					"control":period_ctrl.getControlFrom(),
					"field":period_ctrl.getField()
					}),
				"sign":"ge"
				},
				{"binding":new CommandBinding({
					"control":period_ctrl.getControlTo(),
					"field":period_ctrl.getField()
					}),
				"sign":"le"
				}
			]
		}
	};
	
	if (multy_store=="1"){
		filters.store = {
			"binding":new CommandBinding({
				"control":new StoreSelect(id+":filter-ctrl-store",{
					"keyIds":["store_id"],
					"app":options.app
					}),
				"field":new FieldInt("store_id")}),
			"sign":"e"
		};
	}
	
	
	RepBalance_View.superclass.constructor.call(this, id, options);
	
	/*	
	var filter = this.getFilter();
	var cd = new Date();
	var dt = DateHandler.getFirstDateOfMonth(cd.getFullYear(),cd.getMonth());
	filter.addFilterControl(new EditDateTime(id+"_date_from",
		{"attrs":{"required":"required"},
		"labelCaption":"Период с:",
		"value":DateHandler.dateToStr(dt,"dd/mm/y hh:mmin:ss")}),
		{"sign":"ge","valueFieldId":"date_time"}
		);	
	var dt = DateHandler.getLastDateOfMonth(cd.getFullYear(),cd.getMonth());
	filter.addFilterControl(new EditDateTime(id+"_date_to",
		{"attrs":{"required":"required"},
		"labelCaption":"по:",
		"value":DateHandler.dateToStr(dt,"dd/mm/y hh:mmin:ss")}),
		{"sign":"le","valueFieldId":"date_time"}
		);
	
	if (DEF_STORE_ID==null){
		filter.addFilterControl(new StoreEditObject(options.connect,"store_id","DOCSaleList_filter_store")
		,{"sign":"e","keyFieldIds":["store_id"]});
	}
	*/
}
extend(RepBalance_View,ViewReport);
