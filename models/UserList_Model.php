<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLBool.php');

class UserList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("user_list_view");
		
		$f_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"id"
		,array(
		
			'primaryKey'=>TRUE,
			'id'=>"id"
				
		
		));
		$this->addField($f_id);

		$f_name=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"name"
		,array(
		
			'alias'=>"Имя"
		,
			'id'=>"name"
				
		
		));
		$this->addField($f_name);

		$f_role_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"role_descr"
		,array(
		
			'alias'=>"Роль"
		,
			'id'=>"role_descr"
				
		
		));
		$this->addField($f_role_descr);

		$f_phone_cel=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"phone_cel"
		,array(
		
			'alias'=>"Моб.телефон"
		,
			'length'=>11,
			'id'=>"phone_cel"
				
		
		));
		$this->addField($f_phone_cel);

		$f_constrain_to_store=new FieldSQlBool($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"constrain_to_store"
		,array(
		
			'id'=>"constrain_to_store"
				
		
		));
		$this->addField($f_constrain_to_store);

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

		
		
		
	}

}
?>
