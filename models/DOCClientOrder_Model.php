<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQLDOC.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLText.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLEnum.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTime.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDate.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLBool.php');
require_once(FRAME_WORK_PATH.'basic_classes/ModelOrderSQL.php');

class DOCClientOrder_Model extends ModelSQLDOC{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_client_orders");
		
		$f_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"id"
		,array(
		'required'=>TRUE,
			'primaryKey'=>TRUE,
			'autoInc'=>TRUE,
			'id'=>"id"
				
		
		));
		$this->addField($f_id);

		$f_date_time=new FieldSQlDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"date_time"
		,array(
		
			'id'=>"date_time"
				
		
		));
		$this->addField($f_date_time);

		$f_number=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"number"
		,array(
		
			'alias'=>"Номер"
		,
			'id'=>"number"
				
		
		));
		$this->addField($f_number);

		$f_number_from_site=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"number_from_site"
		,array(
		
			'alias'=>"Номер с сайта"
		,
			'length'=>10,
			'id'=>"number_from_site"
				
		
		));
		$this->addField($f_number_from_site);

		$f_processed=new FieldSQlBool($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"processed"
		,array(
		
			'alias'=>"Проведен"
		,
			'id'=>"processed"
				
		
		));
		$this->addField($f_processed);

		$f_delivery_type=new FieldSQlEnum($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"delivery_type"
		,array(
		'required'=>TRUE,
			'id'=>"delivery_type"
				
		
		));
		$this->addField($f_delivery_type);

		$f_client_name=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"client_name"
		,array(
		'required'=>TRUE,
			'length'=>200,
			'id'=>"client_name"
				
		
		));
		$this->addField($f_client_name);

		$f_client_tel=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"client_tel"
		,array(
		'required'=>TRUE,
			'length'=>15,
			'id'=>"client_tel"
				
		
		));
		$this->addField($f_client_tel);

		$f_recipient_type=new FieldSQlEnum($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"recipient_type"
		,array(
		'required'=>TRUE,
			'id'=>"recipient_type"
				
		
		));
		$this->addField($f_recipient_type);

		$f_recipient_name=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"recipient_name"
		,array(
		
			'length'=>200,
			'id'=>"recipient_name"
				
		
		));
		$this->addField($f_recipient_name);

		$f_recipient_tel=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"recipient_tel"
		,array(
		
			'length'=>15,
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
		'required'=>TRUE,
			'id'=>"delivery_date"
				
		
		));
		$this->addField($f_delivery_date);

		$f_delivery_hour_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"delivery_hour_id"
		,array(
		'required'=>TRUE,
			'id'=>"delivery_hour_id"
				
		
		));
		$this->addField($f_delivery_hour_id);

		$f_delivery_comment=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"delivery_comment"
		,array(
		
			'length'=>100,
			'id'=>"delivery_comment"
				
		
		));
		$this->addField($f_delivery_comment);

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

		$f_delivery_note_type=new FieldSQlEnum($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"delivery_note_type"
		,array(
		
			'id'=>"delivery_note_type"
				
		
		));
		$this->addField($f_delivery_note_type);

		$f_extra_comment=new FieldSQlText($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"extra_comment"
		,array(
		
			'id'=>"extra_comment"
				
		
		));
		$this->addField($f_extra_comment);

		$f_payment_type=new FieldSQlEnum($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"payment_type"
		,array(
		
			'id'=>"payment_type"
				
		
		));
		$this->addField($f_payment_type);

		$f_client_order_state=new FieldSQlEnum($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"client_order_state"
		,array(
		
			'defaultValue'=>"to_noone"
		,
			'id'=>"client_order_state"
				
		
		));
		$this->addField($f_client_order_state);

		$f_payed=new FieldSQlBool($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"payed"
		,array(
		
			'defaultValue'=>"FALSE"
		,
			'id'=>"payed"
				
		
		));
		$this->addField($f_payed);

		$f_total=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"total"
		,array(
		
			'length'=>15,
			'id'=>"total"
				
		
		));
		$this->addField($f_total);

		$order = new ModelOrderSQL();		
		$this->setDefaultModelOrder($order);		
		
		$order->addField($f_date_time);

		
		
		
	}

}
?>
