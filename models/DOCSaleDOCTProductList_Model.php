<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQLDOCT20.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTime.php');

class DOCSaleDOCTProductList_Model extends ModelSQLDOCT20{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_sales_t_tmp_products_list_view");
			
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
	
		//*** Field product_id ***
		$f_opts = array();
		$f_opts['id']="product_id";
		
		$f_product_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"product_id",$f_opts);
		$this->addField($f_product_id);
		//********************
	
		//*** Field doc_production_id ***
		$f_opts = array();
		$f_opts['id']="doc_production_id";
		
		$f_doc_production_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"doc_production_id",$f_opts);
		$this->addField($f_doc_production_id);
		//********************
	
		//*** Field doc_production_number ***
		$f_opts = array();
		$f_opts['id']="doc_production_number";
		
		$f_doc_production_number=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"doc_production_number",$f_opts);
		$this->addField($f_doc_production_number);
		//********************
	
		//*** Field doc_production_date_time ***
		$f_opts = array();
		$f_opts['id']="doc_production_date_time";
		
		$f_doc_production_date_time=new FieldSQLDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName(),"doc_production_date_time",$f_opts);
		$this->addField($f_doc_production_date_time);
		//********************
	
		//*** Field product_descr ***
		$f_opts = array();
		$f_opts['id']="product_descr";
		
		$f_product_descr=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"product_descr",$f_opts);
		$this->addField($f_product_descr);
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
	
		//*** Field total ***
		$f_opts = array();
		$f_opts['id']="total";
		
		$f_total=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"total",$f_opts);
		$this->addField($f_total);
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
	
		//*** Field total_no_disc ***
		$f_opts = array();
		$f_opts['length']=15;
		$f_opts['id']="total_no_disc";
		
		$f_total_no_disc=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"total_no_disc",$f_opts);
		$this->addField($f_total_no_disc);
		//********************
$this->setLimitConstant('doc_per_page_count');
	}

}
?>
