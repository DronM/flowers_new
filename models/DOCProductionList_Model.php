<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLText.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTime.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLBool.php');

class DOCProductionList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_productions_list_view");
			
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
	
		//*** Field processed ***
		$f_opts = array();
		$f_opts['id']="processed";
		
		$f_processed=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"processed",$f_opts);
		$this->addField($f_processed);
		//********************
	
		//*** Field on_norm ***
		$f_opts = array();
		$f_opts['id']="on_norm";
		
		$f_on_norm=new FieldSQLBool($this->getDbLink(),$this->getDbName(),$this->getTableName(),"on_norm",$f_opts);
		$this->addField($f_on_norm);
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
	
		//*** Field material_retail_cost ***
		$f_opts = array();
		$f_opts['length']=15;
		$f_opts['id']="material_retail_cost";
		
		$f_material_retail_cost=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"material_retail_cost",$f_opts);
		$this->addField($f_material_retail_cost);
		//********************
	
		//*** Field material_cost ***
		$f_opts = array();
		$f_opts['length']=15;
		$f_opts['id']="material_cost";
		
		$f_material_cost=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"material_cost",$f_opts);
		$this->addField($f_material_cost);
		//********************
	
		//*** Field income_percent ***
		$f_opts = array();
		$f_opts['length']=15;
		$f_opts['id']="income_percent";
		
		$f_income_percent=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"income_percent",$f_opts);
		$this->addField($f_income_percent);
		//********************
	
		//*** Field income ***
		$f_opts = array();
		$f_opts['length']=15;
		$f_opts['id']="income";
		
		$f_income=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"income",$f_opts);
		$this->addField($f_income);
		//********************
	
		//*** Field florist_comment ***
		$f_opts = array();
		$f_opts['id']="florist_comment";
		
		$f_florist_comment=new FieldSQLText($this->getDbLink(),$this->getDbName(),$this->getTableName(),"florist_comment",$f_opts);
		$this->addField($f_florist_comment);
		//********************
	
		//*** Field after_prod_interval ***
		$f_opts = array();
		$f_opts['id']="after_prod_interval";
		
		$f_after_prod_interval=new FieldSQLText($this->getDbLink(),$this->getDbName(),$this->getTableName(),"after_prod_interval",$f_opts);
		$this->addField($f_after_prod_interval);
		//********************
	
		//*** Field doc_descr ***
		$f_opts = array();
		$f_opts['id']="doc_descr";
		
		$f_doc_descr=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"doc_descr",$f_opts);
		$this->addField($f_doc_descr);
		//********************
$this->setLimitConstant('doc_per_page_count');
		$this->setLastRowSelectOnInit(TRUE);
	}

}
?>
