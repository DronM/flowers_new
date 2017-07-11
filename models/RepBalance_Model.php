<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelReportSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDate.php');

class RepBalance_Model extends ModelReportSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("rep_balance");
			
		//*** Field store_id ***
		$f_opts = array();
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
	
		//*** Field period ***
		$f_opts = array();
		$f_opts['id']="period";
		
		$f_period=new FieldSQLDate($this->getDbLink(),$this->getDbName(),$this->getTableName(),"period",$f_opts);
		$this->addField($f_period);
		//********************
	
		//*** Field mon ***
		$f_opts = array();
		$f_opts['id']="mon";
		
		$f_mon=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"mon",$f_opts);
		$this->addField($f_mon);
		//********************
	
		//*** Field expence_type_id ***
		$f_opts = array();
		$f_opts['sysCol']=TRUE;
		$f_opts['id']="expence_type_id";
		
		$f_expence_type_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"expence_type_id",$f_opts);
		$this->addField($f_expence_type_id);
		//********************
	
		//*** Field expence_type_descr ***
		$f_opts = array();
		$f_opts['id']="expence_type_descr";
		
		$f_expence_type_descr=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"expence_type_descr",$f_opts);
		$this->addField($f_expence_type_descr);
		//********************
	
		//*** Field total_expences ***
		$f_opts = array();
		$f_opts['length']=12;
		$f_opts['id']="total_expences";
		
		$f_total_expences=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"total_expences",$f_opts);
		$this->addField($f_total_expences);
		//********************
	
		//*** Field total_sales ***
		$f_opts = array();
		$f_opts['length']=12;
		$f_opts['id']="total_sales";
		
		$f_total_sales=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"total_sales",$f_opts);
		$this->addField($f_total_sales);
		//********************
	
		//*** Field total_mat_disp ***
		$f_opts = array();
		$f_opts['length']=12;
		$f_opts['id']="total_mat_disp";
		
		$f_total_mat_disp=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"total_mat_disp",$f_opts);
		$this->addField($f_total_mat_disp);
		//********************
	
		//*** Field total_mat_cost ***
		$f_opts = array();
		$f_opts['length']=12;
		$f_opts['id']="total_mat_cost";
		
		$f_total_mat_cost=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"total_mat_cost",$f_opts);
		$this->addField($f_total_mat_cost);
		//********************
$this->setLimitConstant('doc_per_page_count');
	}

}
?>
