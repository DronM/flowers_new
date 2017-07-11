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

function Message_Model(options){
	var id = 'Message_Model';
	options = options || {};
	
	options.fields = {};
	
			
				
							
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	filed_options.alias = 'Код';options.fields.id = new FieldInt("id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.message_type = new FieldEnum("message_type",filed_options);
	filed_options.enumValues = 'error,warning,info';
	options.fields.message_type.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Автор сообщения';options.fields.user_id = new FieldInt("user_id",filed_options);
	options.fields.user_id.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Требует отметки просмотра';options.fields.require_view = new FieldBool("require_view",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Тема';options.fields.subject = new FieldText("subject",filed_options);
	options.fields.subject.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Содержание';options.fields.content = new FieldText("content",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Уровень важности';options.fields.importance_level = new FieldInt("importance_level",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Время создания';options.fields.date_time = new FieldDateTime("date_time",filed_options);
	
									
												
		Message_Model.superclass.constructor.call(this,id,options);
}
extend(Message_Model,ModelXML);

