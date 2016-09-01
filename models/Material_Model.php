<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLText.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLBool.php');
require_once(FRAME_WORK_PATH.'basic_classes/ModelOrderSQL.php');

class Material_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("materials");
		
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

		$f_name_full=new FieldSQlText($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"name_full"
		,array(
		'required'=>TRUE,
			'alias'=>"Описание"
		,
			'id'=>"name_full"
				
		
		));
		$this->addField($f_name_full);

		$f_price=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"price"
		,array(
		'required'=>TRUE,
			'alias'=>"Розничная цена"
		,
			'length'=>15,
			'id'=>"price"
				
		
		));
		$this->addField($f_price);

		$f_for_sale=new FieldSQlBool($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"for_sale"
		,array(
		
			'alias'=>"Для продажи"
		,
			'id'=>"for_sale"
				
		
		));
		$this->addField($f_for_sale);

		$f_margin_percent=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"margin_percent"
		,array(
		
			'alias'=>"Наценка (%)"
		,
			'id'=>"margin_percent"
				
		
		));
		$this->addField($f_margin_percent);

		$f_material_group_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"material_group_id"
		,array(
		'required'=>TRUE,
			'alias'=>"Группа"
		,
			'id'=>"material_group_id"
				
		
		));
		$this->addField($f_material_group_id);

		$order = new ModelOrderSQL();		
		$this->setDefaultModelOrder($order);		
		
		$order->addField($f_name);

		
		
		
	}

}
?>
