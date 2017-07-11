<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLText.php');

class DOCExpenceDOCTFExpenceTypeList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_expences_t_expence_types_list");
			
		//*** Field line_number ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['id']="line_number";
		
		$f_line_number=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"line_number",$f_opts);
		$this->addField($f_line_number);
		//********************
	
		//*** Field login_id ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['id']="login_id";
		
		$f_login_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"login_id",$f_opts);
		$this->addField($f_login_id);
		//********************
	
		//*** Field expence_type_descr ***
		$f_opts = array();
		$f_opts['id']="expence_type_descr";
		
		$f_expence_type_descr=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"expence_type_descr",$f_opts);
		$this->addField($f_expence_type_descr);
		//********************
	
		//*** Field expence_comment ***
		$f_opts = array();
		$f_opts['id']="expence_comment";
		
		$f_expence_comment=new FieldSQLText($this->getDbLink(),$this->getDbName(),$this->getTableName(),"expence_comment",$f_opts);
		$this->addField($f_expence_comment);
		//********************
$this->setLimitConstant('doc_per_page_count');
	}

}
?>
