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

function DiscCard_Model(options){
	var id = 'DiscCard_Model';
	options = options || {};
	
	options.fields = {};
	
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	filed_options.alias = 'Код';options.fields.id = new FieldInt("id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Вид скидки';options.fields.discount_id = new FieldInt("discount_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Штрихкод';options.fields.barcode = new FieldText("barcode",filed_options);
	
			
						
		DiscCard_Model.superclass.constructor.call(this,id,options);
}
extend(DiscCard_Model,ModelXML);

