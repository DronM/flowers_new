<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLText.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDate.php');

class DOCExpenceDOCTFExpenceType_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_expences_t_expence_types");
			
		//*** Field doc_id ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['id']="doc_id";
		
		$f_doc_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"doc_id",$f_opts);
		$this->addField($f_doc_id);
		//********************
	
		//*** Field line_number ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['id']="line_number";
		
		$f_line_number=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"line_number",$f_opts);
		$this->addField($f_line_number);
		//********************
	
		//*** Field expence_type_id ***
		$f_opts = array();
		$f_opts['id']="expence_type_id";
		
		$f_expence_type_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"expence_type_id",$f_opts);
		$this->addField($f_expence_type_id);
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
