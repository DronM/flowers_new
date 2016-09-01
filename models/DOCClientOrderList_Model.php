<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLText.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTime.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDate.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLBool.php');

class DOCClientOrderList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_client_orders_list");
		
		$f_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"id"
		,array(
		
			'primaryKey'=>TRUE,
			'id'=>"id"
				
		
		));
		$this->addField($f_id);

		$f_date_time=new FieldSQlDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"date_time"
		,array(
		
			'id'=>"date_time"
				
		
		));
		$this->addField($f_date_time);

		$f_date_time_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"date_time_descr"
		,array(
		
			'id'=>"date_time_descr"
				
		
		));
		$this->addField($f_date_time_descr);

		$f_number=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"number"
		,array(
		
			'id'=>"number"
				
		
		));
		$this->addField($f_number);

		$f_delivery_type=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"delivery_type"
		,array(
		
			'id'=>"delivery_type"
				
		
		));
		$this->addField($f_delivery_type);

		$f_delivery_type_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"delivery_type_descr"
		,array(
		
			'id'=>"delivery_type_descr"
				
		
		));
		$this->addField($f_delivery_type_descr);

		$f_client_name=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"client_name"
		,array(
		
			'id'=>"client_name"
				
		
		));
		$this->addField($f_client_name);

		$f_client_tel=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"client_tel"
		,array(
		
			'id'=>"client_tel"
				
		
		));
		$this->addField($f_client_tel);

		$f_recipient_type=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"recipient_type"
		,array(
		
			'id'=>"recipient_type"
				
		
		));
		$this->addField($f_recipient_type);

		$f_recipient_type_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"recipient_type_descr"
		,array(
		
			'id'=>"recipient_type_descr"
				
		
		));
		$this->addField($f_recipient_type_descr);

		$f_recipient_name=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"recipient_name"
		,array(
		
			'id'=>"recipient_name"
				
		
		));
		$this->addField($f_recipient_name);

		$f_recipient_tel=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"recipient_tel"
		,array(
		
			'id'=>"recipient_tel"
				
		
		));
		$this->addField($f_recipient_tel);

		$f_address=new FieldSQlText($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"address"
		,array(
		
			'id'=>"address"
				
		
		));
		$this->addField($f_address);

		$f_delivery_date=new FieldSQlDate($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"delivery_date"
		,array(
		
			'id'=>"delivery_date"
				
		
		));
		$this->addField($f_delivery_date);

		$f_delivery_date_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"delivery_date_descr"
		,array(
		
			'id'=>"delivery_date_descr"
				
		
		));
		$this->addField($f_delivery_date_descr);

		$f_delivery_hour_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"delivery_hour_id"
		,array(
		
			'id'=>"delivery_hour_id"
				
		
		));
		$this->addField($f_delivery_hour_id);

		$f_delivery_hour_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"delivery_hour_descr"
		,array(
		
			'id'=>"delivery_hour_descr"
				
		
		));
		$this->addField($f_delivery_hour_descr);

		$f_card=new FieldSQlBool($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"card"
		,array(
		
			'id'=>"card"
				
		
		));
		$this->addField($f_card);

		$f_card_text=new FieldSQlText($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"card_text"
		,array(
		
			'id'=>"card_text"
				
		
		));
		$this->addField($f_card_text);

		$f_anonym_gift=new FieldSQlBool($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"anonym_gift"
		,array(
		
			'id'=>"anonym_gift"
				
		
		));
		$this->addField($f_anonym_gift);

		$f_delivery_note_type_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"delivery_note_type_descr"
		,array(
		
			'id'=>"delivery_note_type_descr"
				
		
		));
		$this->addField($f_delivery_note_type_descr);

		$f_extra_comment=new FieldSQlText($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"extra_comment"
		,array(
		
			'id'=>"extra_comment"
				
		
		));
		$this->addField($f_extra_comment);

		$f_payment_type=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"payment_type"
		,array(
		
			'id'=>"payment_type"
				
		
		));
		$this->addField($f_payment_type);

		$f_payment_type_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"payment_type_descr"
		,array(
		
			'id'=>"payment_type_descr"
				
		
		));
		$this->addField($f_payment_type_descr);

		$f_client_order_state=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"client_order_state"
		,array(
		
			'id'=>"client_order_state"
				
		
		));
		$this->addField($f_client_order_state);

		$f_client_order_state_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"client_order_state_descr"
		,array(
		
			'id'=>"client_order_state_descr"
				
		
		));
		$this->addField($f_client_order_state_descr);

		$f_total=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"total"
		,array(
		
			'length'=>15,
			'id'=>"total"
				
		
		));
		$this->addField($f_total);

		
		
		
	}

}
?>
