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

function RepSaleForAcc_Controller(app,options){
	options = options || {};
	RepSaleForAcc_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.add_report();
		
}
extend(RepSaleForAcc_Controller,ControllerDb);

			RepSaleForAcc_Controller.prototype.add_report = function(){
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
												
			
}
									
		