<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');

class DOCClientOrderDOCTFProductList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_client_orders_t_products_list");
		
		$f_doc_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"doc_id"
		,array(
		
			'primaryKey'=>TRUE,
			'id'=>"doc_id"
				
		
		));
		$this->addField($f_doc_id);

		$f_line_number=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"line_number"
		,array(
		
			'primaryKey'=>TRUE,
			'alias'=>"№"
		,
			'id'=>"line_number"
				
		
		));
		$this->addField($f_line_number);

		$f_product_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"product_id"
		,array(
		
			'id'=>"product_id"
				
		
		));
		$this->addField($f_product_id);

		$f_product_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"product_descr"
		,array(
		
			'id'=>"product_descr"
				
		
		));
		$this->addField($f_product_descr);

		$f_quant=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"quant"
		,array(
		
			'id'=>"quant"
				
		
		));
		$this->addField($f_quant);

		$f_price=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"price"
		,array(
		
			'id'=>"price"
				
		
		));
		$this->addField($f_price);

		$f_total=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"total"
		,array(
		
			'id'=>"total"
				
		
		));
		$this->addField($f_total);

		$f_doc_client_order_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"doc_client_order_id"
		,array(
		
			'id'=>"doc_client_order_id"
				
		
		));
		$this->addField($f_doc_client_order_id);

		
		
		
	}

}
?>
