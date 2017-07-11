<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLText.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLEnum.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTime.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLBool.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInterval.php');

class DOCReprocessStatList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_reprocess_stat_list");
			
		//*** Field doc_sequence ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['id']="doc_sequence";
		
		$f_doc_sequence=new FieldSQLEnum($this->getDbLink(),$this->getDbName(),$this->getTableName(),"doc_sequence",$f_opts);
		$this->addField($f_doc_sequence);
		//********************
	
		//*** Field seq_contents ***
		$f_opts = array();
		$f_opts['id']="seq_contents";
		
		$f_seq_contents=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"seq_contents",$f_opts);
		$this->addField($f_seq_contents);
		//********************
	
		//*** Field seq_contents_descrs ***
		$f_opts = array();
		$f_opts['id']="seq_contents_descrs";
		
		$f_seq_contents_descrs=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"seq_contents_descrs",$f_opts);
		$this->addField($f_seq_contents_descrs);
		//********************
	
		//*** Field stat_start_time ***
		$f_opts = array();
		$f_opts['id']="stat_start_time";
		
		$f_stat_start_time=new FieldSQLDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName(),"stat_start_time",$f_opts);
		$this->addField($f_stat_start_time);
		//********************
	
		//*** Field stat_update_time ***
		$f_opts = array();
		$f_opts['id']="stat_update_time";
		
		$f_stat_update_time=new FieldSQLDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName(),"stat_update_time",$f_opts);
		$this->addField($f_stat_update_time);
		//********************
	
		//*** Field stat_end_time ***
		$f_opts = array();
		$f_opts['id']="stat_end_time";
		
		$f_stat_end_time=new FieldSQLDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName(),"stat_end_time",$f_opts);
		$this->addField($f_stat_end_time);
		//********************
	
		//*** Field done_percent ***
		$f_opts = array();
		$f_opts['id']="done_percent";
		
		$f_done_percent=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"done_percent",$f_opts);
		$this->addField($f_done_percent);
		//********************
	
		//*** Field stat_time_to_go ***
		$f_opts = array();
		$f_opts['id']="stat_time_to_go";
		
		$f_stat_time_to_go=new FieldSQLInterval($this->getDbLink(),$this->getDbName(),$this->getTableName(),"stat_time_to_go",$f_opts);
		$this->addField($f_stat_time_to_go);
		//********************
	
		//*** Field stat_doc_id ***
		$f_opts = array();
		$f_opts['id']="stat_doc_id";
		
		$f_stat_doc_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"stat_doc_id",$f_opts);
		$this->addField($f_stat_doc_id);
		//********************
	
		//*** Field stat_doc_type ***
		$f_opts = array();
		$f_opts['id']="stat_doc_type";
		
		$f_stat_doc_type=new FieldSQLEnum($this->getDbLink(),$this->getDbName(),$this->getTableName(),"stat_doc_type",$f_opts);
		$this->addField($f_stat_doc_type);
		//********************
	
		//*** Field stat_error_message ***
		$f_opts = array();
		$f_opts['id']="stat_error_message";
		
		$f_stat_error_message=new FieldSQLText($this->getDbLink(),$this->getDbName(),$this->getTableName(),"stat_error_message",$f_opts);
		$this->addField($f_stat_error_message);
		//********************
	
		//*** Field stat_res ***
		$f_opts = array();
		$f_opts['id']="stat_res";
		
		$f_stat_res=new FieldSQLBool($this->getDbLink(),$this->getDbName(),$this->getTableName(),"stat_res",$f_opts);
		$this->addField($f_stat_res);
		//********************
	
		//*** Field stat_user_id ***
		$f_opts = array();
		$f_opts['id']="stat_user_id";
		
		$f_stat_user_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"stat_user_id",$f_opts);
		$this->addField($f_stat_user_id);
		//********************
	
		//*** Field stat_user_descr ***
		$f_opts = array();
		$f_opts['id']="stat_user_descr";
		
		$f_stat_user_descr=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"stat_user_descr",$f_opts);
		$this->addField($f_stat_user_descr);
		//********************
	
		//*** Field viol_date_time ***
		$f_opts = array();
		$f_opts['id']="viol_date_time";
		
		$f_viol_date_time=new FieldSQLDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName(),"viol_date_time",$f_opts);
		$this->addField($f_viol_date_time);
		//********************
	
		//*** Field viol_reprocessing ***
		$f_opts = array();
		$f_opts['id']="viol_reprocessing";
		
		$f_viol_reprocessing=new FieldSQLBool($this->getDbLink(),$this->getDbName(),$this->getTableName(),"viol_reprocessing",$f_opts);
		$this->addField($f_viol_reprocessing);
		//********************
	
		//*** Field violated ***
		$f_opts = array();
		$f_opts['id']="violated";
		
		$f_violated=new FieldSQLBool($this->getDbLink(),$this->getDbName(),$this->getTableName(),"violated",$f_opts);
		$this->addField($f_violated);
		//********************
$this->setLimitConstant('doc_per_page_count');
	}

}
?>
