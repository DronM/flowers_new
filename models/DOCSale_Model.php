<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQLDOC.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTime.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLBool.php');
require_once(FRAME_WORK_PATH.'basic_classes/ModelOrderSQL.php');

class DOCSale_Model extends ModelSQLDOC{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_sales");
		
		$f_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"id"
		,array(
		
			'primaryKey'=>TRUE,
			'autoInc'=>TRUE,
			'id'=>"id"
				
		
		));
		$this->addField($f_id);

		$f_date_time=new FieldSQlDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"date_time"
		,array(
		'required'=>TRUE,
			'alias'=>"Дата"
		,
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

		$f_processed=new FieldSQlBool($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"processed"
		,array(
		
			'alias'=>"Проведен"
		,
			'id'=>"processed"
				
		
		));
		$this->addField($f_processed);

		$f_store_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"store_id"
		,array(
		
			'alias'=>"Магазин"
		,
			'id'=>"store_id"
				
		
		));
		$this->addField($f_store_id);

		$f_user_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"user_id"
		,array(
		
			'alias'=>"Продавец"
		,
			'id'=>"user_id"
				
		
		));
		$this->addField($f_user_id);

		$f_payment_type_for_sale_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"payment_type_for_sale_id"
		,array(
		
			'alias'=>"Магазин"
		,
			'id'=>"payment_type_for_sale_id"
				
		
		));
		$this->addField($f_payment_type_for_sale_id);

		$f_total=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"total"
		,array(
		
			'alias'=>"Сумма"
		,
			'length'=>15,
			'id'=>"total"
				
		
		));
		$this->addField($f_total);

		$f_total_material_cost=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"total_material_cost"
		,array(
		
			'alias'=>"Себест.материалов"
		,
			'length'=>15,
			'id'=>"total_material_cost"
				
		
		));
		$this->addField($f_total_material_cost);

		$f_total_product_cost=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"total_product_cost"
		,array(
		
			'alias'=>"Себест.продукции"
		,
			'length'=>15,
			'id'=>"total_product_cost"
				
		
		));
		$this->addField($f_total_product_cost);

		$f_client_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"client_id"
		,array(
		
			'alias'=>"Клиент"
		,
			'id'=>"client_id"
				
		
		));
		$this->addField($f_client_id);

		$order = new ModelOrderSQL();		
		$this->setDefaultModelOrder($order);		
		
		$order->addField($f_date_time);

		
		
		
	}

}
?>
