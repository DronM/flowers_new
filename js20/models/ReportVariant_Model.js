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

function ReportVariant_Model(options){
	var id = 'ReportVariant_Model';
	options = options || {};
	
	options.fields = {};
	
			
	var filed_options = {};
	filed_options.primaryKey = true;
	
	
	var field = new FieldInt("id",filed_options);
	
		field.getValidator().setRequired(true);
	

	options.fields.id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldInt("user_id",filed_options);
	

	options.fields.user_id = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldEnum("report_type",filed_options);
	filed_options.enumValues = 'material_actions';
	
		field.getValidator().setRequired(true);
	

	options.fields.report_type = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldText("name",filed_options);
	

	options.fields.name = field;

			
	var filed_options = {};
	filed_options.primaryKey = false;
	
	
	var field = new FieldText("data",filed_options);
	

	options.fields.data = field;

																
		ReportVariant_Model.superclass.constructor.call(this,id,options);
}
extend(ReportVariant_Model,ModelXML);

