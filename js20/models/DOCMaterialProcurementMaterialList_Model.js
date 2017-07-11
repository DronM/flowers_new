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

function DOCMaterialProcurementMaterialList_Model(options){
	var id = 'DOCMaterialProcurementMaterialList_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	options.fields.id = new FieldInt("id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.date_time = new FieldDateTime("date_time",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Дата';options.fields.date_time_descr = new FieldString("date_time_descr",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Номер';options.fields.number = new FieldString("number",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.store_id = new FieldInt("store_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Салон';options.fields.store_descr = new FieldString("store_descr",filed_options);
				
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.supplier_id = new FieldInt("supplier_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Поставщик';options.fields.supplier_descr = new FieldString("supplier_descr",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.user_id = new FieldInt("user_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Автор';options.fields.user_descr = new FieldString("user_descr",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.material_id = new FieldInt("material_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Материал';options.fields.material_descr = new FieldString("material_descr",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.material_group_id = new FieldInt("material_group_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Группа';options.fields.material_group_descr = new FieldString("material_group_descr",filed_options);
				
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Количество';options.fields.quant = new FieldFloat("quant",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Цена';options.fields.price = new FieldFloat("price",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.price_descr = new FieldString("price_descr",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Сумма';options.fields.total = new FieldFloat("total",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	options.fields.total_descr = new FieldString("total_descr",filed_options);
				
			
		DOCMaterialProcurementMaterialList_Model.superclass.constructor.call(this,id,options);
}
extend(DOCMaterialProcurementMaterialList_Model,ModelXML);

