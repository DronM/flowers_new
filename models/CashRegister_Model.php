<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/ModelOrderSQL.php');

class CashRegister_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("cash_registers");
			
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
		$f_opts['length']=200;
		$f_opts['id']="name";
		
		$f_name=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"name",$f_opts);
		$this->addField($f_name);
		//********************
	
		//*** Field port ***
		$f_opts = array();
		$f_opts['id']="port";
		
		$f_port=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"port",$f_opts);
		$this->addField($f_port);
		//********************
	
		//*** Field baud_rate ***
		$f_opts = array();
		$f_opts['id']="baud_rate";
		
		$f_baud_rate=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"baud_rate",$f_opts);
		$this->addField($f_baud_rate);
		//********************
	
		//*** Field eq_server ***
		$f_opts = array();
		$f_opts['length']=20;
		$f_opts['id']="eq_server";
		
		$f_eq_server=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"eq_server",$f_opts);
		$this->addField($f_eq_server);
		//********************
	
		//*** Field eq_port ***
		$f_opts = array();
		$f_opts['id']="eq_port";
		
		$f_eq_port=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"eq_port",$f_opts);
		$this->addField($f_eq_port);
		//********************
	
		//*** Field eq_id ***
		$f_opts = array();
		$f_opts['length']=20;
		$f_opts['id']="eq_id";
		
		$f_eq_id=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"eq_id",$f_opts);
		$this->addField($f_eq_id);
		//********************

		$order = new ModelOrderSQL();		
		$this->setDefaultModelOrder($order);		
		
		$order->addField($f_name);
$this->setLimitConstant('doc_per_page_count');
	}

}
?>
