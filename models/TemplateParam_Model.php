<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLText.php');
require_once(FRAME_WORK_PATH.'basic_classes/ModelOrderSQL.php');

class TemplateParam_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("template_params");
			
		//*** Field id ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['autoInc']=TRUE;
		$f_opts['id']="id";
		
		$f_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"id",$f_opts);
		$this->addField($f_id);
		//********************
	
		//*** Field template ***
		$f_opts = array();
		$f_opts['id']="template";
		
		$f_template=new FieldSQLText($this->getDbLink(),$this->getDbName(),$this->getTableName(),"template",$f_opts);
		$this->addField($f_template);
		//********************
	
		//*** Field param ***
		$f_opts = array();
		$f_opts['id']="param";
		
		$f_param=new FieldSQLText($this->getDbLink(),$this->getDbName(),$this->getTableName(),"param",$f_opts);
		$this->addField($f_param);
		//********************
	
		//*** Field param_type ***
		$f_opts = array();
		$f_opts['id']="param_type";
		
		$f_param_type=new FieldSQLText($this->getDbLink(),$this->getDbName(),$this->getTableName(),"param_type",$f_opts);
		$this->addField($f_param_type);
		//********************

		$order = new ModelOrderSQL();		
		$this->setDefaultModelOrder($order);		
		
		$order->addField($f_template);

		$order->addField($f_param);
$this->setLimitConstant('doc_per_page_count');
	}

}
?>
