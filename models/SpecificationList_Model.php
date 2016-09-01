<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');

class SpecificationList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("specifications_list_view");
		
		$f_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"id"
		,array(
		
			'primaryKey'=>TRUE,
			'id'=>"id"
				
		
		));
		$this->addField($f_id);

		$f_product_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"product_id"
		,array(
		
			'id'=>"product_id"
				
		
		));
		$this->addField($f_product_id);

		$f_product_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"product_descr"
		,array(
		
			'id'=>"product_descr"
				
		
		));
		$this->addField($f_product_descr);

		$f_material_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"material_id"
		,array(
		
			'id'=>"material_id"
				
		
		));
		$this->addField($f_material_id);

		$f_material_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"material_descr"
		,array(
		
			'id'=>"material_descr"
				
		
		));
		$this->addField($f_material_descr);

		$f_product_quant=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"product_quant"
		,array(
		
			'id'=>"product_quant"
				
		
		));
		$this->addField($f_product_quant);

		$f_material_quant=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"material_quant"
		,array(
		
			'id'=>"material_quant"
				
		
		));
		$this->addField($f_material_quant);

		
		
		
	}

}
?>
