<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLEnum.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTime.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLBool.php');
require_once(FRAME_WORK_PATH.'basic_classes/ModelOrderSQL.php');

class RAMaterial_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("ra_materials");
		
		$f_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"id"
		,array(
		'required'=>FALSE,
			'primaryKey'=>TRUE,
			'autoInc'=>TRUE,
			'alias'=>"Код"
		,
			'id'=>"id"
				
		
		));
		$this->addField($f_id);

		$f_date_time=new FieldSQlDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"date_time"
		,array(
		'required'=>TRUE,
			'alias'=>"Период"
		,
			'id'=>"date_time"
				
		
		));
		$this->addField($f_date_time);

		$f_deb=new FieldSQlBool($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"deb"
		,array(
		
			'alias'=>"Дебет"
		,
			'id'=>"deb"
				
		
		));
		$this->addField($f_deb);

		$f_doc_type=new FieldSQlEnum($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"doc_type"
		,array(
		'required'=>TRUE,
			'alias'=>"Вид документа"
		,
			'id'=>"doc_type"
				
		
		));
		$this->addField($f_doc_type);

		$f_doc_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"doc_id"
		,array(
		
			'id'=>"doc_id"
				
		
		));
		$this->addField($f_doc_id);

		$f_store_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"store_id"
		,array(
		'required'=>TRUE,
			'alias'=>"Магазин"
		,
			'id'=>"store_id"
				
		
		));
		$this->addField($f_store_id);

		$f_stock_type=new FieldSQlEnum($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"stock_type"
		,array(
		'required'=>TRUE,
			'alias'=>"Склад"
		,
			'id'=>"stock_type"
				
		
		));
		$this->addField($f_stock_type);

		$f_material_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"material_id"
		,array(
		'required'=>TRUE,
			'alias'=>"Материал"
		,
			'id'=>"material_id"
				
		
		));
		$this->addField($f_material_id);

		$f_doc_procurement_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"doc_procurement_id"
		,array(
		'required'=>TRUE,
			'alias'=>"Поставка"
		,
			'id'=>"doc_procurement_id"
				
		
		));
		$this->addField($f_doc_procurement_id);

		$f_quant=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"quant"
		,array(
		
			'alias'=>"Количество"
		,
			'length'=>19,
			'id'=>"quant"
				
		
		));
		$this->addField($f_quant);

		$f_cost=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"cost"
		,array(
		
			'alias'=>"Стоимость"
		,
			'length'=>15,
			'id'=>"cost"
				
		
		));
		$this->addField($f_cost);

		$order = new ModelOrderSQL();		
		$this->setDefaultModelOrder($order);		
		
		$order->addField($f_date_time);

		
		
		
	}

}
?>
