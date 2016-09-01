<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQLDOC.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLText.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTime.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLBool.php');

class DOCProductionList_Model extends ModelSQLDOC{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_productions_list_view");
		
		$f_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"id"
		,array(
		
			'primaryKey'=>TRUE,
			'id'=>"id"
		,
			'sysCol'=>TRUE
				
		
		));
		$this->addField($f_id);

		$f_number=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"number"
		,array(
		
			'alias'=>"Номер"
		,
			'id'=>"number"
				
		
		));
		$this->addField($f_number);

		$f_date_time=new FieldSQlDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"date_time"
		,array(
		
			'id'=>"date_time"
		,
			'sysCol'=>TRUE
				
		
		));
		$this->addField($f_date_time);

		$f_date_time_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"date_time_descr"
		,array(
		
			'alias'=>"Дата"
		,
			'id'=>"date_time_descr"
				
		
		));
		$this->addField($f_date_time_descr);

		$f_on_norm=new FieldSQlBool($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"on_norm"
		,array(
		
			'alias'=>"По норме"
		,
			'id'=>"on_norm"
				
		
		));
		$this->addField($f_on_norm);

		$f_store_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"store_id"
		,array(
		
			'id'=>"store_id"
		,
			'sysCol'=>TRUE
				
		
		));
		$this->addField($f_store_id);

		$f_store_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"store_descr"
		,array(
		
			'alias'=>"Салон"
		,
			'id'=>"store_descr"
				
		
		));
		$this->addField($f_store_descr);

		$f_product_order_type=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"product_order_type"
		,array(
		
			'id'=>"product_order_type"
		,
			'sysCol'=>TRUE
				
		
		));
		$this->addField($f_product_order_type);

		$f_product_order_type_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"product_order_type_descr"
		,array(
		
			'id'=>"product_order_type_descr"
		,
			'sysCol'=>TRUE
				
		
		));
		$this->addField($f_product_order_type_descr);

		$f_user_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"user_id"
		,array(
		
			'id'=>"user_id"
		,
			'sysCol'=>TRUE
				
		
		));
		$this->addField($f_user_id);

		$f_user_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"user_descr"
		,array(
		
			'alias'=>"Автор"
		,
			'id'=>"user_descr"
				
		
		));
		$this->addField($f_user_descr);

		$f_product_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"product_id"
		,array(
		
			'id'=>"product_id"
		,
			'sysCol'=>TRUE
				
		
		));
		$this->addField($f_product_id);

		$f_product_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"product_descr"
		,array(
		
			'alias'=>"Продукция"
		,
			'id'=>"product_descr"
				
		
		));
		$this->addField($f_product_descr);

		$f_quant=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"quant"
		,array(
		
			'alias'=>"Количество"
		,
			'length'=>19,
			'id'=>"quant"
				
		
		));
		$this->addField($f_quant);

		$f_price=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"price"
		,array(
		
			'alias'=>"Цена"
		,
			'length'=>15,
			'id'=>"price"
				
		
		));
		$this->addField($f_price);

		$f_sum_descr=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"sum_descr"
		,array(
		
			'alias'=>"Сумма"
		,
			'length'=>15,
			'id'=>"sum_descr"
				
		
		));
		$this->addField($f_sum_descr);

		$f_mat_sum_descr=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"mat_sum_descr"
		,array(
		
			'alias'=>"Сумма материалов"
		,
			'length'=>15,
			'id'=>"mat_sum_descr"
				
		
		));
		$this->addField($f_mat_sum_descr);

		$f_processed=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"processed"
		,array(
		
			'id'=>"processed"
		,
			'sysCol'=>TRUE
				
		
		));
		$this->addField($f_processed);

		$f_rest=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"rest"
		,array(
		
			'id'=>"rest"
		,
			'sysCol'=>TRUE
				
		
		));
		$this->addField($f_rest);

		$f_florist_comment=new FieldSQlText($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"florist_comment"
		,array(
		
			'alias'=>"Комментарий"
		,
			'id'=>"florist_comment"
				
		
		));
		$this->addField($f_florist_comment);

		
		
		
	}

}
?>
