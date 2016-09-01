/* Copyright (c) 2016
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
*/

/* constructor */
function Login_View(id,options){	

	Login_View.superclass.constructor.call(this,id,options);
	
	var self = this;
	
	this.addElement(new ErrorControl(id+":error",{"app":options.app}));
	
	this.addElement(new EditString(id+":user",{				
		"placeholder":"Пользователь (email)",
		"editContClassName":"form-group",
		"focus":true,
		"noClear":true,
		"app":options.app
	}));	
	
	this.addElement(new EditPassword(id+":pwd",{
		"placeholder":"Пароль",
		"editContClassName":"form-group",
		"app":options.app
	}));	

	this.addElement(new Button(id+":submit_login",{
		"caption":"Войти",
		"className":"btn btn-lg btn-success btn-block",
		"onClick":function(){
			self.execCommand("login",function(){
				document.location.href = self.getApp().getHost();
			},
			function(resp,errCode,errStr){
				if (errCode==100){
					self.setError("Неправильный логин или пароль.");
				}
				else{
					self.setError(errCode+" "+errStr);
				}
			}
			);
		},
		"app":options.app
	}));
	
	//Commands
	var contr = new User_Controller(options.app);
	var pm = contr.getPublicMethod("login");
	
	this.addCommand(new Command("login",{
		"publicMethod":pm,
		"control":this.getElement("submit_login"),
		"async":true,
		"bindings":[
			new DataBinding({"field":pm.getField("name"),"control":this.getElement("user")}),
			new DataBinding({"field":pm.getField("pwd"),"control":this.getElement("pwd")})
		]		
	}));

}
extend(Login_View,ViewAjx);

Login_View.prototype.setError = function(s){
	this.getElement("error").setValue(s);
}
