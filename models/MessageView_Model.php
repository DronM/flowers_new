<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTime.php');

class MessageView_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("message_views");
		
		$f_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"id"
		,array(
		
			'primaryKey'=>TRUE,
			'autoInc'=>TRUE,
			'alias'=>"Код"
		,
			'id'=>"id"
				
		
		));
		$this->addField($f_id);

		$f_message_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"message_id"
		,array(
		'required'=>TRUE,
			'alias'=>"Сообщение"
		,
			'id'=>"message_id"
				
		
		));
		$this->addField($f_message_id);

		$f_user_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"user_id"
		,array(
		
			'alias'=>"Пользователь"
		,
			'id'=>"user_id"
				
		
		));
		$this->addField($f_user_id);

		$f_date_time=new FieldSQlDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"date_time"
		,array(
		
			'alias'=>"Время просмотра"
		,
			'id'=>"date_time"
				
		
		));
		$this->addField($f_date_time);

		
		
		
	}

}
?>
