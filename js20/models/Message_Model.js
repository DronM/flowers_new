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
	
	filed_options.alias = 'Код';
	
	var field = new FieldInt("id",filed_options);
	

	options.fields.id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldEnum("message_type",filed_options);
	filed_options.enumValues = 'error,warning,info';
	
		field.getValidator().setRequired(true);
	

	options.fields.message_type = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Автор сообщения';
	
	var field = new FieldInt("user_id",filed_options);
	
		field.getValidator().setRequired(true);
	

	options.fields.user_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Требует отметки просмотра';
	
	var field = new FieldBoolean("require_view",filed_options);
	

	options.fields.require_view = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Тема';
	
	var field = new FieldText("subject",filed_options);
	
		field.getValidator().setRequired(true);
	

	options.fields.subject = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Содержание';
	
	var field = new FieldText("content",filed_options);
	

	options.fields.content = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Уровень важности';
	
	var field = new FieldInt("importance_level",filed_options);
	

	options.fields.importance_level = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Время создания';
	
	var field = new FieldDateTime("date_time",filed_options);
	

	options.fields.date_time = field;

									
												
		Message_Model.superclass.constructor.call(this,id,options);
}
extend(Message_Model,ModelXML);

