<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');

class ProductBalanceList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("products_balance_list");
		
		$f_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"id"
		,array(
		
			'primaryKey'=>TRUE,
			'id'=>"id"
		,
			'sysCol'=>TRUE
				
		
		));
		$this->addField($f_id);

		$f_code=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"code"
		,array(
		
			'alias'=>"Код"
		,
			'id'=>"code"
				
		
		));
		$this->addField($f_code);

		$f_name=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"name"
		,array(
		
			'alias'=>"Продукция"
		,
			'id'=>"name"
				
		
		));
		$this->addField($f_name);

		$f_price=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"price"
		,array(
		
			'alias'=>"Цена"
		,
			'id'=>"price"
				
		
		));
		$this->addField($f_price);

		$f_total=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"total"
		,array(
		
			'alias'=>"Сумма"
		,
			'id'=>"total"
				
		
		));
		$this->addField($f_total);

		$f_quant=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"quant"
		,array(
		
			'alias'=>"Кол-во"
		,
			'id'=>"quant"
				
		
		));
		$this->addField($f_quant);

		$f_order_quant=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"order_quant"
		,array(
		
			'alias'=>"Кол-во заказано"
		,
			'id'=>"order_quant"
		,
			'sysCol'=>TRUE
				
		
		));
		$this->addField($f_order_quant);

		$f_store_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"store_id"
		,array(
		
			'id'=>"store_id"
		,
			'sysCol'=>TRUE
				
		
		));
		$this->addField($f_store_id);

		$f_after_production_time=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"after_production_time"
		,array(
		
			'alias'=>"Время изготовления"
		,
			'id'=>"after_production_time"
				
		
		));
		$this->addField($f_after_production_time);

		
		
		
	}

}
?>
