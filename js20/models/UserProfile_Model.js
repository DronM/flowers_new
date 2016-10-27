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

function UserProfile_Model(options){
	var id = 'UserProfile_Model';
	options = options || {};
	
	options.fields = {};
	
			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	filed_options.alias = 'Код';
	
	var field = new FieldInt("id",filed_options);
	

	options.fields.id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Имя';
	
	var field = new FieldString("name",filed_options);
	

	options.fields.name = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Эл.почта';
	
	var field = new FieldString("email",filed_options);
	

	options.fields.email = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Моб.телефон';
	
	var field = new FieldString("phone_cel",filed_options);
	
		field.getValidator().setMaxLength('11');
	

	options.fields.phone_cel = field;

		UserProfile_Model.superclass.constructor.call(this,id,options);
}
extend(UserProfile_Model,ModelXML);

