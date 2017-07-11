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

function RepSalesOnTypes_Controller(app,options){
	options = options || {};
	RepSalesOnTypes_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addGetObject();
	this.add_report();
		
}
extend(RepSalesOnTypes_Controller,ControllerDb);

			RepSalesOnTypes_Controller.prototype.addGetObject = function(){
	RepSalesOnTypes_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
}

			RepSalesOnTypes_Controller.prototype.add_report = function(){
	var pm = new PublicMethod('report',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		pm.addField(new FieldString("cond_fields",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("cond_vals",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("cond_sgns",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("cond_ic",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("templ",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("ord_fields",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("ord_directs",options));
					
				
	
	var options = {};
	
		pm.addField(new FieldString("field_sep",options));
	
			
}
									
		