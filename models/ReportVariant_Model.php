<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLText.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLEnum.php');

class ReportVariant_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("report_variants");
			
		//*** Field id ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['autoInc']=TRUE;
		$f_opts['id']="id";
		
		$f_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"id",$f_opts);
		$this->addField($f_id);
		//********************
	
		//*** Field user_id ***
		$f_opts = array();
		$f_opts['id']="user_id";
		
		$f_user_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"user_id",$f_opts);
		$this->addField($f_user_id);
		//********************
	
		//*** Field report_type ***
		$f_opts = array();
		$f_opts['id']="report_type";
		
		$f_report_type=new FieldSQLEnum($this->getDbLink(),$this->getDbName(),$this->getTableName(),"report_type",$f_opts);
		$this->addField($f_report_type);
		//********************
	
		//*** Field name ***
		$f_opts = array();
		$f_opts['id']="name";
		
		$f_name=new FieldSQLText($this->getDbLink(),$this->getDbName(),$this->getTableName(),"name",$f_opts);
		$this->addField($f_name);
		//********************
	
		//*** Field data ***
		$f_opts = array();
		$f_opts['id']="data";
		
		$f_data=new FieldSQLText($this->getDbLink(),$this->getDbName(),$this->getTableName(),"data",$f_opts);
		$this->addField($f_data);
		//********************
$this->setLimitConstant('doc_per_page_count');
	}

}
?>
