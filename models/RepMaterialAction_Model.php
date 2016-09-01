<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelReportSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');

class RepMaterialAction_Model extends ModelReportSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("rep_material_actions");
		
		$f_store_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"store_id"
		,array(
		
			'alias'=>"Салон"
		,
			'id'=>"store_id"
				
		
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

		$f_doc_procurement_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"doc_procurement_id"
		,array(
		
			'alias'=>"Поставка"
		,
			'id'=>"doc_procurement_id"
				
		
		));
		$this->addField($f_doc_procurement_id);

		$f_doc_procurement_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"doc_procurement_descr"
		,array(
		
			'alias'=>"Поставка"
		,
			'id'=>"doc_procurement_descr"
				
		
		));
		$this->addField($f_doc_procurement_descr);

		$f_material_group_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"material_group_id"
		,array(
		
			'alias'=>"Группа материалов"
		,
			'id'=>"material_group_id"
				
		
		));
		$this->addField($f_material_group_id);

		$f_material_group_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"material_group_descr"
		,array(
		
			'alias'=>"Группа материалов"
		,
			'id'=>"material_group_descr"
				
		
		));
		$this->addField($f_material_group_descr);

		$f_material_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"material_id"
		,array(
		
			'alias'=>"Материал"
		,
			'id'=>"material_id"
				
		
		));
		$this->addField($f_material_id);

		$f_material_group_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"material_group_descr"
		,array(
		
			'alias'=>"Материал"
		,
			'id'=>"material_group_descr"
				
		
		));
		$this->addField($f_material_group_descr);

		$f_ra_doc_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"ra_doc_id"
		,array(
		
			'alias'=>"Документ движения"
		,
			'id'=>"ra_doc_id"
				
		
		));
		$this->addField($f_ra_doc_id);

		$f_ra_doc_type=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"ra_doc_type"
		,array(
		
			'alias'=>"Документ движения"
		,
			'id'=>"ra_doc_type"
				
		
		));
		$this->addField($f_ra_doc_type);

		$f_ra_doc_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"ra_doc_descr"
		,array(
		
			'alias'=>"Документ движения"
		,
			'id'=>"ra_doc_descr"
				
		
		));
		$this->addField($f_ra_doc_descr);

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

		
		
		
	}

}
?>
