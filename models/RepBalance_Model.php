<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelReportSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDate.php');

class RepBalance_Model extends ModelReportSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("rep_balance");
		
		$f_store_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"store_id"
		,array(
		
			'alias'=>"Салон"
		,
			'id'=>"store_id"
				
		
		));
		$this->addField($f_store_id);

		$f_store_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"store_descr"
		,array(
		
			'alias'=>"Салон"
		,
			'id'=>"store_descr"
				
		
		));
		$this->addField($f_store_descr);

		$f_period=new FieldSQlDate($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"period"
		,array(
		
			'alias'=>"Дата"
		,
			'id'=>"period"
				
		
		));
		$this->addField($f_period);

		$f_mon=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"mon"
		,array(
		
			'alias'=>"Месяц"
		,
			'id'=>"mon"
				
		
		));
		$this->addField($f_mon);

		$f_expence_type_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"expence_type_id"
		,array(
		
			'id'=>"expence_type_id"
		,
			'sysCol'=>TRUE
				
		
		));
		$this->addField($f_expence_type_id);

		$f_expence_type_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"expence_type_descr"
		,array(
		
			'alias'=>"Вид затрат"
		,
			'id'=>"expence_type_descr"
				
		
		));
		$this->addField($f_expence_type_descr);

		$f_total_expences=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"total_expences"
		,array(
		
			'alias'=>"Сумма затрат"
		,
			'length'=>12,
			'id'=>"total_expences"
				
		
		));
		$this->addField($f_total_expences);

		$f_total_sales=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"total_sales"
		,array(
		
			'alias'=>"Выручка"
		,
			'length'=>12,
			'id'=>"total_sales"
				
		
		));
		$this->addField($f_total_sales);

		$f_total_mat_disp=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"total_mat_disp"
		,array(
		
			'alias'=>"Списания материалов"
		,
			'length'=>12,
			'id'=>"total_mat_disp"
				
		
		));
		$this->addField($f_total_mat_disp);

		$f_total_mat_cost=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"total_mat_cost"
		,array(
		
			'alias'=>"Себестоимость материалов"
		,
			'length'=>12,
			'id'=>"total_mat_cost"
				
		
		));
		$this->addField($f_total_mat_cost);

		
		
		
	}

}
?>
