<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');

class DOCProductionDOCTFMaterialList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_productions_t_materials_list_view");
			
		//*** Field line_number ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['id']="line_number";
		
		$f_line_number=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"line_number",$f_opts);
		$this->addField($f_line_number);
		//********************
	
		//*** Field doc_id ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['sysCol']=TRUE;
		$f_opts['id']="doc_id";
		
		$f_doc_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"doc_id",$f_opts);
		$this->addField($f_doc_id);
		//********************
	
		//*** Field material_id ***
		$f_opts = array();
		$f_opts['sysCol']=TRUE;
		$f_opts['id']="material_id";
		
		$f_material_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"material_id",$f_opts);
		$this->addField($f_material_id);
		//********************
	
		//*** Field material_descr ***
		$f_opts = array();
		$f_opts['id']="material_descr";
		
		$f_material_descr=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"material_descr",$f_opts);
		$this->addField($f_material_descr);
		//********************
	
		//*** Field quant ***
		$f_opts = array();
		$f_opts['id']="quant";
		
		$f_quant=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"quant",$f_opts);
		$this->addField($f_quant);
		//********************
$this->setLimitConstant('doc_per_page_count');
	}

}
?>
