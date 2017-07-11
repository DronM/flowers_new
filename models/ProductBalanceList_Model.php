<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTime.php');

class ProductBalanceList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("products_balance_list");
			
		//*** Field id ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['sysCol']=TRUE;
		$f_opts['id']="id";
		
		$f_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"id",$f_opts);
		$this->addField($f_id);
		//********************
	
		//*** Field code ***
		$f_opts = array();
		$f_opts['id']="code";
		
		$f_code=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"code",$f_opts);
		$this->addField($f_code);
		//********************
	
		//*** Field name ***
		$f_opts = array();
		$f_opts['id']="name";
		
		$f_name=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"name",$f_opts);
		$this->addField($f_name);
		//********************
	
		//*** Field price ***
		$f_opts = array();
		$f_opts['id']="price";
		
		$f_price=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"price",$f_opts);
		$this->addField($f_price);
		//********************
	
		//*** Field total ***
		$f_opts = array();
		$f_opts['id']="total";
		
		$f_total=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"total",$f_opts);
		$this->addField($f_total);
		//********************
	
		//*** Field quant ***
		$f_opts = array();
		$f_opts['id']="quant";
		
		$f_quant=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"quant",$f_opts);
		$this->addField($f_quant);
		//********************
	
		//*** Field order_quant ***
		$f_opts = array();
		$f_opts['sysCol']=TRUE;
		$f_opts['id']="order_quant";
		
		$f_order_quant=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"order_quant",$f_opts);
		$this->addField($f_order_quant);
		//********************
	
		//*** Field store_id ***
		$f_opts = array();
		$f_opts['sysCol']=TRUE;
		$f_opts['id']="store_id";
		
		$f_store_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"store_id",$f_opts);
		$this->addField($f_store_id);
		//********************
	
		//*** Field store_descr ***
		$f_opts = array();
		$f_opts['id']="store_descr";
		
		$f_store_descr=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"store_descr",$f_opts);
		$this->addField($f_store_descr);
		//********************
	
		//*** Field after_production_time ***
		$f_opts = array();
		$f_opts['id']="after_production_time";
		
		$f_after_production_time=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"after_production_time",$f_opts);
		$this->addField($f_after_production_time);
		//********************
	
		//*** Field doc_production_id ***
		$f_opts = array();
		$f_opts['id']="doc_production_id";
		
		$f_doc_production_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"doc_production_id",$f_opts);
		$this->addField($f_doc_production_id);
		//********************
	
		//*** Field doc_production_number ***
		$f_opts = array();
		$f_opts['id']="doc_production_number";
		
		$f_doc_production_number=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"doc_production_number",$f_opts);
		$this->addField($f_doc_production_number);
		//********************
	
		//*** Field doc_production_date_time ***
		$f_opts = array();
		$f_opts['id']="doc_production_date_time";
		
		$f_doc_production_date_time=new FieldSQLDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName(),"doc_production_date_time",$f_opts);
		$this->addField($f_doc_production_date_time);
		//********************
$this->setLimitConstant('doc_per_page_count');
	}

}
?>
