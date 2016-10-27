/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
 * @requires core/extend.js
 * @requires core/ControllerDb.js
*/

/* constructor
@param string id
@param object options{

}
*/

function ReportVariant_Controller(app,options){
	options = options || {};
	options.objModelId = "ReportVariant_Model";
	ReportVariant_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
		
}
extend(ReportVariant_Controller,ControllerDb);

			ReportVariant_Controller.prototype.addInsert = function(){
	ReportVariant_Controller.superclass.addInsert.call(this);
	var field;
	var options;
	
	var pm = this.getInsert();
	options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	options = {};
	
	var field = new FieldInt("user_id",options);
	
	pm.addField(field);
	
	options = {};
	options.required = true;	
	options.enumValues = 'material_actions';
	field = new FieldEnum("report_type",options);
	
	pm.addField(field);
	
	options = {};
	
	var field = new FieldText("name",options);
	
	pm.addField(field);
	
	options = {};
	
	var field = new FieldText("data",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			ReportVariant_Controller.prototype.addUpdate = function(){
	ReportVariant_Controller.superclass.addUpdate.call(this);
	var field;
	var options;	
	var pm = this.getUpdate();
	options = {"sendNulls":true};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	options = {"sendNulls":true};
	
	var field = new FieldInt("user_id",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
		
	options.enumValues = 'material_actions';
	options.enumValues+= (options.enumValues=='')? '':',';
	options.enumValues+= 'null';
	
	field = new FieldEnum("report_type",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	
	var field = new FieldText("name",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	
	var field = new FieldText("data",options);
	
	pm.addField(field);
	
	
	
}

			ReportVariant_Controller.prototype.addDelete = function(){
	ReportVariant_Controller.superclass.addDelete.call(this);
	var options = {"required":true};
	
	var pm = this.getDelete();
	pm.addField(new FieldInt("id",options));
}

			ReportVariant_Controller.prototype.addGetList = function(){
	ReportVariant_Controller.superclass.addGetList.call(this);
	var options = {};
	
	var pm = this.getGetList();
		var options = {};
		
			options.required = true;
						
		pm.addField(new FieldString("report_type",options));
	
}

			ReportVariant_Controller.prototype.addGetObject = function(){
	ReportVariant_Controller.superclass.addGetObject.call(this);
	var options = {};
	
	var pm = this.getGetObject();
	pm.addField(new FieldInt("id",options));
}

		