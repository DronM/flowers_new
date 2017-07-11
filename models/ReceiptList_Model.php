<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');

class ReceiptList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("receipts_list_view");
			
		//*** Field user_id ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['id']="user_id";
		
		$f_user_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"user_id",$f_opts);
		$this->addField($f_user_id);
		//********************
	
		//*** Field item_id ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['id']="item_id";
		
		$f_item_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"item_id",$f_opts);
		$this->addField($f_item_id);
		//********************
	
		//*** Field item_type ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['id']="item_type";
		
		$f_item_type=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"item_type",$f_opts);
		$this->addField($f_item_type);
		//********************
	
		//*** Field doc_production_id ***
		$f_opts = array();
		$f_opts['id']="doc_production_id";
		
		$f_doc_production_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"doc_production_id",$f_opts);
		$this->addField($f_doc_production_id);
		//********************
	
		//*** Field item_name ***
		$f_opts = array();
		$f_opts['length']=100;
		$f_opts['id']="item_name";
		
		$f_item_name=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"item_name",$f_opts);
		$this->addField($f_item_name);
		//********************
	
		//*** Field quant ***
		$f_opts = array();
		$f_opts['length']=19;
		$f_opts['id']="quant";
		
		$f_quant=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"quant",$f_opts);
		$this->addField($f_quant);
		//********************
	
		//*** Field price ***
		$f_opts = array();
		$f_opts['length']=15;
		$f_opts['id']="price";
		
		$f_price=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"price",$f_opts);
		$this->addField($f_price);
		//********************
	
		//*** Field total ***
		$f_opts = array();
		$f_opts['length']=15;
		$f_opts['id']="total";
		
		$f_total=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"total",$f_opts);
		$this->addField($f_total);
		//********************
	
		//*** Field total_no_disc ***
		$f_opts = array();
		$f_opts['length']=15;
		$f_opts['id']="total_no_disc";
		
		$f_total_no_disc=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"total_no_disc",$f_opts);
		$this->addField($f_total_no_disc);
		//********************
	
		//*** Field price_no_disc ***
		$f_opts = array();
		$f_opts['length']=15;
		$f_opts['id']="price_no_disc";
		
		$f_price_no_disc=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"price_no_disc",$f_opts);
		$this->addField($f_price_no_disc);
		//********************
	
		//*** Field disc_percent ***
		$f_opts = array();
		$f_opts['length']=15;
		$f_opts['id']="disc_percent";
		
		$f_disc_percent=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"disc_percent",$f_opts);
		$this->addField($f_disc_percent);
		//********************
$this->setLimitConstant('doc_per_page_count');
	}

}
?>
