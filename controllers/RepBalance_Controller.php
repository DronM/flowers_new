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
require_once(FRAME_WORK_PATH.'basic_classes/CondParamsSQL.php');

class RepBalance_Controller extends ControllerSQL{
	public function __construct($dbLinkMaster=NULL){
		parent::__construct($dbLinkMaster);
			
		$pm = new PublicMethod('balance');
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('cond_fields',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('cond_vals',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('cond_sgns',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('cond_ic',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('templ',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('ord_fields',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('ord_directs',$opts));
					
			
		$this->addPublicMethod($pm);
									
		
	}	
	
	public function balance($pm){
		$cond = new CondParamsSQL($pm,$this->getDbLink());
		if ($cond->paramExists('store_id','e')){
			$store_id = $cond->getValForDb('store_id','e',DT_INT);
		}
		
		if (isset($_SESSION['global_store_id'])){
			$store_id = $_SESSION['global_store_id'];
		}
		if (!isset($store_id)){
			throw new Exception('Пустое значение салона!');
		}
		$date_time_from = $cond->getValForDb('date_time','ge',DT_DATETIME);
		if (!isset($date_time_from)){
			throw new Exception('Не задана дата начала!');
		}		
		$date_time_to = $cond->getValForDb('date_time','le',DT_DATETIME);
		if (!isset($date_time_to)){
			throw new Exception('Не задана дата окончания!');
		}		
	
		$this->addNewModel(sprintf(
		"SELECT * FROM rep_balance(%s,%s,%d)",
		$date_time_from,
		$date_time_to,
		$store_id
		),'balance');
	}

}
?>
