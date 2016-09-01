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
class DOCExpenceDOCTExpenceType_Controller extends ControllerSQL{
	public function __construct($dbLinkMaster=NULL){
		parent::__construct($dbLinkMaster);
			
		/* insert */
		$pm = new PublicMethod('insert');
		$param = new FieldExtInt('login_id'
				,array());
		$pm->addParam($param);
		$param = new FieldExtInt('line_number'
				,array());
		$pm->addParam($param);
		$param = new FieldExtInt('expence_type_id'
				,array('required'=>TRUE,
				'alias'=>'Вид затрат'
			));
		$pm->addParam($param);
		$param = new FieldExtFloat('total'
				,array(
				'alias'=>'Сумма'
			));
		$pm->addParam($param);
		$param = new FieldExtText('expence_comment'
				,array(
				'alias'=>'Комментарий'
			));
		$pm->addParam($param);
		$param = new FieldExtDate('expence_date'
				,array(
				'alias'=>'Дата расхода'
			));
		$pm->addParam($param);
		
		
		$this->addPublicMethod($pm);
		$this->setInsertModelId('DOCExpenceDOCTExpenceType_Model');

			
		/* update */		
		$pm = new PublicMethod('update');
		
		$pm->addParam(new FieldExtInt('old_login_id',array('required'=>TRUE)));
		
		$pm->addParam(new FieldExtInt('old_line_number',array('required'=>TRUE)));
		
		$pm->addParam(new FieldExtInt('obj_mode'));
		$param = new FieldExtInt('login_id'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtInt('line_number'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtInt('expence_type_id'
				,array(
			
				'alias'=>'Вид затрат'
			));
			$pm->addParam($param);
		$param = new FieldExtFloat('total'
				,array(
			
				'alias'=>'Сумма'
			));
			$pm->addParam($param);
		$param = new FieldExtText('expence_comment'
				,array(
			
				'alias'=>'Комментарий'
			));
			$pm->addParam($param);
		$param = new FieldExtDate('expence_date'
				,array(
			
				'alias'=>'Дата расхода'
			));
			$pm->addParam($param);
		
			$param = new FieldExtInt('login_id',array(
			));
			$pm->addParam($param);
		
			$param = new FieldExtInt('line_number',array(
			));
			$pm->addParam($param);
		
		
			$this->addPublicMethod($pm);
			$this->setUpdateModelId('DOCExpenceDOCTExpenceType_Model');

			
		/* delete */
		$pm = new PublicMethod('delete');
		
		$pm->addParam(new FieldExtInt('login_id'
		));		
		
		$pm->addParam(new FieldExtInt('line_number'
		));		
		
		$pm->addParam(new FieldExtInt('count'));
		$pm->addParam(new FieldExtInt('from'));				
		$this->addPublicMethod($pm);					
		$this->setDeleteModelId('DOCExpenceDOCTExpenceType_Model');

			
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
		
		$this->setListModelId('DOCExpenceDOCTExpenceTypeList_Model');
		
			
		/* get_object */
		$pm = new PublicMethod('get_object');
		$pm->addParam(new FieldExtInt('browse_mode'));
		
		$pm->addParam(new FieldExtInt('line_number'
		));
		
		$pm->addParam(new FieldExtInt('login_id'
		));
		
		$this->addPublicMethod($pm);
		$this->setObjectModelId('DOCExpenceDOCTExpenceTypeList_Model');		

		
	}	
	
}
?>
