<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');

class DeliveryHourList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("delivery_hours_list");
		
		$f_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"id"
		,array(
		
			'primaryKey'=>TRUE,
			'id'=>"id"
				
		
		));
		$this->addField($f_id);

		$f_h_from=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"h_from"
		,array(
		
			'id'=>"h_from"
				
		
		));
		$this->addField($f_h_from);

		$f_h_to=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"h_to"
		,array(
		
			'id'=>"h_to"
				
		
		));
		$this->addField($f_h_to);

		$f_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"descr"
		,array(
		
			'id'=>"descr"
				
		
		));
		$this->addField($f_descr);

		
		
		
	}

}
?>
