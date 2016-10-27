<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLText.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLEnum.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTime.php');

class MessageHeaderList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("message_header_list");
		
		$f_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"id"
		,array(
		
			'primaryKey'=>TRUE,
			'alias'=>"Код"
		,
			'id'=>"id"
				
		
		));
		$this->addField($f_id);

		$f_message_type=new FieldSQlEnum($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"message_type"
		,array(
		'required'=>TRUE,
			'id'=>"message_type"
				
		
		));
		$this->addField($f_message_type);

		$f_user_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"user_id"
		,array(
		'required'=>TRUE,
			'alias'=>"Автор сообщения"
		,
			'id'=>"user_id"
				
		
		));
		$this->addField($f_user_id);

		$f_user_descr=new FieldSQlString($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"user_descr"
		,array(
		
			'alias'=>"Автор сообщения"
		,
			'id'=>"user_descr"
				
		
		));
		$this->addField($f_user_descr);

		$f_require_view=new FieldSQlBoolean($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"require_view"
		,array(
		
			'alias'=>"Требует отметки просмотра"
		,
			'id'=>"require_view"
				
		
		));
		$this->addField($f_require_view);

		$f_subject=new FieldSQlText($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"subject"
		,array(
		'required'=>TRUE,
			'alias'=>"Тема"
		,
			'id'=>"subject"
				
		
		));
		$this->addField($f_subject);

		$f_importance_level=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"importance_level"
		,array(
		
			'alias'=>"Уровень важности"
		,
			'id'=>"importance_level"
				
		
		));
		$this->addField($f_importance_level);

		$f_date_time=new FieldSQlDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"date_time"
		,array(
		
			'alias'=>"Время создания"
		,
			'id'=>"date_time"
				
		
		));
		$this->addField($f_date_time);

		
		
		
	}

}
?>
