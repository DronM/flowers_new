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

require_once(FRAME_WORK_PATH.'basic_classes/ParamsSQL.php');	
require_once('models/TeplateParamList_Model.php');

class TeplateParam_Controller extends ControllerSQL{

	const ERR_NOT_LOGGED = 'Идетификатор пользователя не найден.@1000';

	public function __construct($dbLinkMaster=NULL){
		parent::__construct($dbLinkMaster);
			
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
		
			$f_params = array();
			$param = new FieldExtString('template'
			,$f_params);
		$pm->addParam($param);		
		
		$this->addPublicMethod($pm);
		
		$this->setListModelId('TeplateParamList_Model');
		
			
		$pm = new PublicMethod('set_value');
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('template',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('param',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtText('val',$opts));
	
			
		$this->addPublicMethod($pm);

		
	}	
	
	
	public function get_list($pm){
		if (!$_SESSION['role_id']){
			throw new Exception(self::ERR_NOT_LOGGED);
		}
		
		$p = new ParamsSQL($pm,$this->getDbLink());
		$p->addAll();
	
		$m = new TeplateParamList_Model($this->getDbLink());
		$m->setSelectQueryText(
			sprintf("SELECT * FROM teplate_params_get_list('DOCProduction', 10)",
			$p->getDbVal('template'),$_SESSION['role_id']
			)		
		);
		$this->modelGetList($m,$pm);		
		
	}


		
}
?>
