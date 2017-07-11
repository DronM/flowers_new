<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQLDOCT20.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLText.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDate.php');

class DOCExpenceDOCTExpenceType_Model extends ModelSQLDOCT20{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_expences_t_tmp_expence_types");
			
		//*** Field view_id ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['length']=32;
		$f_opts['id']="view_id";
		
		$f_view_id=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"view_id",$f_opts);
		$this->addField($f_view_id);
		//********************
	
		//*** Field line_number ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['id']="line_number";
		
		$f_line_number=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"line_number",$f_opts);
		$this->addField($f_line_number);
		//********************
	
		//*** Field login_id ***
		$f_opts = array();
		$f_opts['id']="login_id";
		
		$f_login_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"login_id",$f_opts);
		$this->addField($f_login_id);
		//********************
	
		//*** Field expence_type_id ***
		$f_opts = array();
		$f_opts['id']="expence_type_id";
		
		$f_expence_type_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"expence_type_id",$f_opts);
		$this->addField($f_expence_type_id);
		//********************
	
		//*** Field total ***
		$f_opts = array();
		$f_opts['length']=15;
		$f_opts['id']="total";
		
		$f_total=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"total",$f_opts);
		$this->addField($f_total);
		//********************
	
		//*** Field expence_comment ***
		$f_opts = array();
		$f_opts['id']="expence_comment";
		
		$f_expence_comment=new FieldSQLText($this->getDbLink(),$this->getDbName(),$this->getTableName(),"expence_comment",$f_opts);
		$this->addField($f_expence_comment);
		//********************
	
		//*** Field expence_date ***
		$f_opts = array();
		$f_opts['id']="expence_date";
		
		$f_expence_date=new FieldSQLDate($this->getDbLink(),$this->getDbName(),$this->getTableName(),"expence_date",$f_opts);
		$this->addField($f_expence_date);
		//********************
$this->setLimitConstant('doc_per_page_count');
	}

}
?>
