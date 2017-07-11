<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');

class DiscountList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("discounts_list");
			
		//*** Field id ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['id']="id";
		
		$f_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"id",$f_opts);
		$this->addField($f_id);
		//********************
	
		//*** Field descr ***
		$f_opts = array();
		$f_opts['id']="descr";
		
		$f_descr=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"descr",$f_opts);
		$this->addField($f_descr);
		//********************
	
		//*** Field percent ***
		$f_opts = array();
		$f_opts['id']="percent";
		
		$f_percent=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"percent",$f_opts);
		$this->addField($f_percent);
		//********************
$this->setLimitConstant('doc_per_page_count');
	}

}
?>
