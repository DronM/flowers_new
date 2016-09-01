<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');

class DOCSaleDOCTFProductList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_sales_t_products_list_view");
		
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

		$f_doc_production_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"doc_production_id"
		,array(
		
			'id'=>"doc_production_id"
				
		
		));
		$this->addField($f_doc_production_id);

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

		$f_disc_percent=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"disc_percent"
		,array(
		
			'alias'=>"Скидка"
		,
			'length'=>15,
			'id'=>"disc_percent"
				
		
		));
		$this->addField($f_disc_percent);

		$f_price_no_disc=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"price_no_disc"
		,array(
		
			'alias'=>"Цена без скидки"
		,
			'length'=>15,
			'id'=>"price_no_disc"
				
		
		));
		$this->addField($f_price_no_disc);

		$f_total_no_disc=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"total_no_disc"
		,array(
		
			'alias'=>"Сумма буз скидки"
		,
			'length'=>15,
			'id'=>"total_no_disc"
				
		
		));
		$this->addField($f_total_no_disc);

		
		
		
	}

}
?>
