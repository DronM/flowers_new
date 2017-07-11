<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLText.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLEnum.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTime.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLBool.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInterval.php');

class DOCReprocessStat_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_reprocess_stat");
			
		//*** Field doc_sequence ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['id']="doc_sequence";
		
		$f_doc_sequence=new FieldSQLEnum($this->getDbLink(),$this->getDbName(),$this->getTableName(),"doc_sequence",$f_opts);
		$this->addField($f_doc_sequence);
		//********************
	
		//*** Field start_time ***
		$f_opts = array();
		$f_opts['id']="start_time";
		
		$f_start_time=new FieldSQLDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName(),"start_time",$f_opts);
		$this->addField($f_start_time);
		//********************
	
		//*** Field update_time ***
		$f_opts = array();
		$f_opts['id']="update_time";
		
		$f_update_time=new FieldSQLDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName(),"update_time",$f_opts);
		$this->addField($f_update_time);
		//********************
	
		//*** Field end_time ***
		$f_opts = array();
		$f_opts['id']="end_time";
		
		$f_end_time=new FieldSQLDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName(),"end_time",$f_opts);
		$this->addField($f_end_time);
		//********************
	
		//*** Field count_total ***
		$f_opts = array();
		$f_opts['id']="count_total";
		
		$f_count_total=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"count_total",$f_opts);
		$this->addField($f_count_total);
		//********************
	
		//*** Field count_done ***
		$f_opts = array();
		$f_opts['id']="count_done";
		
		$f_count_done=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"count_done",$f_opts);
		$this->addField($f_count_done);
		//********************
	
		//*** Field time_to_go ***
		$f_opts = array();
		$f_opts['id']="time_to_go";
		
		$f_time_to_go=new FieldSQLInterval($this->getDbLink(),$this->getDbName(),$this->getTableName(),"time_to_go",$f_opts);
		$this->addField($f_time_to_go);
		//********************
	
		//*** Field doc_id ***
		$f_opts = array();
		$f_opts['id']="doc_id";
		
		$f_doc_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"doc_id",$f_opts);
		$this->addField($f_doc_id);
		//********************
	
		//*** Field doc_type ***
		$f_opts = array();
		$f_opts['id']="doc_type";
		
		$f_doc_type=new FieldSQLEnum($this->getDbLink(),$this->getDbName(),$this->getTableName(),"doc_type",$f_opts);
		$this->addField($f_doc_type);
		//********************
	
		//*** Field error_message ***
		$f_opts = array();
		$f_opts['id']="error_message";
		
		$f_error_message=new FieldSQLText($this->getDbLink(),$this->getDbName(),$this->getTableName(),"error_message",$f_opts);
		$this->addField($f_error_message);
		//********************
	
		//*** Field res ***
		$f_opts = array();
		$f_opts['id']="res";
		
		$f_res=new FieldSQLBool($this->getDbLink(),$this->getDbName(),$this->getTableName(),"res",$f_opts);
		$this->addField($f_res);
		//********************
$this->setLimitConstant('doc_per_page_count');
	}

}
?>
