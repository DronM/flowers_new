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

function User_Controller(app,options){
	options = options || {};
	options.listModelId = "UserList_Model";
	options.objModelId = "UserDialog_Model";
	User_Controller.superclass.constructor.call(this,app,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.add_get_profile();
	this.addComplete();
	this.add_reset_pwd();
	this.add_login();
	this.add_login_refresh();
	this.add_logout();
	this.add_logout_html();
		
}
extend(User_Controller,ControllerDb);

			User_Controller.prototype.addInsert = function(){
	User_Controller.superclass.addInsert.call(this);
	var field;
	var options;
	
	var pm = this.getInsert();
	options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	options = {};
	options.required = true;
	var field = new FieldString("name",options);
	
	pm.addField(field);
	
	options = {};
	options.required = true;	
	options.enumValues = 'admin,store_manager,florist,cashier';
	field = new FieldEnum("role_id",options);
	
	pm.addField(field);
	
	options = {};
	
	var field = new FieldString("email",options);
	
	pm.addField(field);
	
	options = {};
	
	var field = new FieldPassword("pwd",options);
	
	pm.addField(field);
	
	options = {};
	
	var field = new FieldString("phone_cel",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Магазин";
	var field = new FieldInt("store_id",options);
	
	pm.addField(field);
	
	options = {};
	options.alias = "Привязвывать к магазину";
	var field = new FieldBool("constrain_to_store",options);
	
	pm.addField(field);
	
	options = {};
	
	var field = new FieldInt("cash_register_id",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			User_Controller.prototype.addUpdate = function(){
	User_Controller.superclass.addUpdate.call(this);
	var field;
	var options;	
	var pm = this.getUpdate();
	options = {"sendNulls":true};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	options = {"sendNulls":true};
	
	var field = new FieldString("name",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
		
	options.enumValues = 'admin,store_manager,florist,cashier';
	options.enumValues+= (options.enumValues=='')? '':',';
	options.enumValues+= 'null';
	
	field = new FieldEnum("role_id",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	
	var field = new FieldString("email",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	
	var field = new FieldPassword("pwd",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	
	var field = new FieldString("phone_cel",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Магазин";
	var field = new FieldInt("store_id",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	options.alias = "Привязвывать к магазину";
	var field = new FieldBool("constrain_to_store",options);
	
	pm.addField(field);
	
	
	options = {"sendNulls":true};
	
	var field = new FieldInt("cash_register_id",options);
	
	pm.addField(field);
	
	
	
}

			User_Controller.prototype.addDelete = function(){
	User_Controller.superclass.addDelete.call(this);
	var options = {"required":true};
	
	var pm = this.getDelete();
	pm.addField(new FieldInt("id",options));
}

			User_Controller.prototype.addGetList = function(){
	User_Controller.superclass.addGetList.call(this);
	var options = {};
	
	var pm = this.getGetList();
	pm.addField(new FieldInt("id",options));
	pm.addField(new FieldString("name",options));
	pm.addField(new FieldString("role_descr",options));
	pm.addField(new FieldString("phone_cel",options));
	pm.addField(new FieldBool("constrain_to_store",options));
	pm.addField(new FieldInt("store_id",options));
	pm.addField(new FieldString("store_descr",options));
}

			User_Controller.prototype.addGetObject = function(){
	User_Controller.superclass.addGetObject.call(this);
	var options = {};
	
	var pm = this.getGetObject();
	pm.addField(new FieldInt("id",options));
}

			User_Controller.prototype.add_get_profile = function(){
	var pm = new PublicMethod('get_profile',{controller:this});
	this.addPublicMethod(pm);
	
}

			User_Controller.prototype.addComplete = function(){
	User_Controller.superclass.addComplete.call(this);
	
	var options = {};
	
	var pm = this.getComplete();
	pm.addField(new FieldString("name",options));
	pm.getField(this.PARAM_ORD_FIELDS).setValue("name");
}

			User_Controller.prototype.add_reset_pwd = function(){
	var pm = new PublicMethod('reset_pwd',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldInt("user_id",options));
	
			
}

			User_Controller.prototype.add_login = function(){
	var pm = new PublicMethod('login',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.alias = "Имя пользователя";
	
		options.required = true;
	
		options.maxlength = "50";
	
		pm.addField(new FieldString("name",options));
	
				
	
	var options = {};
	
		options.alias = "Пароль";
	
		options.required = true;
	
		options.maxlength = "20";
	
		pm.addField(new FieldPassword("pwd",options));
	
			
}

			User_Controller.prototype.add_login_refresh = function(){
	var pm = new PublicMethod('login_refresh',{controller:this});
	this.addPublicMethod(pm);
	
				
	
	var options = {};
	
		options.required = true;
	
		options.maxlength = "50";
	
		pm.addField(new FieldString("refresh_token",options));
	
			
}
						
			User_Controller.prototype.add_logout = function(){
	var pm = new PublicMethod('logout',{controller:this});
	this.addPublicMethod(pm);
	
}

			User_Controller.prototype.add_logout_html = function(){
	var pm = new PublicMethod('logout_html',{controller:this});
	this.addPublicMethod(pm);
	
}

		