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

function Material_Model(options){
	var id = 'Material_Model';
	options = options || {};
	
	options.fields = {};
	
			
				
			
			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	filed_options.alias = 'Код';
	
	var field = new FieldInt("id",filed_options);
	

	options.fields.id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Наименование';
	
	var field = new FieldString("name",filed_options);
	
		field.getValidator().setRequired(true);
	
		field.getValidator().setMaxLength('100');
	

	options.fields.name = field;
		
			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Описание';
	
	var field = new FieldText("name_full",filed_options);
	
		field.getValidator().setRequired(true);
	

	options.fields.name_full = field;
		
			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Розничная цена';
	
	var field = new FieldFloat("price",filed_options);
	
		field.getValidator().setRequired(true);
	
		field.getValidator().setMaxLength('15');
	

	options.fields.price = field;
			
			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Для продажи';
	
	var field = new FieldBool("for_sale",filed_options);
	

	options.fields.for_sale = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Наценка (%)';
	
	var field = new FieldInt("margin_percent",filed_options);
	

	options.fields.margin_percent = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Группа';
	
	var field = new FieldInt("material_group_id",filed_options);
	
		field.getValidator().setRequired(true);
	

	options.fields.material_group_id = field;

						
									
												
		Material_Model.superclass.constructor.call(this,id,options);
}
extend(Material_Model,ModelXML);

