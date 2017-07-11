<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTime.php');

class MaterialBalanceList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("material_list_with_balance");
			
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
		$f_opts['id']="date_time";
		
		$f_date_time=new FieldSQLDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName(),"date_time",$f_opts);
		$this->addField($f_date_time);
		//********************
	
		//*** Field name ***
		$f_opts = array();
		$f_opts['id']="name";
		
		$f_name=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"name",$f_opts);
		$this->addField($f_name);
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
	
		//*** Field price ***
		$f_opts = array();
		$f_opts['id']="price";
		
		$f_price=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"price",$f_opts);
		$this->addField($f_price);
		//********************
	
		//*** Field main_quant ***
		$f_opts = array();
		$f_opts['id']="main_quant";
		
		$f_main_quant=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"main_quant",$f_opts);
		$this->addField($f_main_quant);
		//********************
	
		//*** Field main_total ***
		$f_opts = array();
		$f_opts['id']="main_total";
		
		$f_main_total=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"main_total",$f_opts);
		$this->addField($f_main_total);
		//********************
	
		//*** Field procur_avg_time ***
		$f_opts = array();
		$f_opts['id']="procur_avg_time";
		
		$f_procur_avg_time=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"procur_avg_time",$f_opts);
		$this->addField($f_procur_avg_time);
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
$this->setLimitConstant('doc_per_page_count');
	}

}
?>
