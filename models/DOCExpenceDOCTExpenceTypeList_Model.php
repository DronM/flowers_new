<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLText.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDate.php');

class DOCExpenceDOCTExpenceTypeList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_expences_t_tmp_expence_types_list");
		
		$f_line_number=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"line_number"
		,array(
		
			'primaryKey'=>TRUE,
			'alias'=>"№"
		,
			'id'=>"line_number"
				
		
		));
		$this->addField($f_line_number);

		$f_login_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"login_id"
		,array(
		
			'primaryKey'=>TRUE,
			'id'=>"login_id"
				
		
		));
		$this->addField($f_login_id);

		$f_expence_type_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"expence_type_descr"
		,array(
		
			'alias'=>"Вид затрат"
		,
			'id'=>"expence_type_descr"
				
		
		));
		$this->addField($f_expence_type_descr);

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
		
			'id'=>"expence_date"
		,
			'sysCol'=>TRUE
				
		
		));
		$this->addField($f_expence_date);

		$f_expence_date_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"expence_date_descr"
		,array(
		
			'alias'=>"Дата расхода"
		,
			'id'=>"expence_date_descr"
				
		
		));
		$this->addField($f_expence_date_descr);

		
		
		
	}

}
?>
