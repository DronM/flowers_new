<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQLDOC.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLText.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTime.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLBool.php');
require_once(FRAME_WORK_PATH.'basic_classes/ModelOrderSQL.php');

class DOCProductDisposal_Model extends ModelSQLDOC{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_product_disposals");
		
		$f_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"id"
		,array(
		
			'primaryKey'=>TRUE,
			'autoInc'=>TRUE,
			'id'=>"id"
				
		
		));
		$this->addField($f_id);

		$f_date_time=new FieldSQlDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"date_time"
		,array(
		'required'=>TRUE,
			'alias'=>"Дата"
		,
			'id'=>"date_time"
				
		
		));
		$this->addField($f_date_time);

		$f_number=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"number"
		,array(
		
			'alias'=>"Номер"
		,
			'id'=>"number"
				
		
		));
		$this->addField($f_number);

		$f_processed=new FieldSQlBool($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"processed"
		,array(
		
			'alias'=>"Проведен"
		,
			'id'=>"processed"
				
		
		));
		$this->addField($f_processed);

		$f_store_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"store_id"
		,array(
		
			'alias'=>"Магазин"
		,
			'id'=>"store_id"
				
		
		));
		$this->addField($f_store_id);

		$f_user_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"user_id"
		,array(
		
			'alias'=>"Флорист"
		,
			'id'=>"user_id"
				
		
		));
		$this->addField($f_user_id);

		$f_doc_production_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"doc_production_id"
		,array(
		'required'=>TRUE,
			'alias'=>"Комплектация"
		,
			'id'=>"doc_production_id"
				
		
		));
		$this->addField($f_doc_production_id);

		$f_explanation=new FieldSQlText($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"explanation"
		,array(
		
			'alias'=>"Причина списания"
		,
			'id'=>"explanation"
				
		
		));
		$this->addField($f_explanation);

		$order = new ModelOrderSQL();		
		$this->setDefaultModelOrder($order);		
		
		$order->addField($f_date_time);

		
		
		
	}

}
?>
