<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTime.php');

class DOCMaterialDisposalMaterialList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_material_disposals_materials_list_view");
		
		$f_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"id"
		,array(
		
			'primaryKey'=>TRUE,
			'id'=>"id"
		,
			'sysCol'=>TRUE
				
		
		));
		$this->addField($f_id);

		$f_date_time=new FieldSQlDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"date_time"
		,array(
		
			'id'=>"date_time"
		,
			'sysCol'=>TRUE
				
		
		));
		$this->addField($f_date_time);

		$f_date_time_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"date_time_descr"
		,array(
		
			'alias'=>"Дата"
		,
			'id'=>"date_time_descr"
				
		
		));
		$this->addField($f_date_time_descr);

		$f_number=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"number"
		,array(
		
			'alias'=>"Номер"
		,
			'id'=>"number"
				
		
		));
		$this->addField($f_number);

		$f_store_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"store_id"
		,array(
		
			'id'=>"store_id"
		,
			'sysCol'=>TRUE
				
		
		));
		$this->addField($f_store_id);

		$f_store_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"store_descr"
		,array(
		
			'alias'=>"Салон"
		,
			'id'=>"store_descr"
				
		
		));
		$this->addField($f_store_descr);

		$f_user_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"user_id"
		,array(
		
			'id'=>"user_id"
		,
			'sysCol'=>TRUE
				
		
		));
		$this->addField($f_user_id);

		$f_user_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"user_descr"
		,array(
		
			'alias'=>"Автор"
		,
			'id'=>"user_descr"
				
		
		));
		$this->addField($f_user_descr);

		$f_explanation=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"explanation"
		,array(
		
			'alias'=>"Причина"
		,
			'id'=>"explanation"
				
		
		));
		$this->addField($f_explanation);

		$f_material_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"material_id"
		,array(
		
			'id'=>"material_id"
		,
			'sysCol'=>TRUE
				
		
		));
		$this->addField($f_material_id);

		$f_material_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"material_descr"
		,array(
		
			'alias'=>"Материал"
		,
			'id'=>"material_descr"
				
		
		));
		$this->addField($f_material_descr);

		$f_material_group_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"material_group_id"
		,array(
		
			'id'=>"material_group_id"
		,
			'sysCol'=>TRUE
				
		
		));
		$this->addField($f_material_group_id);

		$f_material_group_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"material_group_descr"
		,array(
		
			'alias'=>"Группа"
		,
			'id'=>"material_group_descr"
				
		
		));
		$this->addField($f_material_group_descr);

		$f_quant=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"quant"
		,array(
		
			'alias'=>"Количество"
		,
			'id'=>"quant"
				
		
		));
		$this->addField($f_quant);

		
		
		
	}

}
?>
