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

function DOCProductDisposal_Model(options){
	var id = 'DOCProductDisposal_Model';
	options = options || {};
	
	options.fields = {};
	
			
				
			
			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	
	var field = new FieldInt("id",filed_options);
	

	options.fields.id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Дата';
	
	var field = new FieldDateTime("date_time",filed_options);
	
		field.getValidator().setRequired(true);
	

	options.fields.date_time = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Номер';
	
	var field = new FieldInt("number",filed_options);
	

	options.fields.number = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Проведен';
	
	var field = new FieldBool("processed",filed_options);
	

	options.fields.processed = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Магазин';
	
	var field = new FieldInt("store_id",filed_options);
	

	options.fields.store_id = field;
			
			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Флорист';
	
	var field = new FieldInt("user_id",filed_options);
	

	options.fields.user_id = field;
						
			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Комплектация';
	
	var field = new FieldInt("doc_production_id",filed_options);
	
		field.getValidator().setRequired(true);
	

	options.fields.doc_production_id = field;
			
			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	filed_options.alias = 'Причина списания';
	
	var field = new FieldText("explanation",filed_options);
	

	options.fields.explanation = field;
						
						
			
			
			
				
				
				
						
		DOCProductDisposal_Model.superclass.constructor.call(this,id,options);
}
extend(DOCProductDisposal_Model,ModelXML);

