<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLText.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLEnum.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTime.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLBool.php');
require_once(FRAME_WORK_PATH.'basic_classes/ModelOrderSQL.php');

class Message_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("messages");
			
		//*** Field id ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['id']="id";
		
		$f_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"id",$f_opts);
		$this->addField($f_id);
		//********************
	
		//*** Field message_type ***
		$f_opts = array();
		$f_opts['id']="message_type";
		
		$f_message_type=new FieldSQLEnum($this->getDbLink(),$this->getDbName(),$this->getTableName(),"message_type",$f_opts);
		$this->addField($f_message_type);
		//********************
	
		//*** Field user_id ***
		$f_opts = array();
		$f_opts['id']="user_id";
		
		$f_user_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"user_id",$f_opts);
		$this->addField($f_user_id);
		//********************
	
		//*** Field require_view ***
		$f_opts = array();
		$f_opts['id']="require_view";
		
		$f_require_view=new FieldSQLBool($this->getDbLink(),$this->getDbName(),$this->getTableName(),"require_view",$f_opts);
		$this->addField($f_require_view);
		//********************
	
		//*** Field subject ***
		$f_opts = array();
		$f_opts['id']="subject";
		
		$f_subject=new FieldSQLText($this->getDbLink(),$this->getDbName(),$this->getTableName(),"subject",$f_opts);
		$this->addField($f_subject);
		//********************
	
		//*** Field content ***
		$f_opts = array();
		$f_opts['id']="content";
		
		$f_content=new FieldSQLText($this->getDbLink(),$this->getDbName(),$this->getTableName(),"content",$f_opts);
		$this->addField($f_content);
		//********************
	
		//*** Field importance_level ***
		$f_opts = array();
		$f_opts['id']="importance_level";
		
		$f_importance_level=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"importance_level",$f_opts);
		$this->addField($f_importance_level);
		//********************
	
		//*** Field date_time ***
		$f_opts = array();
		$f_opts['id']="date_time";
		
		$f_date_time=new FieldSQLDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName(),"date_time",$f_opts);
		$this->addField($f_date_time);
		//********************

		$order = new ModelOrderSQL();		
		$this->setDefaultModelOrder($order);		
		
		$order->addField($f_date_time);
$this->setLimitConstant('doc_per_page_count');
	}

}
?>
