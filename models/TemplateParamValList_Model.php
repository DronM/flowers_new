<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLText.php');

class TemplateParamValList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("");
			
		//*** Field param ***
		$f_opts = array();
		$f_opts['id']="param";
		
		$f_param=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"param",$f_opts);
		$this->addField($f_param);
		//********************
	
		//*** Field val ***
		$f_opts = array();
		$f_opts['id']="val";
		
		$f_val=new FieldSQLText($this->getDbLink(),$this->getDbName(),$this->getTableName(),"val",$f_opts);
		$this->addField($f_val);
		//********************
$this->setLimitConstant('doc_per_page_count');
	}

}
?>
