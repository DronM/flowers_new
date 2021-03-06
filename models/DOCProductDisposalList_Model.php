<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTime.php');

class DOCProductDisposalList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_product_disposals_list_view");
			
		//*** Field id ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['sysCol']=TRUE;
		$f_opts['id']="id";
		
		$f_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"id",$f_opts);
		$this->addField($f_id);
		//********************
	
		//*** Field number ***
		$f_opts = array();
		$f_opts['id']="number";
		
		$f_number=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"number",$f_opts);
		$this->addField($f_number);
		//********************
	
		//*** Field date_time ***
		$f_opts = array();
		$f_opts['sysCol']=TRUE;
		$f_opts['id']="date_time";
		
		$f_date_time=new FieldSQLDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName(),"date_time",$f_opts);
		$this->addField($f_date_time);
		//********************
	
		//*** Field date_time_descr ***
		$f_opts = array();
		$f_opts['id']="date_time_descr";
		
		$f_date_time_descr=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"date_time_descr",$f_opts);
		$this->addField($f_date_time_descr);
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
	
		//*** Field product_id ***
		$f_opts = array();
		$f_opts['sysCol']=TRUE;
		$f_opts['id']="product_id";
		
		$f_product_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"product_id",$f_opts);
		$this->addField($f_product_id);
		//********************
	
		//*** Field product_descr ***
		$f_opts = array();
		$f_opts['id']="product_descr";
		
		$f_product_descr=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"product_descr",$f_opts);
		$this->addField($f_product_descr);
		//********************
	
		//*** Field explanation ***
		$f_opts = array();
		$f_opts['id']="explanation";
		
		$f_explanation=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"explanation",$f_opts);
		$this->addField($f_explanation);
		//********************
	
		//*** Field doc_production_descr ***
		$f_opts = array();
		$f_opts['id']="doc_production_descr";
		
		$f_doc_production_descr=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"doc_production_descr",$f_opts);
		$this->addField($f_doc_production_descr);
		//********************
	
		//*** Field doc_production_id ***
		$f_opts = array();
		$f_opts['sysCol']=TRUE;
		$f_opts['id']="doc_production_id";
		
		$f_doc_production_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"doc_production_id",$f_opts);
		$this->addField($f_doc_production_id);
		//********************
	
		//*** Field doc_production_number ***
		$f_opts = array();
		$f_opts['id']="doc_production_number";
		
		$f_doc_production_number=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"doc_production_number",$f_opts);
		$this->addField($f_doc_production_number);
		//********************
	
		//*** Field doc_production_date_time ***
		$f_opts = array();
		$f_opts['id']="doc_production_date_time";
		
		$f_doc_production_date_time=new FieldSQLDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName(),"doc_production_date_time",$f_opts);
		$this->addField($f_doc_production_date_time);
		//********************
$this->setLimitConstant('doc_per_page_count');
		$this->setLastRowSelectOnInit(TRUE);
	}

}
?>
