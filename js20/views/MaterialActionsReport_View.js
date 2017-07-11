/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/

/** Requirements
 * @requires controls/ViewReport.js
*/

/* constructor */
function MaterialActionsReport_View(id,options){

	options = options || {};
	
	var contr = new Material_Controller(options.app);	
	options.publicMethod = contr.getPublicMethod("actions_report");
	options.reportViewId = "ViewHTMLXSLT";
	
	options.templateId = options.templateId || "MaterialActionsReport";
	
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
		},
		"material_group":{
			"binding":new CommandBinding({
				"control":new MaterialGroupRadio(id+":mat-groups",{"app":options.app}),
				"field":new FieldInt("material_group_id")}),
			"sign":"e"
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
	
	options.elements = [
		new SeqMaterialText(id+":sequence",{
			"data":options.modelDataStr,
			"app":options.app})
	];
	
	MaterialActionsReport_View.superclass.constructor.call(this, id, options);
	
}
extend(MaterialActionsReport_View,ViewReport);
