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

function RAMaterial_Model(options){
	var id = 'RAMaterial_Model';
	options = options || {};
	
	options.fields = {};
	
			
				
			
			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	filed_options.alias = 'Код';
	
	var field = new FieldInt("id",filed_options);
	

	options.fields.id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Период';
	
	var field = new FieldDateTime("date_time",filed_options);
	
		field.getValidator().setRequired(true);
	

	options.fields.date_time = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Дебет';
	
	var field = new FieldBool("deb",filed_options);
	

	options.fields.deb = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Вид документа';
	
	var field = new FieldEnum("doc_type",filed_options);
	filed_options.enumValues = 'production,product_disposal,material_procurement,material_disposal,sale,product_order,material_order,expence,doc_client_order';
	
		field.getValidator().setRequired(true);
	

	options.fields.doc_type = field;
	
			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldInt("doc_id",filed_options);
	

	options.fields.doc_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Магазин';
	
	var field = new FieldInt("store_id",filed_options);
	
		field.getValidator().setRequired(true);
	

	options.fields.store_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Склад';
	
	var field = new FieldEnum("stock_type",filed_options);
	filed_options.enumValues = 'main,waste';
	
		field.getValidator().setRequired(true);
	

	options.fields.stock_type = field;
						
			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Материал';
	
	var field = new FieldInt("material_id",filed_options);
	
		field.getValidator().setRequired(true);
	

	options.fields.material_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Поставка';
	
	var field = new FieldInt("doc_procurement_id",filed_options);
	
		field.getValidator().setRequired(true);
	

	options.fields.doc_procurement_id = field;
			
			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Количество';
	
	var field = new FieldFloat("quant",filed_options);
	
		field.getValidator().setMaxLength('19');
	

	options.fields.quant = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Стоимость';
	
	var field = new FieldFloat("cost",filed_options);
	
		field.getValidator().setMaxLength('15');
	

	options.fields.cost = field;

						
									
												
															
									
												
			
		RAMaterial_Model.superclass.constructor.call(this,id,options);
}
extend(RAMaterial_Model,ModelXML);

