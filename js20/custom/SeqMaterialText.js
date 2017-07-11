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
function SeqMaterialText(id,options){
	
	options.labelCaption = "Актуальность данных: ";
	options.cmdClear = false;
	options.enabled = false;
	options.contClassName = "form-group "+window.getBsCol(4);
	
	var self = this;
	
	options.buttonOpen = new ButtonCtrl(id+":show",{		
		"glyph":"glyphicon-pencil",
		"onClick":function(){
			self.show();
		},
		"app":options.app
	});
	
	options.buttonSelect = new ButtonCtrl(id+":ref",{		
		"glyph":"glyphicon-refresh",
		"onClick":function(){
			self.refresh();
		},
		"app":options.app
	});
	
	this.m_model = new ModelXML("SequenceViolList_Model",{
		"fields":{
			"doc_log_date_time":new FieldDateTime("doc_log_date_time")
		},
		"data":options.data
	});
		
	SeqMaterialText.superclass.constructor.call(this,id,options);
	
	this.refreshValue();
}
extend(SeqMaterialText,EditDateTime);

/* Constants */


/* private members */

/* protected*/


/* public methods */

SeqMaterialText.prototype.refreshValue = function(){
	if (this.m_model.getRowCount()){
		this.m_model.getRow(0);
		this.setValue(this.m_model.getFieldValue("doc_log_date_time"));
	}

}

SeqMaterialText.prototype.refresh = function(){
	var contr = new DOCManager_Controller(this.getApp());
	var pm = contr.getPublicMethod("get_sequence_viol_list");
	pm.setFieldValue("sequence_list","materials");
	
	var self = this;
	pm.run({
		"ok":function(resp){
			self.m_model.setData(resp.getModelData(self.m_model.getId()));			
			self.refreshValue();
		}
	});
}

SeqMaterialText.prototype.show = function(){
	window.showNote("Пока не реализовано.");
}
