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

function RepBalance_Controller(app,options){
	options = options || {};
	RepBalance_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.add_balance();
		
}
extend(RepBalance_Controller,ControllerDb);

			RepBalance_Controller.prototype.add_balance = function(){
	var pm = new PublicMethod('balance',{controller:this});
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
									
		