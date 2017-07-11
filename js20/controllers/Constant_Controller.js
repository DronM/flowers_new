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

function Constant_Controller(app,options){
	options = options || {};
	options.listModel = ConstantList_Model;
	options.objModel = ConstantList_Model;
	Constant_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.add_set_value();
	this.addGetList();
	this.addGetObject();
	this.add_get_values();
		
}
extend(Constant_Controller,ControllerDb);

			Constant_Controller.prototype.add_set_value = function(){
	var pm = new PublicMethod('set_value',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldString("id",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("val",options));
	
			
}

			Constant_Controller.prototype.addGetList = function(){
	Constant_Controller.superclass.addGetList.call(this);
	
	
	
	var pm = this.getGetList();
	var f_opts = {};
	
	pm.addField(new FieldString("id",f_opts));
	var f_opts = {};
	f_opts.alias = "Наименование";
	pm.addField(new FieldString("name",f_opts));
	var f_opts = {};
	f_opts.alias = "Описание";
	pm.addField(new FieldText("descr",f_opts));
	var f_opts = {};
	f_opts.alias = "Значение";
	pm.addField(new FieldText("val_descr",f_opts));
	var f_opts = {};
	f_opts.alias = "Имя значения";
	pm.addField(new FieldText("val_type",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("val_id",f_opts));
	pm.getField(this.PARAM_ORD_FIELDS).setValue("name");
	
}

			Constant_Controller.prototype.addGetObject = function(){
	Constant_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldString("id",f_opts));
}

			Constant_Controller.prototype.add_get_values = function(){
	var pm = new PublicMethod('get_values',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldString("id_list",options));
	
			
}

		