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
class RGProductOrder_Controller extends ControllerSQL{
	public function __construct($dbLinkMaster=NULL){
		parent::__construct($dbLinkMaster);
			
		$pm = new PublicMethod('get_balance');
		
				
	$opts=array();
	
		$opts['required']=TRUE;				
		$pm->addParam(new FieldExtString('cond_fields',$opts));
	
				
	$opts=array();
	
		$opts['required']=TRUE;				
		$pm->addParam(new FieldExtString('cond_vals',$opts));
	
				
	$opts=array();
	
		$opts['required']=TRUE;				
		$pm->addParam(new FieldExtString('cond_sgns',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('cond_ic',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('ord_fields',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('ord_directs',$opts));
												
			
		$this->addPublicMethod($pm);

		
	}	
	
	public function get_balance($pm){
		if (isset($_SESSION['user_store_id'])){
			$store_filter = $_SESSION['user_store_id'];
		}
		else{
			$store_filter = "";
		}
		$this->addNewModel(
		"SELECT b.store_id,s.name AS store_descr,
		b.product_id,p.name AS product_descr,
		b.quant,
		b.product_order_type,
		get_product_order_types_descr(b.product_order_type) AS product_order_type_descr
		FROM rg_product_orders_balance('{".$store_filter."}','{}','{}') AS b
		LEFT JOIN stores AS s ON s.id=b.store_id
		LEFT JOIN products AS p ON p.id=b.product_id
		",
		'get_balance');
	}	

}
?>
