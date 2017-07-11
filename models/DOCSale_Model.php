<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTime.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLBool.php');
require_once(FRAME_WORK_PATH.'basic_classes/ModelOrderSQL.php');

class DOCSale_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_sales");
			
		//*** Field id ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['autoInc']=TRUE;
		$f_opts['id']="id";
		
		$f_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"id",$f_opts);
		$this->addField($f_id);
		//********************
	
		//*** Field date_time ***
		$f_opts = array();
		$f_opts['id']="date_time";
		
		$f_date_time=new FieldSQLDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName(),"date_time",$f_opts);
		$this->addField($f_date_time);
		//********************
	
		//*** Field number ***
		$f_opts = array();
		$f_opts['id']="number";
		
		$f_number=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"number",$f_opts);
		$this->addField($f_number);
		//********************
	
		//*** Field processed ***
		$f_opts = array();
		$f_opts['id']="processed";
		
		$f_processed=new FieldSQLBool($this->getDbLink(),$this->getDbName(),$this->getTableName(),"processed",$f_opts);
		$this->addField($f_processed);
		//********************
	
		//*** Field store_id ***
		$f_opts = array();
		$f_opts['id']="store_id";
		
		$f_store_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"store_id",$f_opts);
		$this->addField($f_store_id);
		//********************
	
		//*** Field user_id ***
		$f_opts = array();
		$f_opts['id']="user_id";
		
		$f_user_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"user_id",$f_opts);
		$this->addField($f_user_id);
		//********************
	
		//*** Field payment_type_for_sale_id ***
		$f_opts = array();
		$f_opts['id']="payment_type_for_sale_id";
		
		$f_payment_type_for_sale_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"payment_type_for_sale_id",$f_opts);
		$this->addField($f_payment_type_for_sale_id);
		//********************
	
		//*** Field total ***
		$f_opts = array();
		$f_opts['length']=15;
		$f_opts['id']="total";
		
		$f_total=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"total",$f_opts);
		$this->addField($f_total);
		//********************
	
		//*** Field total_material_cost ***
		$f_opts = array();
		$f_opts['length']=15;
		$f_opts['id']="total_material_cost";
		
		$f_total_material_cost=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"total_material_cost",$f_opts);
		$this->addField($f_total_material_cost);
		//********************
	
		//*** Field total_product_cost ***
		$f_opts = array();
		$f_opts['length']=15;
		$f_opts['id']="total_product_cost";
		
		$f_total_product_cost=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"total_product_cost",$f_opts);
		$this->addField($f_total_product_cost);
		//********************
	
		//*** Field client_id ***
		$f_opts = array();
		$f_opts['id']="client_id";
		
		$f_client_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"client_id",$f_opts);
		$this->addField($f_client_id);
		//********************
	
		//*** Field discount_id ***
		$f_opts = array();
		$f_opts['id']="discount_id";
		
		$f_discount_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"discount_id",$f_opts);
		$this->addField($f_discount_id);
		//********************

		$order = new ModelOrderSQL();		
		$this->setDefaultModelOrder($order);		
		
		$order->addField($f_date_time);
$this->setLimitConstant('doc_per_page_count');
		$this->setLastRowSelectOnInit(TRUE);
	}

}
?>
