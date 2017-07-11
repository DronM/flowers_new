<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLText.php');

class DiscCard_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("disc_cards");
			
		//*** Field id ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['autoInc']=TRUE;
		$f_opts['id']="id";
		
		$f_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"id",$f_opts);
		$this->addField($f_id);
		//********************
	
		//*** Field discount_id ***
		$f_opts = array();
		$f_opts['id']="discount_id";
		
		$f_discount_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"discount_id",$f_opts);
		$this->addField($f_discount_id);
		//********************
	
		//*** Field barcode ***
		$f_opts = array();
		$f_opts['id']="barcode";
		
		$f_barcode=new FieldSQLText($this->getDbLink(),$this->getDbName(),$this->getTableName(),"barcode",$f_opts);
		$this->addField($f_barcode);
		//********************
$this->setLimitConstant('doc_per_page_count');
	}

}
?>
