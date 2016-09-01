<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQLDOC.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTime.php');

class DOCMaterialOrderMaterialList_Model extends ModelSQLDOC{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_material_orders_materials_list_view");
		
		$f_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"id"
		,array(
		
			'primaryKey'=>TRUE,
			'id'=>"id"
				
		
		));
		$this->addField($f_id);

		$f_date_time=new FieldSQlDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"date_time"
		,array(
		
			'id'=>"date_time"
				
		
		));
		$this->addField($f_date_time);

		$f_date_time_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"date_time_descr"
		,array(
		
			'id'=>"date_time_descr"
				
		
		));
		$this->addField($f_date_time_descr);

		$f_number=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"number"
		,array(
		
			'id'=>"number"
				
		
		));
		$this->addField($f_number);

		$f_store_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"store_id"
		,array(
		
			'id'=>"store_id"
				
		
		));
		$this->addField($f_store_id);

		$f_store_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"store_descr"
		,array(
		
			'id'=>"store_descr"
				
		
		));
		$this->addField($f_store_descr);

		$f_user_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"user_id"
		,array(
		
			'id'=>"user_id"
				
		
		));
		$this->addField($f_user_id);

		$f_user_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"user_descr"
		,array(
		
			'id'=>"user_descr"
				
		
		));
		$this->addField($f_user_descr);

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

		$f_material_group_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"material_group_id"
		,array(
		
			'id'=>"material_group_id"
				
		
		));
		$this->addField($f_material_group_id);

		$f_material_group_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"material_group_descr"
		,array(
		
			'id'=>"material_group_descr"
				
		
		));
		$this->addField($f_material_group_descr);

		$f_quant=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"quant"
		,array(
		
			'id'=>"quant"
				
		
		));
		$this->addField($f_quant);

		
		
		
	}

}
?>
