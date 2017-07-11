/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2017
 
 * @class
 * @classdesc controller
 
 * @requires ../core/extend.js
 * @requires ../core/ControllerDb.js 
  
 * @param {App} app - app instance
 * @param {namespase} options
 * @param {Model} options.listModel
 * @param {Model} options.objModel 
 */ 

function ReportVariant_Controller(app,options){
	options = options || {};
	options.objModel = ReportVariant_Model;
	ReportVariant_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.add_upsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
		
}
extend(ReportVariant_Controller,ControllerDb);

			ReportVariant_Controller.prototype.addInsert = function(){
	ReportVariant_Controller.superclass.addInsert.call(this);
	var field;
	
	var pm = this.getInsert();
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("user_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.required = true;	
	options.enumValues = 'material_actions,filter_variants';
	field = new FieldEnum("report_type",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldText("name",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldText("data",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			ReportVariant_Controller.prototype.add_upsert = function(){
	var pm = new PublicMethod('upsert',{controller:this});
	this.addPublicMethod(pm);
	
}

			ReportVariant_Controller.prototype.addUpdate = function(){
	ReportVariant_Controller.superclass.addUpdate.call(this);
	var field;	
	var pm = this.getUpdate();
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("user_id",options);
	
	pm.addField(field);
	
	var options = {};
		
	options.enumValues = 'material_actions,filter_variants';
	options.enumValues+= (options.enumValues=='')? '':',';
	options.enumValues+= 'null';
	
	field = new FieldEnum("report_type",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldText("name",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldText("data",options);
	
	pm.addField(field);
	
	
}

			ReportVariant_Controller.prototype.addDelete = function(){
	ReportVariant_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			ReportVariant_Controller.prototype.addGetList = function(){
	ReportVariant_Controller.superclass.addGetList.call(this);
	
	
	
	var pm = this.getGetList();
		var options = {};
		
			options.required = true;
						
		pm.addField(new FieldString("report_type",options));
	
		var options = {};
						
		pm.addField(new FieldString("name",options));
	
}

			ReportVariant_Controller.prototype.addGetObject = function(){
	ReportVariant_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
}

		