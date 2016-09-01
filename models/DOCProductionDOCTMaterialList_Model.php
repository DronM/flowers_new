<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQLDOCT.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');

class DOCProductionDOCTMaterialList_Model extends ModelSQLDOCT{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_productions_t_tmp_materials_list_view");
		
		$f_line_number=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"line_number"
		,array(
		
			'primaryKey'=>TRUE,
			'alias'=>"№"
		,
			'id'=>"line_number"
				
		
		));
		$this->addField($f_line_number);

		$f_login_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"login_id"
		,array(
		
			'primaryKey'=>TRUE,
			'id'=>"login_id"
				
		
		));
		$this->addField($f_login_id);

		$f_material_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"material_id"
		,array(
		
			'id'=>"material_id"
				
		
		));
		$this->addField($f_material_id);

		$f_material_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"material_descr"
		,array(
		
			'id'=>"material_descr"
				
		
		));
		$this->addField($f_material_descr);

		$f_quant_norm=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"quant_norm"
		,array(
		
			'id'=>"quant_norm"
				
		
		));
		$this->addField($f_quant_norm);

		$f_quant=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"quant"
		,array(
		
			'id'=>"quant"
				
		
		));
		$this->addField($f_quant);

		$f_quant_waste=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"quant_waste"
		,array(
		
			'id'=>"quant_waste"
				
		
		));
		$this->addField($f_quant_waste);

		
		
		
	}

}
?>
