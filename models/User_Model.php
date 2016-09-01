<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLEnum.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLPassword.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLBool.php');
require_once(FRAME_WORK_PATH.'basic_classes/ModelOrderSQL.php');

class User_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("users");
		
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
			'length'=>50,
			'id'=>"name"
				
		
		));
		$this->addField($f_name);

		$f_role_id=new FieldSQlEnum($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"role_id"
		,array(
		'required'=>TRUE,
			'id'=>"role_id"
				
		
		));
		$this->addField($f_role_id);

		$f_email=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"email"
		,array(
		'required'=>FALSE,
			'length'=>50,
			'id'=>"email"
				
		
		));
		$this->addField($f_email);

		$f_pwd=new FieldSQlPassword($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"pwd"
		,array(
		
			'length'=>32,
			'id'=>"pwd"
				
		
		));
		$this->addField($f_pwd);

		$f_store_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"store_id"
		,array(
		
			'alias'=>"Магазин"
		,
			'id'=>"store_id"
				
		
		));
		$this->addField($f_store_id);

		$f_constrain_to_store=new FieldSQlBool($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"constrain_to_store"
		,array(
		
			'alias'=>"Привязвывать к магазину"
		,
			'id'=>"constrain_to_store"
				
		
		));
		$this->addField($f_constrain_to_store);

		$f_cash_register_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"cash_register_id"
		,array(
		'required'=>TRUE,
			'id'=>"cash_register_id"
				
		
		));
		$this->addField($f_cash_register_id);

		$order = new ModelOrderSQL();		
		$this->setDefaultModelOrder($order);		
		
		$order->addField($f_name);

		
		
		
	}

}
?>
