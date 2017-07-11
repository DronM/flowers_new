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
			
		//*** Field id ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['id']="id";
		
		$f_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"id",$f_opts);
		$this->addField($f_id);
		//********************
	
		//*** Field name ***
		$f_opts = array();
		$f_opts['id']="name";
		
		$f_name=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"name",$f_opts);
		$this->addField($f_name);
		//********************
	
		//*** Field email ***
		$f_opts = array();
		$f_opts['id']="email";
		
		$f_email=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"email",$f_opts);
		$this->addField($f_email);
		//********************
	
		//*** Field role_descr ***
		$f_opts = array();
		$f_opts['id']="role_descr";
		
		$f_role_descr=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"role_descr",$f_opts);
		$this->addField($f_role_descr);
		//********************
	
		//*** Field role_id ***
		$f_opts = array();
		$f_opts['id']="role_id";
		
		$f_role_id=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"role_id",$f_opts);
		$this->addField($f_role_id);
		//********************
	
		//*** Field phone_cel ***
		$f_opts = array();
		$f_opts['length']=11;
		$f_opts['id']="phone_cel";
		
		$f_phone_cel=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"phone_cel",$f_opts);
		$this->addField($f_phone_cel);
		//********************
	
		//*** Field store_descr ***
		$f_opts = array();
		$f_opts['id']="store_descr";
		
		$f_store_descr=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"store_descr",$f_opts);
		$this->addField($f_store_descr);
		//********************
	
		//*** Field store_id ***
		$f_opts = array();
		$f_opts['id']="store_id";
		
		$f_store_id=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"store_id",$f_opts);
		$this->addField($f_store_id);
		//********************
	
		//*** Field constrain_to_store ***
		$f_opts = array();
		$f_opts['id']="constrain_to_store";
		
		$f_constrain_to_store=new FieldSQLBool($this->getDbLink(),$this->getDbName(),$this->getTableName(),"constrain_to_store",$f_opts);
		$this->addField($f_constrain_to_store);
		//********************
	
		//*** Field cash_register_descr ***
		$f_opts = array();
		$f_opts['id']="cash_register_descr";
		
		$f_cash_register_descr=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"cash_register_descr",$f_opts);
		$this->addField($f_cash_register_descr);
		//********************
	
		//*** Field cash_register_id ***
		$f_opts = array();
		$f_opts['id']="cash_register_id";
		
		$f_cash_register_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"cash_register_id",$f_opts);
		$this->addField($f_cash_register_id);
		//********************
$this->setLimitConstant('doc_per_page_count');
	}

}
?>
