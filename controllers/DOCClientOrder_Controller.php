<?php
require_once(FRAME_WORK_PATH.'basic_classes/ControllerSQLDOC20.php');

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
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtInterval.php');
require_once(FRAME_WORK_PATH.'basic_classes/ControllerSQLDOC20.php');
require_once(FRAME_WORK_PATH.'basic_classes/ParamsSQL.php');

class DOCClientOrder_Controller extends ControllerSQLDOC20{
	public function __construct($dbLinkMaster=NULL){
		parent::__construct($dbLinkMaster);
			
		$this->setProcessable(TRUE);
		
		
		/* insert */
		$pm = new PublicMethod('insert');
		$param = new FieldExtDateTime('date_time'
				,array());
		$pm->addParam($param);
		$param = new FieldExtInt('number'
				,array(
				'alias'=>'Номер'
			));
		$pm->addParam($param);
		$param = new FieldExtString('number_from_site'
				,array(
				'alias'=>'Номер с сайта'
			));
		$pm->addParam($param);
		$param = new FieldExtBool('processed'
				,array(
				'alias'=>'Проведен'
			));
		$pm->addParam($param);
		
				$param = new FieldExtEnum('delivery_type',',','courier,by_client'
				,array('required'=>TRUE));
		$pm->addParam($param);
		$param = new FieldExtString('client_name'
				,array('required'=>TRUE));
		$pm->addParam($param);
		$param = new FieldExtString('client_tel'
				,array('required'=>TRUE));
		$pm->addParam($param);
		
				$param = new FieldExtEnum('recipient_type',',','self,other'
				,array('required'=>TRUE));
		$pm->addParam($param);
		$param = new FieldExtString('recipient_name'
				,array());
		$pm->addParam($param);
		$param = new FieldExtString('recipient_tel'
				,array());
		$pm->addParam($param);
		$param = new FieldExtText('address'
				,array());
		$pm->addParam($param);
		$param = new FieldExtDate('delivery_date'
				,array('required'=>TRUE));
		$pm->addParam($param);
		$param = new FieldExtInt('delivery_hour_id'
				,array('required'=>TRUE));
		$pm->addParam($param);
		$param = new FieldExtString('delivery_comment'
				,array());
		$pm->addParam($param);
		$param = new FieldExtBool('card'
				,array());
		$pm->addParam($param);
		$param = new FieldExtText('card_text'
				,array());
		$pm->addParam($param);
		$param = new FieldExtBool('anonym_gift'
				,array());
		$pm->addParam($param);
		
				$param = new FieldExtEnum('delivery_note_type',',','by_call,by_sms'
				,array());
		$pm->addParam($param);
		$param = new FieldExtText('extra_comment'
				,array());
		$pm->addParam($param);
		
				$param = new FieldExtEnum('payment_type',',','cash,bank,yandex,trans_to_card,web_money'
				,array());
		$pm->addParam($param);
		
				$param = new FieldExtEnum('client_order_state',',','to_noone,checked,to_florist,to_courier,closed'
				,array());
		$pm->addParam($param);
		$param = new FieldExtBool('payed'
				,array());
		$pm->addParam($param);
		$param = new FieldExtFloat('total'
				,array(
				'alias'=>'Сумма'
			));
		$pm->addParam($param);
		$param = new FieldExtInt('store_id'
				,array(
				'alias'=>'Магазин'
			));
		$pm->addParam($param);
		
		$pm->addParam(new FieldExtInt('ret_id'));
		
			$f_params = array();
			
				$f_params['required']=TRUE;
			$param = new FieldExtString('view_id'
			,$f_params);
		$pm->addParam($param);		
		
		
		$this->addPublicMethod($pm);
		$this->setInsertModelId('DOCClientOrder_Model');

			
		/* update */		
		$pm = new PublicMethod('update');
		
		$pm->addParam(new FieldExtInt('old_id',array('required'=>TRUE)));
		
		$pm->addParam(new FieldExtInt('obj_mode'));
		$param = new FieldExtInt('id'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtDateTime('date_time'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtInt('number'
				,array(
			
				'alias'=>'Номер'
			));
			$pm->addParam($param);
		$param = new FieldExtString('number_from_site'
				,array(
			
				'alias'=>'Номер с сайта'
			));
			$pm->addParam($param);
		$param = new FieldExtBool('processed'
				,array(
			
				'alias'=>'Проведен'
			));
			$pm->addParam($param);
		
				$param = new FieldExtEnum('delivery_type',',','courier,by_client'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtString('client_name'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtString('client_tel'
				,array(
			));
			$pm->addParam($param);
		
				$param = new FieldExtEnum('recipient_type',',','self,other'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtString('recipient_name'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtString('recipient_tel'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtText('address'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtDate('delivery_date'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtInt('delivery_hour_id'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtString('delivery_comment'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtBool('card'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtText('card_text'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtBool('anonym_gift'
				,array(
			));
			$pm->addParam($param);
		
				$param = new FieldExtEnum('delivery_note_type',',','by_call,by_sms'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtText('extra_comment'
				,array(
			));
			$pm->addParam($param);
		
				$param = new FieldExtEnum('payment_type',',','cash,bank,yandex,trans_to_card,web_money'
				,array(
			));
			$pm->addParam($param);
		
				$param = new FieldExtEnum('client_order_state',',','to_noone,checked,to_florist,to_courier,closed'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtBool('payed'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtFloat('total'
				,array(
			
				'alias'=>'Сумма'
			));
			$pm->addParam($param);
		$param = new FieldExtInt('store_id'
				,array(
			
				'alias'=>'Магазин'
			));
			$pm->addParam($param);
		
			$param = new FieldExtInt('id',array(
			));
			$pm->addParam($param);
		
			$f_params = array();
			
				$f_params['required']=TRUE;
			$param = new FieldExtString('view_id'
			,$f_params);
		$pm->addParam($param);		
		
		
			$this->addPublicMethod($pm);
			$this->setUpdateModelId('DOCClientOrder_Model');

			
		/* delete */
		$pm = new PublicMethod('delete');
		
		$pm->addParam(new FieldExtInt('id'
		));		
		
		$pm->addParam(new FieldExtInt('count'));
		$pm->addParam(new FieldExtInt('from'));				
		$this->addPublicMethod($pm);					
		$this->setDeleteModelId('DOCClientOrder_Model');

			
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
		
		$this->setListModelId('DOCClientOrderList_Model');
		
			
		/* get_object */
		$pm = new PublicMethod('get_object');
		$pm->addParam(new FieldExtInt('browse_mode'));
		
		$pm->addParam(new FieldExtInt('id'
		));
		
		$this->addPublicMethod($pm);
		$this->setObjectModelId('DOCClientOrderList_Model');		

			
		$pm = new PublicMethod('get_print');
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('doc_id',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('templ',$opts));
	
			
		$this->addPublicMethod($pm);
												
			
		$pm = new PublicMethod('before_open');
		
				
	$opts=array();
	
		$opts['length']=32;
		$opts['required']=TRUE;				
		$pm->addParam(new FieldExtString('view_id',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('doc_id',$opts));
	
			
		$this->addPublicMethod($pm);

			
		$pm = new PublicMethod('set_unprocessed');
		
				
	$opts=array();
	
		$opts['required']=TRUE;				
		$pm->addParam(new FieldExtInt('doc_id',$opts));
	
			
		$this->addPublicMethod($pm);
			
			
		$pm = new PublicMethod('get_actions');
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('doc_id',$opts));
	
			
		$this->addPublicMethod($pm);
			
			
		$pm = new PublicMethod('get_print');
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('doc_id',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('templ',$opts));
	
			
		$this->addPublicMethod($pm);
			
			
		$pm = new PublicMethod('set_state');
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('doc_id',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('state',$opts));
	
			
		$this->addPublicMethod($pm);
			
			
		$pm = new PublicMethod('set_payed');
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('doc_id',$opts));
	
			
		$this->addPublicMethod($pm);
			
			
		
	}	
	
	public function set_state($pm){
		$p = new ParamsSQL($pm,$this->getDbLink());
		$p->addAll();
		
		$this->getDbLinkMaster()->query(sprintf(
		"UPDATE doc_client_orders
		SET client_order_state=%s
		WHERE id=%d",
		$p->getDbVal('state'),
		$p->getDbVal('doc_id')
		));
	}

	public function set_payed($pm){
		$p = new ParamsSQL($pm,$this->getDbLink());
		$p->addAll();
		
		$this->getDbLinkMaster()->query(sprintf(
		"UPDATE doc_client_orders
		SET payed=TRUE
		WHERE id=%d",
		$p->getDbVal('doc_id')
		));
	}
	
	public function get_print($pm){
		$p = new ParamsSQL($pm,$this->getDbLink());
		$p->set('doc_id',DT_INT,array('required'=>TRUE));
		
		$this->addNewModel(sprintf(
			"SELECT *,
				get_date_str_rus(date_time::date) AS date_time_descr
			FROM doc_client_orders_list
			WHERE id=%d",
		$p->getParamById('doc_id')),
		'head');		
		
		$this->addNewModel(sprintf(
			"SELECT * FROM doc_client_orders_t_materials_list
			WHERE doc_id=%d",
		$p->getParamById('doc_id')),
		'materials');		
		
		$this->addNewModel(sprintf(
			"SELECT * FROM doc_client_orders_t_products_list
			WHERE doc_id=%d",
		$p->getParamById('doc_id')),
		'products');		
		
	}

}
?>