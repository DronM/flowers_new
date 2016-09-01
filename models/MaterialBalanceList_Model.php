<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTime.php');

class MaterialBalanceList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("material_list_with_balance");
		
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
		
			'alias'=>"Период"
		,
			'id'=>"date_time"
				
		
		));
		$this->addField($f_date_time);

		$f_name=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"name"
		,array(
		
			'alias'=>"Материал"
		,
			'id'=>"name"
				
		
		));
		$this->addField($f_name);

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

		$f_price=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"price"
		,array(
		
			'alias'=>"Цена"
		,
			'id'=>"price"
				
		
		));
		$this->addField($f_price);

		$f_main_quant=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"main_quant"
		,array(
		
			'alias'=>"Кол-во"
		,
			'id'=>"main_quant"
				
		
		));
		$this->addField($f_main_quant);

		$f_main_toatl=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"main_toatl"
		,array(
		
			'alias'=>"Сумма"
		,
			'id'=>"main_toatl"
				
		
		));
		$this->addField($f_main_toatl);

		$f_procur_avg_time_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"procur_avg_time_descr"
		,array(
		
			'alias'=>"Время"
		,
			'id'=>"procur_avg_time_descr"
				
		
		));
		$this->addField($f_procur_avg_time_descr);

		
		
		
	}

}
?>
