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
	
	var check_for_enter = function(e){
		e = EventHelper.fixKeyEvent(e);
		if (e.keyCode==13){
			self.login();
		}
	};
					
	this.addElement(new EditString(id+":user",{				
		"placeholder":this.CTRL_USER_LAB[options.app.getLang()],
		"editContClassName":"form-group",
		"focus":true,
		"cmdClear":false,
		"events":{"keydown":check_for_enter},
		"app":options.app
	}));	
	
	this.addElement(new EditPassword(id+":pwd",{
		"placeholder":this.CTRL_PWD_LAB[options.app.getLang()],
		"editContClassName":"form-group",
		"events":{"keydown":check_for_enter},
		"app":options.app
	}));	

	this.addElement(new Button(id+":submit_login",{
		"onClick":function(){
			self.login();
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

Login_View.prototype.login = function(){
	var self = this;
	this.execCommand("login",function(){
		document.location.href = self.getApp().getHost();
	},
	function(resp,errCode,errStr){
		if (errCode==100){
			self.setError(self.ER_LOGIN[self.getApp().getLang()]);
		}
		else{
			self.setError(errCode+" "+errStr);
		}
	}
	);
}
