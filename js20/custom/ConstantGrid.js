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
function ConstantGrid(id,options){
	options = options || {};	
	
	this.m_ctrlColumnClasses = options.ctrlColumnClasses;
	
	ConstantGrid.superclass.constructor.call(this,id,options);
}
extend(ConstantGrid,GridAjx);

/* Constants */


/* private members */
ConstantGrid.prototype.m_ctrlColumnClasses;

/* protected*/


/* public methods */
ConstantGrid.prototype.onGetData = function(resp){
	if(resp){
		this.m_model.setData(resp.getModelData(this.m_model.getId()));
	}
	
	if (this.m_model){
		//refresh from model
		var self = this;
		var body = this.getBody();
		var foot = this.getFoot();
		body.delDOM();
		body.clear();
	
		if (foot && foot.calcBegin){	
			this.m_foot.calcBegin();
		}
	
		if (!this.getHead())return;
		
		var columns = this.getHead().getColumns();
		//var temp_input;
		
		var row_cnt = 0, field_cnt;
		var row,row_keys;
		this.m_model.reset();
	
		var pag = this.getPagination();
		if (pag){
			pag.setCountTotal(this.m_model.getTotCount());
		}
	
		while(this.m_model.getNextRow()){
			var row_id = this.getId()+":body:"+row_cnt;
			var row_class = (row_cnt%2==0)? "even":"odd";
			if (this.m_onSelect){
				row_class+=" for_select";
			}
			if (this.m_onEventSetRowClass){
				this.m_onEventSetRowClass(this.m_model,row_class);
			}
		
			var r_class = this.getRowClass();
			var row_opts = {"className":row_class,"app":this.getApp()};
			/*
			if (this.m_onSelect){
				row_opts.events = row_opts.events || {};
				row_opts.events.click = function(){
					self.m_onSelect();
				}
			}
			*/
			row = new r_class(row_id,row_opts);
		
			row_keys = {};
			for(var k=0;k<this.m_keyIds.length;k++){
				if (this.m_model.fieldExists(this.m_keyIds[k])){
					row_keys[this.m_keyIds[k]] = this.m_model.getFieldValue(this.m_keyIds[k]);
				}
			}
			
			//ADDED
			var column_class;
			var ctrlClass;
			var ctrlOptions = {"app":this.getApp()};
			var val_type = this.m_model.getFieldValue("val_type");
			var const_id = this.m_model.getFieldValue("id");
			if (this.m_ctrlColumnClasses[const_id]){
				if (this.m_ctrlColumnClasses[const_id].ctrlClass){
					ctrlClass = this.m_ctrlColumnClasses[const_id].ctrlClass;
				}
				else{
					ctrlClass = EditString;
				}
				if (this.m_ctrlColumnClasses[const_id].columnClass){
					column_class = this.m_ctrlColumnClasses[const_id].columnClass;
				}
				else{
					column_class = GridColumn;
				}				
				if (this.m_ctrlColumnClasses[const_id].ctrlOptions){
					CommonHelper.merge(ctrlOptions,this.m_ctrlColumnClasses[const_id].ctrlOptions);
				}				
			}
			else{
				if (val_type=="Bool"){
					column_class = GridColumnBool;
					ctrlClass = EditCheckBox;
				}
				else if (val_type=="Date"){
					column_class = GridColumnDate;
					ctrlClass = EditDate;
				}
				else if (val_type=="DateTime"){
					column_class = GridColumnDateTime;
					ctrlClass = EditDateTime;
				}
				else if (val_type=="Interval"){
					column_class = GridColumn;
					ctrlClass = EditTime;
				}				
				else if (val_type=="Float"){
					column_class = GridColumnFloat;					
					ctrlClass = EditFloat;
				}				
				else if (val_type=="Int"){
					column_class = GridColumn;					
					ctrlClass = EditInt;
				}								
				else{
					column_class = GridColumn;
					ctrlClass = EditString;
				}							
			}
			//ADDED
			
			
			field_cnt = 0;
			for (var col_id in columns){
				columns[col_id].setGrid(this);

				if (columns[col_id].getField() && columns[col_id].getField().getPrimaryKey()){
					row_keys[col_id] = columns[col_id].getField().getValue();
				}
				
				var cell_class = columns[col_id].getCellClass();
								
				var cell_opts = columns[col_id].getCellOptions() || {};
				cell_opts.modelIndex = row_cnt;
				cell_opts.row = row;
								
				//ADDED
				if (col_id=="val_descr"){
					cell_opts.gridColumn = new column_class({
						"field":columns[col_id].getField(),
						"headCell":columns[col_id].getHeadCell(),
						"ctrlClass":ctrlClass,
						"ctrlOptions":ctrlOptions,
						"ctrlBindFieldId":"val",
						"ctrlBindField":this.m_model.getField("val_id"),
						"keyIds":["val"],
						"app":this.getApp()
						});
				}
				else{
					cell_opts.gridColumn = columns[col_id];
				}				
				cell_opts.app = this.getApp();
				var cell = new cell_class(row_id+":"+field_cnt,cell_opts);				
				row.addElement(cell);
								
				field_cnt++;				
			}
		
			row.setAttr("keys",CommonHelper.array2json(row_keys));
			row.setAttr("modelIndex",row_cnt);
		
			//system cell
			var row_cmd_class = this.getRowCommandClass();
			if (row_cmd_class){
				var row_class_options = {"grid":this,"app":this.getApp()};
				row.addElement(new row_cmd_class(row_id+":cell-sys",row_class_options));
			}
			body.addElement(row);
			row_cnt++;
	
			/*
			if (this.m_onSelect){
				this.m_selects[row_id] = function(){
					EventHandler.add(row.m_node,"click",function(){
						self.m_onSelect();
					},true);
				};
			}
			*/
			//foot
			if (foot && foot.calc){	
				foot.calc(this.m_model);
			}		
		}
		
		if (this.getLastRowFooter() && row){
			DOMHelper.addClass(row.m_node,"grid_foot");
		}
	
		if (foot && foot.calcEnd){	
			foot.calcEnd();
		}
		
		body.toDOM(this.m_node);
		
	}
	if (this.m_navigate){
		this.setSelection();
	}
	
	if (this.m_onRefresh){
		this.m_onRefresh.call(this);
	}
}

ConstantGrid.prototype.initEditView = function(parent,replacedNode,cmd){

	ConstantGrid.superclass.initEditView.call(this,parent,replacedNode,cmd);

	var pm = this.getUpdatePublicMethod();
	pm.setFieldValue("id",this.m_model.getFieldValue("id"));
}
