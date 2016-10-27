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
	
	filed_options.alias = 'Пользователь';
	
	var field = new FieldInt("user_id",filed_options);
	

	options.fields.user_id = field;
			
			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Время просмотра';
	
	var field = new FieldDateTime("date_time",filed_options);
	

	options.fields.date_time = field;

																		
		MessageView_Model.superclass.constructor.call(this,id,options);
}
extend(MessageView_Model,ModelXML);

