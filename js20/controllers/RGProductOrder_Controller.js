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

function RGProductOrder_Controller(app,options){
	options = options || {};
	RGProductOrder_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.add_get_balance();
		
}
extend(RGProductOrder_Controller,ControllerDb);

			RGProductOrder_Controller.prototype.add_get_balance = function(){
	var pm = new PublicMethod('get_balance',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldString("cond_fields",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldString("cond_vals",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldString("cond_sgns",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("cond_ic",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("ord_fields",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldString("ord_directs",options));
												
			
}

		