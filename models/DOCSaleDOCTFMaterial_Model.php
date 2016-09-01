<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');

class DOCSaleDOCTFMaterial_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_sales_t_materials");
		
		$f_doc_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"doc_id"
		,array(
		
			'primaryKey'=>TRUE,
			'id'=>"doc_id"
				
		
		));
		$this->addField($f_doc_id);

		$f_line_number=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"line_number"
		,array(
		
			'primaryKey'=>TRUE,
			'id'=>"line_number"
				
		
		));
		$this->addField($f_line_number);

		$f_material_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"material_id"
		,array(
		'required'=>TRUE,
			'alias'=>"Материал"
		,
			'id'=>"material_id"
				
		
		));
		$this->addField($f_material_id);

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

		$f_total=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"total"
		,array(
		
			'alias'=>"Сумма"
		,
			'length'=>15,
			'id'=>"total"
				
		
		));
		$this->addField($f_total);

		$f_disc_percent=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"disc_percent"
		,array(
		
			'alias'=>"Скидка"
		,
			'length'=>15,
			'id'=>"disc_percent"
				
		
		));
		$this->addField($f_disc_percent);

		$f_price_no_disc=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"price_no_disc"
		,array(
		
			'alias'=>"Цена без скидки"
		,
			'length'=>15,
			'id'=>"price_no_disc"
				
		
		));
		$this->addField($f_price_no_disc);

		$f_total_no_disc=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"total_no_disc"
		,array(
		
			'alias'=>"Сумма буз скидки"
		,
			'length'=>15,
			'id'=>"total_no_disc"
				
		
		));
		$this->addField($f_total_no_disc);

		
		
		
	}

}
?>
