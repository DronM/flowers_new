<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');

class ClientList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("client_list_view");
			
		//*** Field id ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['autoInc']=TRUE;
		$f_opts['id']="id";
		
		$f_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"id",$f_opts);
		$this->addField($f_id);
		//********************
	
		//*** Field name ***
		$f_opts = array();
		$f_opts['length']=100;
		$f_opts['id']="name";
		
		$f_name=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"name",$f_opts);
		$this->addField($f_name);
		//********************
	
		//*** Field tel ***
		$f_opts = array();
		$f_opts['id']="tel";
		
		$f_tel=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"tel",$f_opts);
		$this->addField($f_tel);
		//********************
	
		//*** Field disc_card_percent ***
		$f_opts = array();
		$f_opts['id']="disc_card_percent";
		
		$f_disc_card_percent=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"disc_card_percent",$f_opts);
		$this->addField($f_disc_card_percent);
		//********************
	
		//*** Field disc_card_id ***
		$f_opts = array();
		$f_opts['id']="disc_card_id";
		
		$f_disc_card_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"disc_card_id",$f_opts);
		$this->addField($f_disc_card_id);
		//********************
	
		//*** Field discount_id ***
		$f_opts = array();
		$f_opts['id']="discount_id";
		
		$f_discount_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"discount_id",$f_opts);
		$this->addField($f_discount_id);
		//********************
$this->setLimitConstant('doc_per_page_count');
	}

}
?>
