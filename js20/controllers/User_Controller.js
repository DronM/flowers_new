/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2017
 
 * @class
 * @classdesc controller
 
 * @requires ../core/extend.js
 * @requires ../core/ControllerDb.js 
  
 * @param {App} app - app instance
 * @param {namespase} options
 * @param {Model} options.listModel
 * @param {Model} options.objModel 
 */ 

function User_Controller(app,options){
	options = options || {};
	options.listModel = UserList_Model;
	options.objModel = UserDialog_Model;
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
	
	var pm = this.getInsert();
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	options.required = true;
	var field = new FieldString("name",options);
	
	pm.addField(field);
	
	var options = {};
	options.required = true;	
	options.enumValues = 'admin,store_manager,florist,cashier';
	field = new FieldEnum("role_id",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldString("email",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldPassword("pwd",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldString("phone_cel",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Магазин";
	var field = new FieldInt("store_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Привязвывать к магазину";
	var field = new FieldBool("constrain_to_store",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("cash_register_id",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			User_Controller.prototype.addUpdate = function(){
	User_Controller.superclass.addUpdate.call(this);
	var field;	
	var pm = this.getUpdate();
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldString("name",options);
	
	pm.addField(field);
	
	var options = {};
		
	options.enumValues = 'admin,store_manager,florist,cashier';
	options.enumValues+= (options.enumValues=='')? '':',';
	options.enumValues+= 'null';
	
	field = new FieldEnum("role_id",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldString("email",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldPassword("pwd",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldString("phone_cel",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Магазин";
	var field = new FieldInt("store_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.alias = "Привязвывать к магазину";
	var field = new FieldBool("constrain_to_store",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("cash_register_id",options);
	
	pm.addField(field);
	
	
}

			User_Controller.prototype.addDelete = function(){
	User_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			User_Controller.prototype.addGetList = function(){
	User_Controller.superclass.addGetList.call(this);
	
	
	
	var pm = this.getGetList();
	var f_opts = {};
	
	pm.addField(new FieldInt("id",f_opts));
	var f_opts = {};
	f_opts.alias = "Имя";
	pm.addField(new FieldString("name",f_opts));
	var f_opts = {};
	f_opts.alias = "Роль";
	pm.addField(new FieldString("role_descr",f_opts));
	var f_opts = {};
	f_opts.alias = "Моб.телефон";
	pm.addField(new FieldString("phone_cel",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldBool("constrain_to_store",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("store_id",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldString("store_descr",f_opts));
}

			User_Controller.prototype.addGetObject = function(){
	User_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
	f_opts.alias = "Код";	
	pm.addField(new FieldInt("id",f_opts));
}

			User_Controller.prototype.add_get_profile = function(){
	var pm = new PublicMethod('get_profile',{controller:this});
	this.addPublicMethod(pm);
	
}

			User_Controller.prototype.addComplete = function(){
	User_Controller.superclass.addComplete.call(this);
	
	var f_opts = {};
	f_opts.alias = "";
	var pm = this.getComplete();
	pm.addField(new FieldString("name",f_opts));
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

		