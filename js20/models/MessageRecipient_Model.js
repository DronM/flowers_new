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

function MessageRecipient_Model(options){
	var id = 'MessageRecipient_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	filed_options.alias = 'Код';options.fields.id = new FieldInt("id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Сообщение';options.fields.message_id = new FieldInt("message_id",filed_options);
	options.fields.message_id.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Магазин';options.fields.for_store_id = new FieldInt("for_store_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Роль';options.fields.for_role_id = new FieldEnum("for_role_id",filed_options);
	filed_options.enumValues = 'admin,store_manager,florist,cashier';
				
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Пользователь';options.fields.for_user_id = new FieldInt("for_user_id",filed_options);
				
															
		MessageRecipient_Model.superclass.constructor.call(this,id,options);
}
extend(MessageRecipient_Model,ModelXML);

