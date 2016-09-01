<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQLDOC.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTime.php');

class DOCProductDisposalList_Model extends ModelSQLDOC{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_product_disposals_list_view");
		
		$f_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"id"
		,array(
		
			'primaryKey'=>TRUE,
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
		
			'id'=>"processed"
		,
			'sysCol'=>TRUE
				
		
		));
		$this->addField($f_processed);

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

		$f_product_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"product_id"
		,array(
		
			'id'=>"product_id"
		,
			'sysCol'=>TRUE
				
		
		));
		$this->addField($f_product_id);

		$f_product_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"product_descr"
		,array(
		
			'alias'=>"Продукция"
		,
			'id'=>"product_descr"
				
		
		));
		$this->addField($f_product_descr);

		$f_explanation=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"explanation"
		,array(
		
			'alias'=>"Причина списания"
		,
			'id'=>"explanation"
				
		
		));
		$this->addField($f_explanation);

		$f_doc_production_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"doc_production_descr"
		,array(
		
			'alias'=>"Поставка"
		,
			'id'=>"doc_production_descr"
				
		
		));
		$this->addField($f_doc_production_descr);

		$f_doc_production_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"doc_production_id"
		,array(
		
			'id'=>"doc_production_id"
		,
			'sysCol'=>TRUE
				
		
		));
		$this->addField($f_doc_production_id);

		
		
		
	}

}
?>
