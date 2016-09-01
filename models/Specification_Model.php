<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/ModelOrderSQL.php');

class Specification_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("specifications");
		
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

		$f_product_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"product_id"
		,array(
		'required'=>TRUE,
			'alias'=>"Продукция"
		,
			'id'=>"product_id"
				
		
		));
		$this->addField($f_product_id);

		$f_material_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"material_id"
		,array(
		'required'=>TRUE,
			'alias'=>"Материал"
		,
			'id'=>"material_id"
				
		
		));
		$this->addField($f_material_id);

		$f_product_quant=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"product_quant"
		,array(
		
			'alias'=>"Кол.продукции"
		,
			'length'=>19,
			'defaultValue'=>"1"
		,
			'id'=>"product_quant"
				
		
		));
		$this->addField($f_product_quant);

		$f_material_quant=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"material_quant"
		,array(
		'required'=>TRUE,
			'alias'=>"Кол.материала"
		,
			'length'=>19,
			'id'=>"material_quant"
				
		
		));
		$this->addField($f_material_quant);

		$order = new ModelOrderSQL();		
		$this->setDefaultModelOrder($order);		
		
		$order->addField($f_id);

		
		
		
	}

}
?>
