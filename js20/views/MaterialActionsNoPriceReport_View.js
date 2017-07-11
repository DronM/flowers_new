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
function MaterialActionsNoPriceReport_View(id,options){

	options = options || {};
	
	options.templateId = "MaterialActionsNoPriceReport";
	
	MaterialActionsNoPriceReport_View.superclass.constructor.call(this, id, options);
	
}
extend(MaterialActionsNoPriceReport_View,MaterialActionsReport_View);
