/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
 * @requires core/extend.js
 * @requires core/ModelXML.js
*/

/* constructor
@param string id
@param object options{

}
*/

function User_Model(options){
	var id = 'User_Model';
	options = options || {};
	
	options.fields = {};
	
			
				
			
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	options.fields.id = new FieldInt("id",filed_options);
	options.fields.id.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.name = new FieldString("name",filed_options);
	options.fields.name.getValidator().setRequired(true);
	options.fields.name.getValidator().setMaxLength('50');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.role_id = new FieldEnum("role_id",filed_options);
	filed_options.enumValues = 'admin,store_manager,florist,cashier';
	options.fields.role_id.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.email = new FieldString("email",filed_options);
	options.fields.email.getValidator().setMaxLength('50');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.pwd = new FieldPassword("pwd",filed_options);
	options.fields.pwd.getValidator().setMaxLength('32');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.phone_cel = new FieldString("phone_cel",filed_options);
	options.fields.phone_cel.getValidator().setMaxLength('11');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Магазин';options.fields.store_id = new FieldInt("store_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Привязвывать к магазину';options.fields.constrain_to_store = new FieldBool("constrain_to_store",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.cash_register_id = new FieldInt("cash_register_id",filed_options);
	
						
		User_Model.superclass.constructor.call(this,id,options);
}
extend(User_Model,ModelXML);

