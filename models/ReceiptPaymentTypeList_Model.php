<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');

class ReceiptPaymentTypeList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("receipt_payment_types_list");
			
		//*** Field dt ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['id']="dt";
		
		$f_dt=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"dt",$f_opts);
		$this->addField($f_dt);
		//********************
	
		//*** Field kkm_type_close ***
		$f_opts = array();
		$f_opts['id']="kkm_type_close";
		
		$f_kkm_type_close=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"kkm_type_close",$f_opts);
		$this->addField($f_kkm_type_close);
		//********************
	
		//*** Field payment_type_for_sale_id ***
		$f_opts = array();
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
	
		//*** Field total ***
		$f_opts = array();
		$f_opts['length']=2;
		$f_opts['id']="total";
		
		$f_total=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"total",$f_opts);
		$this->addField($f_total);
		//********************
	
		//*** Field user_id ***
		$f_opts = array();
		$f_opts['id']="user_id";
		
		$f_user_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"user_id",$f_opts);
		$this->addField($f_user_id);
		//********************
$this->setLimitConstant('doc_per_page_count');
	}

}
?>
