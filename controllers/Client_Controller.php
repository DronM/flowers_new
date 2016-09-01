<?php

require_once(FRAME_WORK_PATH.'basic_classes/ControllerSQL.php');

require_once(FRAME_WORK_PATH.'basic_classes/FieldExtInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtEnum.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtText.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtDateTime.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtDate.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtTime.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtPassword.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtBool.php');
class Client_Controller extends ControllerSQL{
	public function __construct($dbLinkMaster=NULL){
		parent::__construct($dbLinkMaster);
			
		/* insert */
		$pm = new PublicMethod('insert');
		$param = new FieldExtString('name'
				,array('required'=>TRUE,
				'alias'=>'Наименование'
			));
		$pm->addParam($param);
		$param = new FieldExtText('name_full'
				,array(
				'alias'=>'Полное наименование'
			));
		$pm->addParam($param);
		$param = new FieldExtString('phone_cel'
				,array('required'=>FALSE,
				'alias'=>'Сотовый телефон'
			));
		$pm->addParam($param);
		$param = new FieldExtInt('manager_id'
				,array(
				'alias'=>'Менеджер'
			));
		$pm->addParam($param);
		$param = new FieldExtDate('create_date'
				,array());
		$pm->addParam($param);
		$param = new FieldExtString('email'
				,array('required'=>FALSE));
		$pm->addParam($param);
		
		$pm->addParam(new FieldExtInt('ret_id'));
		
		
		$this->addPublicMethod($pm);
		$this->setInsertModelId('Client_Model');

			
		/* update */		
		$pm = new PublicMethod('update');
		
		$pm->addParam(new FieldExtInt('old_id',array('required'=>TRUE)));
		
		$pm->addParam(new FieldExtInt('obj_mode'));
		$param = new FieldExtInt('id'
				,array(
			
				'alias'=>'Код'
			));
			$pm->addParam($param);
		$param = new FieldExtString('name'
				,array(
			
				'alias'=>'Наименование'
			));
			$pm->addParam($param);
		$param = new FieldExtText('name_full'
				,array(
			
				'alias'=>'Полное наименование'
			));
			$pm->addParam($param);
		$param = new FieldExtString('phone_cel'
				,array(
			
				'alias'=>'Сотовый телефон'
			));
			$pm->addParam($param);
		$param = new FieldExtInt('manager_id'
				,array(
			
				'alias'=>'Менеджер'
			));
			$pm->addParam($param);
		$param = new FieldExtDate('create_date'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtString('email'
				,array(
			));
			$pm->addParam($param);
		
			$param = new FieldExtInt('id',array(
			
				'alias'=>'Код'
			));
			$pm->addParam($param);
		
		
			$this->addPublicMethod($pm);
			$this->setUpdateModelId('Client_Model');

			
		/* delete */
		$pm = new PublicMethod('delete');
		
		$pm->addParam(new FieldExtInt('id'
		));		
		
		$pm->addParam(new FieldExtInt('count'));
		$pm->addParam(new FieldExtInt('from'));				
		$this->addPublicMethod($pm);					
		$this->setDeleteModelId('Client_Model');

			
		/* get_list */
		$pm = new PublicMethod('get_list');
		$pm->addParam(new FieldExtInt('browse_mode'));
		$pm->addParam(new FieldExtInt('browse_id'));		
		$pm->addParam(new FieldExtInt('count'));
		$pm->addParam(new FieldExtInt('from'));
		$pm->addParam(new FieldExtString('cond_fields'));
		$pm->addParam(new FieldExtString('cond_sgns'));
		$pm->addParam(new FieldExtString('cond_vals'));
		$pm->addParam(new FieldExtString('cond_ic'));
		$pm->addParam(new FieldExtString('ord_fields'));
		$pm->addParam(new FieldExtString('ord_directs'));
		$pm->addParam(new FieldExtString('field_sep'));
		
		$this->addPublicMethod($pm);
		
		$this->setListModelId('ClientList_Model');
		
			
		/* get_object */
		$pm = new PublicMethod('get_object');
		$pm->addParam(new FieldExtInt('browse_mode'));
		
		$pm->addParam(new FieldExtInt('id'
		));
		
		$this->addPublicMethod($pm);
		$this->setObjectModelId('ClientDialog_Model');		

			
		/* complete  */
		$pm = new PublicMethod('complete');
		$pm->addParam(new FieldExtString('pattern'));
		$pm->addParam(new FieldExtInt('count'));
		$pm->addParam(new FieldExtInt('ic'));
		$pm->addParam(new FieldExtInt('mid'));
		$pm->addParam(new FieldExtString('name'));		
		$this->addPublicMethod($pm);					
		$this->setCompleteModelId('Client_Model');

		
	}	
	
}
?>
