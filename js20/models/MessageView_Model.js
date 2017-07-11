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

function MessageView_Model(options){
	var id = 'MessageView_Model';
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
	filed_options.alias = 'Пользователь';options.fields.user_id = new FieldInt("user_id",filed_options);
				
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Время просмотра';options.fields.date_time = new FieldDateTime("date_time",filed_options);
	
																		
		MessageView_Model.superclass.constructor.call(this,id,options);
}
extend(MessageView_Model,ModelXML);

