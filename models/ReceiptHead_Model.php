<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');

class ReceiptHead_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("receipt_head");
			
		//*** Field client_id ***
		$f_opts = array();
		$f_opts['id']="client_id";
		
		$f_client_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"client_id",$f_opts);
		$this->addField($f_client_id);
		//********************
	
		//*** Field discount_id ***
		$f_opts = array();
		$f_opts['id']="discount_id";
		
		$f_discount_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"discount_id",$f_opts);
		$this->addField($f_discount_id);
		//********************
	
		//*** Field doc_client_order_id ***
		$f_opts = array();
		$f_opts['id']="doc_client_order_id";
		
		$f_doc_client_order_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"doc_client_order_id",$f_opts);
		$this->addField($f_doc_client_order_id);
		//********************
	
		//*** Field user_id ***
		$f_opts = array();
		$f_opts['id']="user_id";
		
		$f_user_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"user_id",$f_opts);
		$this->addField($f_user_id);
		//********************
$this->setLimitConstant('doc_per_page_count');
	}

}
?>