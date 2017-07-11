function DOCClientOrderGridCommand(id,options){
	options = options || {};	
	
	options.template = options.app.getTemplate("DOCClientOrderGridCommand");
	
	DOCClientOrderGridCommand.superclass.constructor.call(this,id,options);
}
extend(DOCClientOrderGridCommand,GridCmdContainerDOC);

/* Constants */


/* private members */

/* protected*/


/* public methods */
DOCClientOrderGridCommand.prototype.addCommands = function(){
	
	this.m_cmdInsert.setShowCmdControlInPopup(false);
	this.m_cmdEdit.setShowCmdControlInPopup(false);
	this.m_cmdCopy.setShowCmdControlInPopup(false);
	this.m_cmdDelete.setShowCmdControlInPopup(false);
	this.m_cmdRefresh.setShowCmdControlInPopup(false);
	this.m_cmdPrint.setShowCmdControlInPopup(false);
	this.m_cmdPrintObj.setShowCmdControlInPopup(false);
	this.m_cmdSearch.setShowCmdControlInPopup(false);
	this.m_cmdColManager.setShowCmdControlInPopup(false);
	this.m_cmdFilter.setShowCmdControlInPopup(false);
	this.m_cmdExport.setShowCmdControlInPopup(false);
	this.m_cmdDOCUnprocess.setShowCmdControlInPopup(false);
	this.m_cmdDOCShowActs.setShowCmdControlInPopup(false);
	
	DOCClientOrderGridCommand.superclass.addCommands.call(this);

	var self = this;
	
	var id = this.getId();
	
	this.m_commands.push(new GridCmd(id+"cmdStatChecked",{
		"caption":"Проверен",
		"onCommand":function(){
			self.setState('checked');
		}
	}));
	
	this.m_commands.push(new GridCmd(id+"cmdStatToFlorist",{
		"caption":"Составлен",
		"onCommand":function(){
			self.setState('to_florist');
		}
	}));

	this.m_commands.push(new GridCmd(id+"cmdStatToCourier",{
		"caption":"Забрал курьер",
		"onCommand":function(){
			self.setState('to_courier');
		}
	}));

	this.m_commands.push(new GridCmd(id+"cmdStatClosed",{
		"caption":"Закрыть",
		"onCommand":function(){
			self.setState('closed');
		}
	}));

	this.m_commands.push(new GridCmd(id+"cmdStatPayed",{
		"caption":"Оплатить",
		"onCommand":function(){
			self.setPayed();
		}
	}));
	
}

/*
DOCClientOrderGridCommand.prototype.addControls = function(){
	DOCClientOrderGridCommand.superclass.addControls.call(this);
	
	var self = this;
	
	this.addElement(new ButtonCmd(this.getId()+":btnChecked",{
		"caption":"Проверен",
		"onClick":function(){
			self.setState('checked');
		}
	}));
	
	this.addElement(new ButtonCmd(this.getId()+":btnToFlorist",{
		"caption":"Составлен",
		"onClick":function(){
			self.setState('to_florist');
		}
	}));
	
	this.addElement(new ButtonCmd(this.getId()+":btnToCourier",{
		"caption":"Забрал курьер",
		"onClick":function(){
			self.setState('to_courier');
		}
	}));
	this.addElement(new ButtonCmd(this.getId()+":btnClosed",{
		"caption":"Закрыть",
		"onClick":function(){
			self.setState('closed');
		}
	}));
	this.addElement(new ButtonCmd(this.getId()+":btnPayed",{
		"caption":"Оплатить",
		"onClick":function(){
			self.setPayed();
		}
	}));
	
}
*/

DOCClientOrderGridCommand.prototype.setState = function(state){
	var contr = new DOCClientOrder_Controller(this.getApp());
	var pm = contr.getPublicMethod("set_state");
	var g = this.m_grid;
	var r = g.getModelRow();
	if (r && r["id"]){
		var doc_id = r["id"].getValue();
		var self = this;
		pm.setFieldValue("doc_id",doc_id);
		pm.setFieldValue("state",state);
		pm.run({
			"ok":function(resp){
				self.m_grid.onRefresh();
				window.showNote("Изменен статус документа.");
			}
		});
	}
}
DOCClientOrderGridCommand.prototype.setPayed = function(){
	var contr = new DOCClientOrder_Controller(this.getApp());
	var pm = contr.getPublicMethod("set_payed");
	var g = this.m_grid;
	var r = g.getModelRow();
	console.log("Row="+r)
	if (r && r["id"]){
		var doc_id = r["id"].getValue();
		var self = this;
		pm.setFieldValue("doc_id",doc_id);
		pm.run({
			"ok":function(resp){
				self.m_grid.onRefresh();
				window.showNote("Установлен признак оплаты документа.");
			}
		});
	}
}
