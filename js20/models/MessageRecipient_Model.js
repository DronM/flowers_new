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
	
	filed_options.alias = 'Код';
	
	var field = new FieldInt("id",filed_options);
	

	options.fields.id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Сообщение';
	
	var field = new FieldInt("message_id",filed_options);
	
		field.getValidator().setRequired(true);
	

	options.fields.message_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Магазин';
	
	var field = new FieldInt("for_store_id",filed_options);
	

	options.fields.for_store_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Роль';
	
	var field = new FieldEnum("for_role_id",filed_options);
	filed_options.enumValues = 'admin,store_manager,florist,cashier';
	

	options.fields.for_role_id = field;
			
			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Пользователь';
	
	var field = new FieldInt("for_user_id",filed_options);
	

	options.fields.for_user_id = field;
			
															
		MessageRecipient_Model.superclass.constructor.call(this,id,options);
}
extend(MessageRecipient_Model,ModelXML);

