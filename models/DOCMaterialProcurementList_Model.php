<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQLDOC.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTime.php');

class DOCMaterialProcurementList_Model extends ModelSQLDOC{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_material_procurements_list_view");
		
		$f_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"id"
		,array(
		
			'primaryKey'=>TRUE,
			'alias'=>"Идентификатор"
		,
			'id'=>"id"
		,
			'sysCol'=>TRUE
				
		
		));
		$this->addField($f_id);

		$f_number=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"number"
		,array(
		
			'alias'=>"Номер"
		,
			'id'=>"number"
				
		
		));
		$this->addField($f_number);

		$f_date_time=new FieldSQlDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"date_time"
		,array(
		
			'alias'=>"Дата"
		,
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

		$f_processed=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"processed"
		,array(
		
			'alias'=>"Проведен"
		,
			'id'=>"processed"
		,
			'sysCol'=>TRUE
				
		
		));
		$this->addField($f_processed);

		$f_store_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"store_id"
		,array(
		
			'alias'=>"Салон"
		,
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
		
			'alias'=>"Автор"
		,
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

		$f_supplier_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"supplier_id"
		,array(
		
			'alias'=>"Поставщик"
		,
			'id'=>"supplier_id"
		,
			'sysCol'=>TRUE
				
		
		));
		$this->addField($f_supplier_id);

		$f_supplier_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"supplier_descr"
		,array(
		
			'alias'=>"Поставщик"
		,
			'id'=>"supplier_descr"
				
		
		));
		$this->addField($f_supplier_descr);

		$f_total=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"total"
		,array(
		
			'alias'=>"Сумма"
		,
			'length'=>19,
			'id'=>"total"
				
		
		));
		$this->addField($f_total);

		
		
		
	}

}
?>
