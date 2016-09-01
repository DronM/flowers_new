<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLText.php');
require_once(FRAME_WORK_PATH.'basic_classes/ModelOrderSQL.php');

class Supplier_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("suppliers");
		
		$f_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"id"
		,array(
		'required'=>FALSE,
			'primaryKey'=>TRUE,
			'autoInc'=>TRUE,
			'alias'=>"Код"
		,
			'id'=>"id"
				
		
		));
		$this->addField($f_id);

		$f_name=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"name"
		,array(
		'required'=>TRUE,
			'alias'=>"Наименование"
		,
			'length'=>100,
			'id'=>"name"
				
		
		));
		$this->addField($f_name);

		$f_name_full=new FieldSQlText($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"name_full"
		,array(
		'required'=>TRUE,
			'alias'=>"Полное наименование"
		,
			'id'=>"name_full"
				
		
		));
		$this->addField($f_name_full);

		$f_tel=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"tel"
		,array(
		
			'alias'=>"Телефон"
		,
			'length'=>15,
			'id'=>"tel"
				
		
		));
		$this->addField($f_tel);

		$f_email=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"email"
		,array(
		
			'alias'=>"Email"
		,
			'length'=>50,
			'id'=>"email"
				
		
		));
		$this->addField($f_email);

		$order = new ModelOrderSQL();		
		$this->setDefaultModelOrder($order);		
		
		$order->addField($f_name);

		
		
		
	}

}
?>
