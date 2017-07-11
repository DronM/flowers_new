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
			
		//*** Field store_id ***
		$f_opts = array();
		$f_opts['id']="store_id";
		
		$f_store_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"store_id",$f_opts);
		$this->addField($f_store_id);
		//********************
	
		//*** Field store_descr ***
		$f_opts = array();
		$f_opts['id']="store_descr";
		
		$f_store_descr=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"store_descr",$f_opts);
		$this->addField($f_store_descr);
		//********************
	
		//*** Field doc_procurement_id ***
		$f_opts = array();
		$f_opts['id']="doc_procurement_id";
		
		$f_doc_procurement_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"doc_procurement_id",$f_opts);
		$this->addField($f_doc_procurement_id);
		//********************
	
		//*** Field doc_procurement_descr ***
		$f_opts = array();
		$f_opts['id']="doc_procurement_descr";
		
		$f_doc_procurement_descr=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"doc_procurement_descr",$f_opts);
		$this->addField($f_doc_procurement_descr);
		//********************
	
		//*** Field material_group_id ***
		$f_opts = array();
		$f_opts['id']="material_group_id";
		
		$f_material_group_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"material_group_id",$f_opts);
		$this->addField($f_material_group_id);
		//********************
	
		//*** Field material_group_descr ***
		$f_opts = array();
		$f_opts['id']="material_group_descr";
		
		$f_material_group_descr=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"material_group_descr",$f_opts);
		$this->addField($f_material_group_descr);
		//********************
	
		//*** Field material_id ***
		$f_opts = array();
		$f_opts['id']="material_id";
		
		$f_material_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"material_id",$f_opts);
		$this->addField($f_material_id);
		//********************
	
		//*** Field material_group_descr ***
		$f_opts = array();
		$f_opts['id']="material_group_descr";
		
		$f_material_group_descr=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"material_group_descr",$f_opts);
		$this->addField($f_material_group_descr);
		//********************
	
		//*** Field ra_doc_id ***
		$f_opts = array();
		$f_opts['id']="ra_doc_id";
		
		$f_ra_doc_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"ra_doc_id",$f_opts);
		$this->addField($f_ra_doc_id);
		//********************
	
		//*** Field ra_doc_type ***
		$f_opts = array();
		$f_opts['id']="ra_doc_type";
		
		$f_ra_doc_type=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"ra_doc_type",$f_opts);
		$this->addField($f_ra_doc_type);
		//********************
	
		//*** Field ra_doc_descr ***
		$f_opts = array();
		$f_opts['id']="ra_doc_descr";
		
		$f_ra_doc_descr=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"ra_doc_descr",$f_opts);
		$this->addField($f_ra_doc_descr);
		//********************
	
		//*** Field quant ***
		$f_opts = array();
		$f_opts['length']=19;
		$f_opts['id']="quant";
		
		$f_quant=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"quant",$f_opts);
		$this->addField($f_quant);
		//********************
	
		//*** Field cost ***
		$f_opts = array();
		$f_opts['length']=15;
		$f_opts['id']="cost";
		
		$f_cost=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"cost",$f_opts);
		$this->addField($f_cost);
		//********************
$this->setLimitConstant('doc_per_page_count');
	}

}
?>
