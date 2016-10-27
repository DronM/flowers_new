<?php

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLEnum.php');

class MessageRecipient_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("message_recipients");
		
		$f_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"id"
		,array(
		
			'primaryKey'=>TRUE,
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

		$f_for_store_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"for_store_id"
		,array(
		
			'alias'=>"Магазин"
		,
			'id'=>"for_store_id"
				
		
		));
		$this->addField($f_for_store_id);

		$f_for_role_id=new FieldSQlEnum($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"for_role_id"
		,array(
		
			'alias'=>"Роль"
		,
			'id'=>"for_role_id"
				
		
		));
		$this->addField($f_for_role_id);

		$f_for_user_id=new FieldSQlInt($this->getDbLink(),$this->getDbName(),$this->getTableName()
		,"for_user_id"
		,array(
		
			'alias'=>"Пользователь"
		,
			'id'=>"for_user_id"
				
		
		));
		$this->addField($f_for_user_id);

		
		
		
	}

}
?>
