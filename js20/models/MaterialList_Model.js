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

function MaterialList_Model(options){
	var id = 'MaterialList_Model';
	options = options || {};
	
	options.fields = {};
	
			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	
	var field = new FieldInt("id",filed_options);
	

	options.fields.id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Наименование';
	
	var field = new FieldString("name",filed_options);
	

	options.fields.name = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Розничная цена';
	
	var field = new FieldFloat("price",filed_options);
	
		field.getValidator().setMaxLength('15');
	

	options.fields.price = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Для продажи';
	
	var field = new FieldBool("for_sale",filed_options);
	

	options.fields.for_sale = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldString("material_group_id",filed_options);
	

	options.fields.material_group_id = field;

		MaterialList_Model.superclass.constructor.call(this,id,options);
}
extend(MaterialList_Model,ModelXML);

