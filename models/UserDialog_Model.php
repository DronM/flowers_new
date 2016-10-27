<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLBool.php');

class UserDialog_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("user_view");
		
		$f_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"id"
		,array(
		
			'primaryKey'=>TRUE,
			'alias'=>"Код"
		,
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

		$f_email=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"email"
		,array(
		
			'alias'=>"Эл.почта"
		,
			'id'=>"email"
				
		
		));
		$this->addField($f_email);

		$f_role_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"role_descr"
		,array(
		
			'alias'=>"Роль"
		,
			'id'=>"role_descr"
				
		
		));
		$this->addField($f_role_descr);

		$f_role_id=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"role_id"
		,array(
		
			'id'=>"role_id"
				
		
		));
		$this->addField($f_role_id);

		$f_phone_cel=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"phone_cel"
		,array(
		
			'alias'=>"Моб.телефон"
		,
			'length'=>11,
			'id'=>"phone_cel"
				
		
		));
		$this->addField($f_phone_cel);

		$f_store_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"store_descr"
		,array(
		
			'id'=>"store_descr"
				
		
		));
		$this->addField($f_store_descr);

		$f_store_id=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"store_id"
		,array(
		
			'id'=>"store_id"
				
		
		));
		$this->addField($f_store_id);

		$f_constrain_to_store=new FieldSQlBool($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"constrain_to_store"
		,array(
		
			'id'=>"constrain_to_store"
				
		
		));
		$this->addField($f_constrain_to_store);

		$f_cash_register_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"cash_register_descr"
		,array(
		
			'id'=>"cash_register_descr"
				
		
		));
		$this->addField($f_cash_register_descr);

		$f_cash_register_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"cash_register_id"
		,array(
		
			'id'=>"cash_register_id"
				
		
		));
		$this->addField($f_cash_register_id);

		
		
		
	}

}
?>
