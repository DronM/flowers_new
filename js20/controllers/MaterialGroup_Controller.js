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

function MaterialGroup_Controller(app,options){
	options = options || {};
	options.listModelId = "MaterialGroup_Model";
	options.objModelId = "MaterialGroup_Model";
	MaterialGroup_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.addComplete();
	this.add_get_list_for_florist();
		
}
extend(MaterialGroup_Controller,ControllerDb);

			MaterialGroup_Controller.prototype.addInsert = function(){
	MaterialGroup_Controller.superclass.addInsert.call(this);
	var field;
	var options;
	
	var pm = this.getInsert();
	options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Наименование";options.required = true;
	var field = new FieldString("name",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Для флориста";
	var field = new FieldBool("for_florist",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			MaterialGroup_Controller.prototype.addUpdate = function(){
	MaterialGroup_Controller.superclass.addUpdate.call(this);
	var field;
	var options;	
	var pm = this.getUpdate();
	options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	options = {};
	options.alias = "Наименование";options.required = true;
	var field = new FieldString("name",options);
	
	pm.addField(field);
	
	
	options = {};
	options.alias = "Для флориста";
	var field = new FieldBool("for_florist",options);
	
	pm.addField(field);
	
	
	
}

			MaterialGroup_Controller.prototype.addDelete = function(){
	MaterialGroup_Controller.superclass.addDelete.call(this);
	var options = {"required":true};
	
	var pm = this.getDelete();
	pm.addField(new FieldInt("id",options));
}

			MaterialGroup_Controller.prototype.addGetList = function(){
	MaterialGroup_Controller.superclass.addGetList.call(this);
	var options = {};
	
	var pm = this.getGetList();
	pm.addField(new FieldInt("id",options));
	pm.addField(new FieldString("name",options));
	pm.addField(new FieldBool("for_florist",options));
	pm.getField(this.PARAM_ORD_FIELDS).setValue("name");
	
}

			MaterialGroup_Controller.prototype.addGetObject = function(){
	MaterialGroup_Controller.superclass.addGetObject.call(this);
	var options = {};
	
	var pm = this.getGetObject();
	pm.addField(new FieldInt("id",options));
}

			MaterialGroup_Controller.prototype.addComplete = function(){
	MaterialGroup_Controller.superclass.addComplete.call(this);
	
	var options = {};
	
	var pm = this.getComplete();
	pm.addField(new FieldString("name",options));
	pm.getField(this.PARAM_ORD_FIELDS).setValue("name");
}

			MaterialGroup_Controller.prototype.add_get_list_for_florist = function(){
	var pm = new PublicMethod('get_list_for_florist',{controller:this});
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
	
		pm.addField(new FieldInt("from",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("count",options));
				
				
	
	var options = {};
	
		pm.addField(new FieldString("ord_fields",options));
				
				
	
	var options = {};
	
		pm.addField(new FieldString("ord_directs",options));
											
			
}

		