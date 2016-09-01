<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');

class ReceiptList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("receipts_list_view");
		
		$f_user_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"user_id"
		,array(
		
			'primaryKey'=>TRUE,
			'id'=>"user_id"
				
		
		));
		$this->addField($f_user_id);

		$f_item_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"item_id"
		,array(
		
			'primaryKey'=>TRUE,
			'id'=>"item_id"
				
		
		));
		$this->addField($f_item_id);

		$f_item_type=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"item_type"
		,array(
		
			'primaryKey'=>TRUE,
			'id'=>"item_type"
				
		
		));
		$this->addField($f_item_type);

		$f_doc_production_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"doc_production_id"
		,array(
		
			'id'=>"doc_production_id"
				
		
		));
		$this->addField($f_doc_production_id);

		$f_item_name=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"item_name"
		,array(
		
			'length'=>100,
			'id'=>"item_name"
				
		
		));
		$this->addField($f_item_name);

		$f_quant=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"quant"
		,array(
		
			'length'=>19,
			'id'=>"quant"
				
		
		));
		$this->addField($f_quant);

		$f_price=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"price"
		,array(
		
			'length'=>15,
			'id'=>"price"
				
		
		));
		$this->addField($f_price);

		$f_total=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"total"
		,array(
		
			'length'=>15,
			'id'=>"total"
				
		
		));
		$this->addField($f_total);

		$f_total_no_disc=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"total_no_disc"
		,array(
		
			'length'=>15,
			'id'=>"total_no_disc"
				
		
		));
		$this->addField($f_total_no_disc);

		$f_price_no_disc=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"price_no_disc"
		,array(
		
			'length'=>15,
			'id'=>"price_no_disc"
				
		
		));
		$this->addField($f_price_no_disc);

		$f_disc_percent=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"disc_percent"
		,array(
		
			'length'=>15,
			'id'=>"disc_percent"
				
		
		));
		$this->addField($f_disc_percent);

		
		
		
	}

}
?>
