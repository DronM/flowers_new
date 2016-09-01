<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQLDOCT.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLText.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDate.php');

class DOCExpenceDOCTExpenceType_Model extends ModelSQLDOCT{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_expences_t_tmp_expence_types");
		
		$f_login_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"login_id"
		,array(
		
			'primaryKey'=>TRUE,
			'id'=>"login_id"
				
		
		));
		$this->addField($f_login_id);

		$f_line_number=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"line_number"
		,array(
		
			'primaryKey'=>TRUE,
			'id'=>"line_number"
				
		
		));
		$this->addField($f_line_number);

		$f_expence_type_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"expence_type_id"
		,array(
		'required'=>TRUE,
			'alias'=>"Вид затрат"
		,
			'id'=>"expence_type_id"
				
		
		));
		$this->addField($f_expence_type_id);

		$f_total=new FieldSQlFloat($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"total"
		,array(
		
			'alias'=>"Сумма"
		,
			'length'=>15,
			'id'=>"total"
				
		
		));
		$this->addField($f_total);

		$f_expence_comment=new FieldSQlText($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"expence_comment"
		,array(
		
			'alias'=>"Комментарий"
		,
			'id'=>"expence_comment"
				
		
		));
		$this->addField($f_expence_comment);

		$f_expence_date=new FieldSQlDate($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"expence_date"
		,array(
		
			'alias'=>"Дата расхода"
		,
			'id'=>"expence_date"
				
		
		));
		$this->addField($f_expence_date);

		
		
		
	}

}
?>
