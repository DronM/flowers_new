<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLEnum.php');

class MessageRecipient_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("message_recipients");
			
		//*** Field id ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['id']="id";
		
		$f_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"id",$f_opts);
		$this->addField($f_id);
		//********************
	
		//*** Field message_id ***
		$f_opts = array();
		$f_opts['id']="message_id";
		
		$f_message_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"message_id",$f_opts);
		$this->addField($f_message_id);
		//********************
	
		//*** Field for_store_id ***
		$f_opts = array();
		$f_opts['id']="for_store_id";
		
		$f_for_store_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"for_store_id",$f_opts);
		$this->addField($f_for_store_id);
		//********************
	
		//*** Field for_role_id ***
		$f_opts = array();
		$f_opts['id']="for_role_id";
		
		$f_for_role_id=new FieldSQLEnum($this->getDbLink(),$this->getDbName(),$this->getTableName(),"for_role_id",$f_opts);
		$this->addField($f_for_role_id);
		//********************
	
		//*** Field for_user_id ***
		$f_opts = array();
		$f_opts['id']="for_user_id";
		
		$f_for_user_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"for_user_id",$f_opts);
		$this->addField($f_for_user_id);
		//********************
$this->setLimitConstant('doc_per_page_count');
	}

}
?>
