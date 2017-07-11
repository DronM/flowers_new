<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTime.php');

class DOCSaleList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_sales_list_view");
			
		//*** Field id ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['sysCol']=TRUE;
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
		
		$f_number=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"number",$f_opts);
		$this->addField($f_number);
		//********************
	
		//*** Field processed ***
		$f_opts = array();
		$f_opts['id']="processed";
		
		$f_processed=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"processed",$f_opts);
		$this->addField($f_processed);
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
	
		//*** Field user_id ***
		$f_opts = array();
		$f_opts['sysCol']=TRUE;
		$f_opts['id']="user_id";
		
		$f_user_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"user_id",$f_opts);
		$this->addField($f_user_id);
		//********************
	
		//*** Field user_descr ***
		$f_opts = array();
		$f_opts['id']="user_descr";
		
		$f_user_descr=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"user_descr",$f_opts);
		$this->addField($f_user_descr);
		//********************
	
		//*** Field payment_type_for_sale_id ***
		$f_opts = array();
		$f_opts['sysCol']=TRUE;
		$f_opts['id']="payment_type_for_sale_id";
		
		$f_payment_type_for_sale_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"payment_type_for_sale_id",$f_opts);
		$this->addField($f_payment_type_for_sale_id);
		//********************
	
		//*** Field payment_type_for_sale_descr ***
		$f_opts = array();
		$f_opts['id']="payment_type_for_sale_descr";
		
		$f_payment_type_for_sale_descr=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"payment_type_for_sale_descr",$f_opts);
		$this->addField($f_payment_type_for_sale_descr);
		//********************
	
		//*** Field client_id ***
		$f_opts = array();
		$f_opts['sysCol']=TRUE;
		$f_opts['id']="client_id";
		
		$f_client_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"client_id",$f_opts);
		$this->addField($f_client_id);
		//********************
	
		//*** Field client_descr ***
		$f_opts = array();
		$f_opts['id']="client_descr";
		
		$f_client_descr=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"client_descr",$f_opts);
		$this->addField($f_client_descr);
		//********************
	
		//*** Field delivery ***
		$f_opts = array();
		$f_opts['id']="delivery";
		
		$f_delivery=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"delivery",$f_opts);
		$this->addField($f_delivery);
		//********************
	
		//*** Field total ***
		$f_opts = array();
		$f_opts['id']="total";
		
		$f_total=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"total",$f_opts);
		$this->addField($f_total);
		//********************
	
		//*** Field cost ***
		$f_opts = array();
		$f_opts['id']="cost";
		
		$f_cost=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"cost",$f_opts);
		$this->addField($f_cost);
		//********************
	
		//*** Field income ***
		$f_opts = array();
		$f_opts['id']="income";
		
		$f_income=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"income",$f_opts);
		$this->addField($f_income);
		//********************
	
		//*** Field income_percent ***
		$f_opts = array();
		$f_opts['id']="income_percent";
		
		$f_income_percent=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"income_percent",$f_opts);
		$this->addField($f_income_percent);
		//********************
$this->setLimitConstant('doc_per_page_count');
		$this->setLastRowSelectOnInit(TRUE);
	$this->addAggFunction(
		array('alias'=>'total_total','expr'=>'sum(total)')
,array('alias'=>'total_cost','expr'=>'sum(cost)')
,array('alias'=>'avg_income','expr'=>'avg(income)')
,array('alias'=>'avg_income_percent','expr'=>'avg(income_percent)')

	);	

	}

}
?>
