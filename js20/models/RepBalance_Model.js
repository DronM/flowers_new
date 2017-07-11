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

function RepBalance_Model(options){
	var id = 'RepBalance_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Салон';options.fields.store_id = new FieldInt("store_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Салон';options.fields.store_descr = new FieldString("store_descr",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Дата';options.fields.period = new FieldDate("period",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Месяц';options.fields.mon = new FieldString("mon",filed_options);
				
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.expence_type_id = new FieldInt("expence_type_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Вид затрат';options.fields.expence_type_descr = new FieldString("expence_type_descr",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Сумма затрат';options.fields.total_expences = new FieldFloat("total_expences",filed_options);
	options.fields.total_expences.getValidator().setMaxLength('12');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Выручка';options.fields.total_sales = new FieldFloat("total_sales",filed_options);
	options.fields.total_sales.getValidator().setMaxLength('12');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Списания материалов';options.fields.total_mat_disp = new FieldFloat("total_mat_disp",filed_options);
	options.fields.total_mat_disp.getValidator().setMaxLength('12');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Себестоимость материалов';options.fields.total_mat_cost = new FieldFloat("total_mat_cost",filed_options);
	options.fields.total_mat_cost.getValidator().setMaxLength('12');
	
		RepBalance_Model.superclass.constructor.call(this,id,options);
}
extend(RepBalance_Model,ModelXML);

