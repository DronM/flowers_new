<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLEnum.php');
require_once(FRAME_WORK_PATH.'basic_classes/ModelOrderSQL.php');

class PaymentTypeForSale_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("payment_types_for_sale");
			
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
	
		//*** Field client_order_payment_type ***
		$f_opts = array();
		$f_opts['id']="client_order_payment_type";
		
		$f_client_order_payment_type=new FieldSQLEnum($this->getDbLink(),$this->getDbName(),$this->getTableName(),"client_order_payment_type",$f_opts);
		$this->addField($f_client_order_payment_type);
		//********************
	
		//*** Field kkm_type_close ***
		$f_opts = array();
		$f_opts['id']="kkm_type_close";
		
		$f_kkm_type_close=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"kkm_type_close",$f_opts);
		$this->addField($f_kkm_type_close);
		//********************

		$order = new ModelOrderSQL();		
		$this->setDefaultModelOrder($order);		
		
		$order->addField($f_name);
$this->setLimitConstant('doc_per_page_count');
	}

}
?>
