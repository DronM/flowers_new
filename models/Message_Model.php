<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLText.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLEnum.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTime.php');
require_once(FRAME_WORK_PATH.'basic_classes/ModelOrderSQL.php');

class Message_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("messages");
		
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

		$f_content=new FieldSQlText($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"content"
		,array(
		
			'alias'=>"Содержание"
		,
			'id'=>"content"
				
		
		));
		$this->addField($f_content);

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

		$order = new ModelOrderSQL();		
		$this->setDefaultModelOrder($order);		
		
		$order->addField($f_date_time);

		
		
		
	}

}
?>
