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

function RepMaterialAction_Model(options){
	var id = 'RepMaterialAction_Model';
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
	
	filed_options.alias = 'Поставка';
	
	var field = new FieldInt("doc_procurement_id",filed_options);
	

	options.fields.doc_procurement_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Поставка';
	
	var field = new FieldString("doc_procurement_descr",filed_options);
	

	options.fields.doc_procurement_descr = field;
			
			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Группа материалов';
	
	var field = new FieldInt("material_group_id",filed_options);
	

	options.fields.material_group_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Группа материалов';
	
	var field = new FieldString("material_group_descr",filed_options);
	

	options.fields.material_group_descr = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Материал';
	
	var field = new FieldInt("material_id",filed_options);
	

	options.fields.material_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Материал';
	
	var field = new FieldString("material_group_descr",filed_options);
	

	options.fields.material_group_descr = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Документ движения';
	
	var field = new FieldInt("ra_doc_id",filed_options);
	

	options.fields.ra_doc_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Документ движения';
	
	var field = new FieldString("ra_doc_type",filed_options);
	

	options.fields.ra_doc_type = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Документ движения';
	
	var field = new FieldString("ra_doc_descr",filed_options);
	

	options.fields.ra_doc_descr = field;

			
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

		RepMaterialAction_Model.superclass.constructor.call(this,id,options);
}
extend(RepMaterialAction_Model,ModelXML);

