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
			
		//*** Field id ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['autoInc']=TRUE;
		$f_opts['id']="id";
		
		$f_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"id",$f_opts);
		$this->addField($f_id);
		//********************
	
		//*** Field name ***
		$f_opts = array();
		$f_opts['length']=100;
		$f_opts['id']="name";
		
		$f_name=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"name",$f_opts);
		$this->addField($f_name);
		//********************
	
		//*** Field name_full ***
		$f_opts = array();
		$f_opts['id']="name_full";
		
		$f_name_full=new FieldSQLText($this->getDbLink(),$this->getDbName(),$this->getTableName(),"name_full",$f_opts);
		$this->addField($f_name_full);
		//********************
	
		//*** Field price ***
		$f_opts = array();
		$f_opts['length']=15;
		$f_opts['id']="price";
		
		$f_price=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"price",$f_opts);
		$this->addField($f_price);
		//********************
	
		//*** Field for_sale ***
		$f_opts = array();
		$f_opts['id']="for_sale";
		
		$f_for_sale=new FieldSQLBool($this->getDbLink(),$this->getDbName(),$this->getTableName(),"for_sale",$f_opts);
		$this->addField($f_for_sale);
		//********************
	
		//*** Field margin_percent ***
		$f_opts = array();
		$f_opts['id']="margin_percent";
		
		$f_margin_percent=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"margin_percent",$f_opts);
		$this->addField($f_margin_percent);
		//********************
	
		//*** Field material_group_id ***
		$f_opts = array();
		$f_opts['id']="material_group_id";
		
		$f_material_group_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"material_group_id",$f_opts);
		$this->addField($f_material_group_id);
		//********************

		$order = new ModelOrderSQL();		
		$this->setDefaultModelOrder($order);		
		
		$order->addField($f_name);
$this->setLimitConstant('doc_per_page_count');
	}

}
?>
