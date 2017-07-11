/* Copyright (c) 2016 
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
 * @requires 
 * @requires core/extend.js  
*/

/* constructor
@param string id
@param object options{

}
*/
function ReceiptPayTypeAddBtn(id,options){
	options = options || {};	
	
	options.className = "btn dropdown";

	this.m_button = new ControlContainer(CommonHelper.uniqid(),"button",{
		"className":"btn btn-default dropdown-toggle",
		"title":"Добавить тип оплаты",
		"attrs":{
			"type":"button",
			"data-toggle":"dropdown"
		},
		"elements":[new Control(CommonHelper.uniqid(),"i",{"className":"glyphicon glyphicon-plus"})]
		
	});
	
	this.m_model = options.model;
	this.m_pm = options.pm;
	this.m_refresh = options.refresh;
	
	var ctrls = [];
	
	var self = this;
	
	while(this.m_model.getNextRow()){
		var e_pref = id+":"+this.m_model.getFieldValue("id")+":";
		ctrls.push(
			new ControlContainer(e_pref+"cont","li",{
			"elements":[
				new Control(e_pref+"cont:a","a",{
					"value":this.m_model.getFieldValue("name"),
					"events":{
						"click":function(e){							
							self.m_pm.setFieldValue("payment_type_for_sale_id",e.target.getAttribute("payTypeId"));
							self.m_pm.run({
								"async":true,
								"ok":function(){
									self.m_refresh();
								}
							});
							//alert("!!!");
							//self.onClick();
						}
					},
					"attrs":{
						"href":"#",
						"role":"menuitem",
						"payTypeId":this.m_model.getFieldValue("id")
					}
				})
			]
			})
		
		);		
	}
	
	this.m_buttons = new ControlContainer(CommonHelper.uniqid(),"ul",{
		"className":"dropdown-menu",
		"elements":ctrls
	});
	
	options.elements = [this.m_button,this.m_buttons];
	
	ReceiptPayTypeAddBtn.superclass.constructor.call(this,id,"div",options);
}
extend(ReceiptPayTypeAddBtn,ControlContainer);

/* Constants */


/* private members */

/* protected*/


/* public methods */

