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
		
		$f_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"id"
		,array(
		'required'=>TRUE,
			'primaryKey'=>TRUE,
			'autoInc'=>TRUE,
			'alias'=>"Код"
		,
			'id'=>"id"
				
		
		));
		$this->addField($f_id);

		$f_name=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"name"
		,array(
		'required'=>TRUE,
			'alias'=>"Наименование"
		,
			'length'=>100,
			'id'=>"name"
				
		
		));
		$this->addField($f_name);

		$f_client_order_payment_type=new FieldSQlEnum($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"client_order_payment_type"
		,array(
		
			'alias'=>"Вид оплаты из заказа"
		,
			'id'=>"client_order_payment_type"
				
		
		));
		$this->addField($f_client_order_payment_type);

		$f_kkm_type_close=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"kkm_type_close"
		,array(
		
			'alias'=>"Тип оплаты для ККМ"
		,
			'id'=>"kkm_type_close"
				
		
		));
		$this->addField($f_kkm_type_close);

		$order = new ModelOrderSQL();		
		$this->setDefaultModelOrder($order);		
		
		$order->addField($f_name);

		
		
		
	}

}
?>
