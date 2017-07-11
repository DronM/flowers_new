<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTime.php');

class DOCMaterialDisposalMaterialList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_material_disposals_materials_list_view");
			
		//*** Field id ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['sysCol']=TRUE;
		$f_opts['id']="id";
		
		$f_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"id",$f_opts);
		$this->addField($f_id);
		//********************
	
		//*** Field date_time ***
		$f_opts = array();
		$f_opts['sysCol']=TRUE;
		$f_opts['id']="date_time";
		
		$f_date_time=new FieldSQLDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName(),"date_time",$f_opts);
		$this->addField($f_date_time);
		//********************
	
		//*** Field date_time_descr ***
		$f_opts = array();
		$f_opts['id']="date_time_descr";
		
		$f_date_time_descr=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"date_time_descr",$f_opts);
		$this->addField($f_date_time_descr);
		//********************
	
		//*** Field number ***
		$f_opts = array();
		$f_opts['id']="number";
		
		$f_number=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"number",$f_opts);
		$this->addField($f_number);
		//********************
	
		//*** Field store_id ***
		$f_opts = array();
		$f_opts['sysCol']=TRUE;
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
	
		//*** Field user_id ***
		$f_opts = array();
		$f_opts['sysCol']=TRUE;
		$f_opts['id']="user_id";
		
		$f_user_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"user_id",$f_opts);
		$this->addField($f_user_id);
		//********************
	
		//*** Field user_descr ***
		$f_opts = array();
		$f_opts['id']="user_descr";
		
		$f_user_descr=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"user_descr",$f_opts);
		$this->addField($f_user_descr);
		//********************
	
		//*** Field explanation ***
		$f_opts = array();
		$f_opts['id']="explanation";
		
		$f_explanation=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"explanation",$f_opts);
		$this->addField($f_explanation);
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
	
		//*** Field material_group_id ***
		$f_opts = array();
		$f_opts['sysCol']=TRUE;
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
