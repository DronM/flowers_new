<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQLDOCT.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');

class DOCClientOrderDOCTMaterial_Model extends ModelSQLDOCT{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_client_orders_t_tmp_materials");
		
		$f_login_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"login_id"
		,array(
		
			'primaryKey'=>TRUE,
			'id'=>"login_id"
				
		
		));
		$this->addField($f_login_id);

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

		
		
		
	}

}
?>
