<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQLDOCT20.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');

class DOCClientOrderDOCTMaterialList_Model extends ModelSQLDOCT20{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_client_orders_t_tmp_materials_list");
			
		//*** Field view_id ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['length']=32;
		$f_opts['id']="view_id";
		
		$f_view_id=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"view_id",$f_opts);
		$this->addField($f_view_id);
		//********************
	
		//*** Field line_number ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['id']="line_number";
		
		$f_line_number=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"line_number",$f_opts);
		$this->addField($f_line_number);
		//********************
	
		//*** Field login_id ***
		$f_opts = array();
		$f_opts['id']="login_id";
		
		$f_login_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"login_id",$f_opts);
		$this->addField($f_login_id);
		//********************
	
		//*** Field material_id ***
		$f_opts = array();
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
	
		//*** Field price ***
		$f_opts = array();
		$f_opts['id']="price";
		
		$f_price=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"price",$f_opts);
		$this->addField($f_price);
		//********************
	
		//*** Field disc_percent ***
		$f_opts = array();
		$f_opts['length']=15;
		$f_opts['id']="disc_percent";
		
		$f_disc_percent=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"disc_percent",$f_opts);
		$this->addField($f_disc_percent);
		//********************
	
		//*** Field price_no_disc ***
		$f_opts = array();
		$f_opts['length']=15;
		$f_opts['id']="price_no_disc";
		
		$f_price_no_disc=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"price_no_disc",$f_opts);
		$this->addField($f_price_no_disc);
		//********************
	
		//*** Field total ***
		$f_opts = array();
		$f_opts['id']="total";
		
		$f_total=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"total",$f_opts);
		$this->addField($f_total);
		//********************
$this->setLimitConstant('doc_per_page_count');
	}

}
?>
