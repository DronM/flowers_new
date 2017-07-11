/* Copyright (c) 2015 
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/

/** Requirements
 * @requires controls/ViewList.js
*/

/* constructor */
function CashRegisterOper_View(id,options){

	options = options || {};
	
	var cash_reg = options.app.getCachRegister();
	var obj_en = (cash_reg && cash_reg.getEnabled()==1);
	var self = this;
	
	options.elements = [
		//X отчет
		new ButtonCtrl(id+":repX",{
			"caption":this.BTN_REPX_CAP,
			"enabled":obj_en,
			"onClick":function(){
				var cash_reg = self.getApp().getCachRegister();
				if (cash_reg){
					cash_reg.printX({pwd:self.getApp().getCachierPwd()});
				}
			},
			"attrs":{"title":this.BTN_REPX_TITLE}
		}),

		//Z отчет
		new Button(id+":repZ",{
			"caption":this.BTN_REPZ_CAP,
			"enabled":obj_en,
			"onClick":function(){
				var cash_reg = self.getApp().getCachRegister();
				if (cash_reg){
					cash_reg.printZ({pwd:self.getApp().getCachierAdminPwd()});
				}			
			},
			"attrs":{"title":this.BTN_REPZ_TITLE}
		}),

		//Свойства
		new Button(id+":propPage",{
			"caption":this.BTN_PROP_CAP,
			"enabled":obj_en,
			"onClick":function(){
				var cash_reg = self.getApp().getCachRegister();
				if (cash_reg){
					cash_reg.printZ({pwd:self.getApp().getCachierPwd()});
				}			
			
			},
			"attrs":{"title":this.BTN_PROP_TITLE}
		})
	];
	
	CashRegisterOper_View.superclass.constructor.call(this,id,options);
}
extend(CashRegisterOper_View,View);
