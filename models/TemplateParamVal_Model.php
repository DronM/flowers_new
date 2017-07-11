<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLText.php');

class TemplateParamVal_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("template_param_vals");
			
		//*** Field id ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['autoInc']=TRUE;
		$f_opts['id']="id";
		
		$f_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"id",$f_opts);
		$this->addField($f_id);
		//********************
	
		//*** Field template_param_id ***
		$f_opts = array();
		$f_opts['id']="template_param_id";
		
		$f_template_param_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"template_param_id",$f_opts);
		$this->addField($f_template_param_id);
		//********************
	
		//*** Field user_id ***
		$f_opts = array();
		$f_opts['id']="user_id";
		
		$f_user_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"user_id",$f_opts);
		$this->addField($f_user_id);
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
