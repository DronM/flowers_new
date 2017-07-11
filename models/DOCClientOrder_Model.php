<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLText.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLEnum.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTime.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDate.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLBool.php');
require_once(FRAME_WORK_PATH.'basic_classes/ModelOrderSQL.php');

class DOCClientOrder_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_client_orders");
			
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
	
		//*** Field number_from_site ***
		$f_opts = array();
		$f_opts['length']=10;
		$f_opts['id']="number_from_site";
		
		$f_number_from_site=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"number_from_site",$f_opts);
		$this->addField($f_number_from_site);
		//********************
	
		//*** Field processed ***
		$f_opts = array();
		$f_opts['id']="processed";
		
		$f_processed=new FieldSQLBool($this->getDbLink(),$this->getDbName(),$this->getTableName(),"processed",$f_opts);
		$this->addField($f_processed);
		//********************
	
		//*** Field delivery_type ***
		$f_opts = array();
		$f_opts['id']="delivery_type";
		
		$f_delivery_type=new FieldSQLEnum($this->getDbLink(),$this->getDbName(),$this->getTableName(),"delivery_type",$f_opts);
		$this->addField($f_delivery_type);
		//********************
	
		//*** Field client_name ***
		$f_opts = array();
		$f_opts['length']=200;
		$f_opts['id']="client_name";
		
		$f_client_name=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"client_name",$f_opts);
		$this->addField($f_client_name);
		//********************
	
		//*** Field client_tel ***
		$f_opts = array();
		$f_opts['length']=15;
		$f_opts['id']="client_tel";
		
		$f_client_tel=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"client_tel",$f_opts);
		$this->addField($f_client_tel);
		//********************
	
		//*** Field recipient_type ***
		$f_opts = array();
		$f_opts['id']="recipient_type";
		
		$f_recipient_type=new FieldSQLEnum($this->getDbLink(),$this->getDbName(),$this->getTableName(),"recipient_type",$f_opts);
		$this->addField($f_recipient_type);
		//********************
	
		//*** Field recipient_name ***
		$f_opts = array();
		$f_opts['length']=200;
		$f_opts['id']="recipient_name";
		
		$f_recipient_name=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"recipient_name",$f_opts);
		$this->addField($f_recipient_name);
		//********************
	
		//*** Field recipient_tel ***
		$f_opts = array();
		$f_opts['length']=15;
		$f_opts['id']="recipient_tel";
		
		$f_recipient_tel=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"recipient_tel",$f_opts);
		$this->addField($f_recipient_tel);
		//********************
	
		//*** Field address ***
		$f_opts = array();
		$f_opts['id']="address";
		
		$f_address=new FieldSQLText($this->getDbLink(),$this->getDbName(),$this->getTableName(),"address",$f_opts);
		$this->addField($f_address);
		//********************
	
		//*** Field delivery_date ***
		$f_opts = array();
		$f_opts['id']="delivery_date";
		
		$f_delivery_date=new FieldSQLDate($this->getDbLink(),$this->getDbName(),$this->getTableName(),"delivery_date",$f_opts);
		$this->addField($f_delivery_date);
		//********************
	
		//*** Field delivery_hour_id ***
		$f_opts = array();
		$f_opts['id']="delivery_hour_id";
		
		$f_delivery_hour_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"delivery_hour_id",$f_opts);
		$this->addField($f_delivery_hour_id);
		//********************
	
		//*** Field delivery_comment ***
		$f_opts = array();
		$f_opts['length']=100;
		$f_opts['id']="delivery_comment";
		
		$f_delivery_comment=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"delivery_comment",$f_opts);
		$this->addField($f_delivery_comment);
		//********************
	
		//*** Field card ***
		$f_opts = array();
		$f_opts['id']="card";
		
		$f_card=new FieldSQLBool($this->getDbLink(),$this->getDbName(),$this->getTableName(),"card",$f_opts);
		$this->addField($f_card);
		//********************
	
		//*** Field card_text ***
		$f_opts = array();
		$f_opts['id']="card_text";
		
		$f_card_text=new FieldSQLText($this->getDbLink(),$this->getDbName(),$this->getTableName(),"card_text",$f_opts);
		$this->addField($f_card_text);
		//********************
	
		//*** Field anonym_gift ***
		$f_opts = array();
		$f_opts['id']="anonym_gift";
		
		$f_anonym_gift=new FieldSQLBool($this->getDbLink(),$this->getDbName(),$this->getTableName(),"anonym_gift",$f_opts);
		$this->addField($f_anonym_gift);
		//********************
	
		//*** Field delivery_note_type ***
		$f_opts = array();
		$f_opts['id']="delivery_note_type";
		
		$f_delivery_note_type=new FieldSQLEnum($this->getDbLink(),$this->getDbName(),$this->getTableName(),"delivery_note_type",$f_opts);
		$this->addField($f_delivery_note_type);
		//********************
	
		//*** Field extra_comment ***
		$f_opts = array();
		$f_opts['id']="extra_comment";
		
		$f_extra_comment=new FieldSQLText($this->getDbLink(),$this->getDbName(),$this->getTableName(),"extra_comment",$f_opts);
		$this->addField($f_extra_comment);
		//********************
	
		//*** Field payment_type ***
		$f_opts = array();
		$f_opts['id']="payment_type";
		
		$f_payment_type=new FieldSQLEnum($this->getDbLink(),$this->getDbName(),$this->getTableName(),"payment_type",$f_opts);
		$this->addField($f_payment_type);
		//********************
	
		//*** Field client_order_state ***
		$f_opts = array();
		$f_opts['defaultValue']=to_noone;
		$f_opts['id']="client_order_state";
		
		$f_client_order_state=new FieldSQLEnum($this->getDbLink(),$this->getDbName(),$this->getTableName(),"client_order_state",$f_opts);
		$this->addField($f_client_order_state);
		//********************
	
		//*** Field payed ***
		$f_opts = array();
		$f_opts['defaultValue']=FALSE;
		$f_opts['id']="payed";
		
		$f_payed=new FieldSQLBool($this->getDbLink(),$this->getDbName(),$this->getTableName(),"payed",$f_opts);
		$this->addField($f_payed);
		//********************
	
		//*** Field total ***
		$f_opts = array();
		$f_opts['length']=15;
		$f_opts['id']="total";
		
		$f_total=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"total",$f_opts);
		$this->addField($f_total);
		//********************
	
		//*** Field store_id ***
		$f_opts = array();
		$f_opts['id']="store_id";
		
		$f_store_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"store_id",$f_opts);
		$this->addField($f_store_id);
		//********************

		$order = new ModelOrderSQL();		
		$this->setDefaultModelOrder($order);		
		
		$order->addField($f_date_time);
$this->setLimitConstant('doc_per_page_count');
		$this->setLastRowSelectOnInit(TRUE);
	}

}
?>
