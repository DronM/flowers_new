<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/ModelOrderSQL.php');

class CashRegister_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("cash_registers");
		
		$f_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"id"
		,array(
		'required'=>TRUE,
			'primaryKey'=>TRUE,
			'autoInc'=>TRUE,
			'id'=>"id"
				
		
		));
		$this->addField($f_id);

		$f_name=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"name"
		,array(
		'required'=>TRUE,
			'alias'=>"Наименование"
		,
			'length'=>200,
			'id'=>"name"
				
		
		));
		$this->addField($f_name);

		$f_port=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"port"
		,array(
		
			'alias'=>"Порт"
		,
			'id'=>"port"
				
		
		));
		$this->addField($f_port);

		$f_baud_rate=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"baud_rate"
		,array(
		
			'alias'=>"Скорость"
		,
			'id'=>"baud_rate"
				
		
		));
		$this->addField($f_baud_rate);

		$order = new ModelOrderSQL();		
		$this->setDefaultModelOrder($order);		
		
		$order->addField($f_name);

		
		
		
	}

}
?>
