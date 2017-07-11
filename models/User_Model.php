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
			
		//*** Field id ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['autoInc']=TRUE;
		$f_opts['id']="id";
		
		$f_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"id",$f_opts);
		$this->addField($f_id);
		//********************
	
		//*** Field name ***
		$f_opts = array();
		$f_opts['length']=50;
		$f_opts['id']="name";
		
		$f_name=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"name",$f_opts);
		$this->addField($f_name);
		//********************
	
		//*** Field role_id ***
		$f_opts = array();
		$f_opts['id']="role_id";
		
		$f_role_id=new FieldSQLEnum($this->getDbLink(),$this->getDbName(),$this->getTableName(),"role_id",$f_opts);
		$this->addField($f_role_id);
		//********************
	
		//*** Field email ***
		$f_opts = array();
		$f_opts['length']=50;
		$f_opts['id']="email";
		
		$f_email=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"email",$f_opts);
		$this->addField($f_email);
		//********************
	
		//*** Field pwd ***
		$f_opts = array();
		$f_opts['length']=32;
		$f_opts['id']="pwd";
		
		$f_pwd=new FieldSQLPassword($this->getDbLink(),$this->getDbName(),$this->getTableName(),"pwd",$f_opts);
		$this->addField($f_pwd);
		//********************
	
		//*** Field phone_cel ***
		$f_opts = array();
		$f_opts['length']=11;
		$f_opts['id']="phone_cel";
		
		$f_phone_cel=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"phone_cel",$f_opts);
		$this->addField($f_phone_cel);
		//********************
	
		//*** Field store_id ***
		$f_opts = array();
		$f_opts['id']="store_id";
		
		$f_store_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"store_id",$f_opts);
		$this->addField($f_store_id);
		//********************
	
		//*** Field constrain_to_store ***
		$f_opts = array();
		$f_opts['id']="constrain_to_store";
		
		$f_constrain_to_store=new FieldSQLBool($this->getDbLink(),$this->getDbName(),$this->getTableName(),"constrain_to_store",$f_opts);
		$this->addField($f_constrain_to_store);
		//********************
	
		//*** Field cash_register_id ***
		$f_opts = array();
		$f_opts['id']="cash_register_id";
		
		$f_cash_register_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"cash_register_id",$f_opts);
		$this->addField($f_cash_register_id);
		//********************

		$order = new ModelOrderSQL();		
		$this->setDefaultModelOrder($order);		
		
		$order->addField($f_name);
$this->setLimitConstant('doc_per_page_count');
	}

}
?>
