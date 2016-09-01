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
	
	filed_options.alias = 'Салон';
	
	var field = new FieldInt("store_id",filed_options);
	

	options.fields.store_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Салон';
	
	var field = new FieldString("store_descr",filed_options);
	

	options.fields.store_descr = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Дата';
	
	var field = new FieldDate("period",filed_options);
	

	options.fields.period = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Месяц';
	
	var field = new FieldString("mon",filed_options);
	

	options.fields.mon = field;
			
			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldInt("expence_type_id",filed_options);
	

	options.fields.expence_type_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Вид затрат';
	
	var field = new FieldString("expence_type_descr",filed_options);
	

	options.fields.expence_type_descr = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Сумма затрат';
	
	var field = new FieldFloat("total_expences",filed_options);
	
		field.getValidator().setMaxLength('12');
	

	options.fields.total_expences = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Выручка';
	
	var field = new FieldFloat("total_sales",filed_options);
	
		field.getValidator().setMaxLength('12');
	

	options.fields.total_sales = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Списания материалов';
	
	var field = new FieldFloat("total_mat_disp",filed_options);
	
		field.getValidator().setMaxLength('12');
	

	options.fields.total_mat_disp = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Себестоимость материалов';
	
	var field = new FieldFloat("total_mat_cost",filed_options);
	
		field.getValidator().setMaxLength('12');
	

	options.fields.total_mat_cost = field;

		RepBalance_Model.superclass.constructor.call(this,id,options);
}
extend(RepBalance_Model,ModelXML);

