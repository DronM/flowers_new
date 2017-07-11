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
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtInterval.php');
require_once('functions/SMS.php');

require_once(FRAME_WORK_PATH.'basic_classes/ParamsSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/ModelVars.php');

class Receipt_Controller extends ControllerSQL{
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
		
		$this->addPublicMethod($pm);
		
		$this->setListModelId('ReceiptList_Model');
		
			
		/* delete */
		$pm = new PublicMethod('delete');
		
		$pm->addParam(new FieldExtInt('user_id'
		));		
		
		$pm->addParam(new FieldExtInt('item_id'
		));		
		
		$pm->addParam(new FieldExtInt('item_type'
		));		
		
		$pm->addParam(new FieldExtInt('count'));
		$pm->addParam(new FieldExtInt('from'));				
		$this->addPublicMethod($pm);					
		$this->setDeleteModelId('Receipt_Model');

			
		$pm = new PublicMethod('add_material');
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('item_id',$opts));
	
			
		$this->addPublicMethod($pm);
						
			
		$pm = new PublicMethod('set_disc_percent');
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtFloat('disc_percent',$opts));
	
			
		$this->addPublicMethod($pm);
												
			
		$pm = new PublicMethod('add_product');
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('item_id',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('doc_production_id',$opts));
	
			
		$this->addPublicMethod($pm);

			
		$pm = new PublicMethod('edit_item');
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('item_id',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('item_type',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('doc_production_id',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('quant',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtFloat('disc_percent',$opts));
	
			
		$this->addPublicMethod($pm);
												
			
		$pm = new PublicMethod('clear');
		
		$this->addPublicMethod($pm);

			
		$pm = new PublicMethod('close');
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('payment_type_for_sale_id',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('client_id',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('doc_client_order_id',$opts));
	
			
		$this->addPublicMethod($pm);

			
		$pm = new PublicMethod('add_by_code');
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('barcode',$opts));
	
			
		$this->addPublicMethod($pm);
						
			
		$pm = new PublicMethod('fill_on_client_order');
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('doc_client_order_id',$opts));
	
			
		$this->addPublicMethod($pm);
						
			
		$pm = new PublicMethod('save_head');
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('client_id',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('discount_id',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('doc_client_order_id',$opts));
	
			
		$this->addPublicMethod($pm);
									
			
		$pm = new PublicMethod('add_payment_type');
		
				
	$opts=array();
	
		$opts['required']=TRUE;				
		$pm->addParam(new FieldExtInt('payment_type_for_sale_id',$opts));
	
			
		$this->addPublicMethod($pm);
												
			
		$pm = new PublicMethod('set_payment_type_total');
		
				
	$opts=array();
	
		$opts['required']=TRUE;				
		$pm->addParam(new FieldExtString('dt',$opts));
	
				
	$opts=array();
	
		$opts['length']=15;				
		$pm->addParam(new FieldExtFloat('total',$opts));
	
			
		$this->addPublicMethod($pm);
															
			
		$pm = new PublicMethod('del_payment_type');
		
				
	$opts=array();
	
		$opts['required']=TRUE;				
		$pm->addParam(new FieldExtString('dt',$opts));
	
			
		$this->addPublicMethod($pm);
															
			
		$pm = new PublicMethod('get_payment_type_list');
		
			
		$this->addPublicMethod($pm);
															
			
		
	}	
	
	public function insert($pm){
		//doc owner
		$pm->setParamValue('user_id',$_SESSION['user_id']);		
		parent::insert($pm);		
	}
	public function get_list($pm){
		$pm->setParamValue('cond_fields','user_id');
		$pm->setParamValue('cond_vals',$_SESSION['user_id']);
		$pm->setParamValue('cond_sgns','e');
		parent::get_list($pm);		
	}
	public function add_to_receipt($item_id,$doc_production_id,$item_type){
		$link = $this->getDbLinkMaster();
		$q = sprintf(
		"SELECT receipt_insert_item(%d,%d,%d,%d)",
		$item_id,$doc_production_id,$item_type,$_SESSION['user_id']);
		$link->query($q);
	}
	public function add_material($pm){
		$p = new ParamsSQL($pm,$this->getDbLink());
		$p->addAll();
		$this->add_to_receipt(
			$p->getDbVal('item_id'),0,1
		);
	}
	public function add_product($pm){
		$p = new ParamsSQL($pm,$this->getDbLink());
		$p->addAll();
	
		$this->add_to_receipt(
			$p->getDbVal('item_id'),
			$p->getDbVal('doc_production_id'),0
		);
	}
	public function set_disc_percent($pm){
		$p = new ParamsSQL($pm,$this->getDbLink());
		$p->addAll();
	
		$this->getDbLinkMaster()->query(sprintf(
			"UPDATE receipts
			SET
				disc_percent=%d,
				total=calc_total(price_no_disc*quant,%d)
			WHERE user_id=%d",
			$p->getDbVal('disc_percent'),
			$p->getDbVal('disc_percent'),
			$_SESSION['user_id']
		));
	}
	
	private function add_pay_type($user_id){
		$link = $this->getDbLinkMaster();
		
		$link->query(sprintf(
			"INSERT INTO receipt_payment_types
			(user_id,payment_type_for_sale_id,total)
			VALUES (%d,const_def_payment_type_for_sale_val(),0)",
			$user_id
		));
	}
	
	private function clear_pay_types($user_id){
		$link = $this->getDbLinkMaster();
		
		$link->query(sprintf("DELETE FROM receipt_payment_types WHERE user_id=%d",$user_id));
		$this->add_pay_type($user_id);
	}
	
	public function clear($pm){
		$user_id = $_SESSION['user_id'];
		if (!isset($user_id)){
			throw new Exception('Не задан пользователь!');
		}
	
		$link = $this->getDbLinkMaster();
		try{
			$link->query('BEGIN');
		
			$link->query(sprintf("DELETE FROM receipts WHERE user_id=%d",
				$user_id
				));
			
			$link->query(sprintf("DELETE FROM receipt_head WHERE user_id=%d",$user_id));
			
			$this->clear_pay_types($user_id);
			
			$link->query('COMMIT');		
		}
		catch (Exception $e){
			$link->query('ROLLBACK');
			throw $e;
		}
			
	}
	public function close($pm){
		$store_id = $_SESSION['global_store_id'];
		if (!isset($store_id)){
			throw new Exception('Не задан салон!');
		}
		
		$user_id = $_SESSION['user_id'];
		if (!isset($user_id)){
			throw new Exception('Не задан пользователь!');
		}
		
		$p = new ParamsSQL($pm,$this->getDbLink());
		$p->addAll();
		
		$link = $this->getDbLinkMaster();
		
		try{
			$link->query('BEGIN');
			
			$ar = $link->query_first(
				sprintf("SELECT receipt_close(%d,%d,0,%s,%s) AS doc_id",
				$store_id,$user_id,
				($p->getDbVal('client_id'))? $p->getDbVal('client_id'):'null',
				($p->getDbVal('doc_client_order_id'))? $p->getDbVal('doc_client_order_id'):'null'
				)
			);
		
			$link->query(sprintf(
				"INSERT INTO doc_sales_payment_types
				(doc_id,payment_type_for_sale_id,total)
				(SELECT %d,t.payment_type_for_sale_id,t.total
				FROM receipt_payment_types t
				WHERE t.user_id=%d)",
				$ar['doc_id'],
				$user_id
			));
			
			$link->query(sprintf("SELECT FROM doc_sales_act(%d)",$ar['doc_id']));
			
			$link->query(sprintf("DELETE FROM receipt_head WHERE user_id=%d",$user_id));
		
			$this->clear_pay_types($user_id);
		
			$link->query('COMMIT');
		
			//SMS
			$ar = $this->getDbLink()->query_first('SELECT const_cel_phone_for_sms_val() AS val');
			//send_service_sms($ar['val'],'Продажа');					
		}
		catch (Exception $e){
			$link->query('ROLLBACK');
			throw $e;
		}
	}
	public function edit_item($pm){
		$p = new ParamsSQL($pm,$this->getDbLink());
		$p->addAll();
	
		$link = $this->getDbLinkMaster();
		$q = sprintf(
		"SELECT receipt_update_item(%d,%d,%d,%d,%f,%f)",
			$_SESSION['user_id'],
			$p->getDbVal('item_id'),
			$p->getDbVal('item_type'),
			$p->getDbVal('doc_production_id'),	
			$p->getDbVal('quant'),
			$p->getDbVal('disc_percent')
		);
		$link->query($q);
	}
	public function add_by_code($pm){
		$p = new ParamsSQL($pm,$this->getDbLink());
		$p->addAll();
		
		$user_id = $_SESSION['user_id'];
		if (!isset($user_id)){
			throw new Exception('Не задан пользователь!');
		}
		
		$full_code = $p->getVal('barcode');
		if (substr($full_code,0,1)=='9'){
			//карта
			if (strlen($full_code)==13){
				//КС
				$full_code = substr($full_code,0,12);
			}
			
			$ar = $this->getDbLink()->query_first(sprintf(
			"WITH disc_card_inf AS (
				SELECT
					t.id,
					t.discount_id,
					disc.percent
				FROM disc_cards t
				LEFT JOIN discounts AS disc ON disc.id = t.discount_id
				WHERE t.barcode='%s'
			)
			SELECT
				cl.id AS client_id,
				(SELECT t.discount_id FROM disc_card_inf t) AS discount_id,
				(SELECT t.percent FROM disc_card_inf t) AS disc_percent
			FROM clients cl
			WHERE cl.disc_card_id=(SELECT t.id FROM disc_card_inf t)",
			$full_code));
			
			if (is_array($ar) && count($ar)){						
				$this->getDbLinkMaster()->query(sprintf(
					"SELECT receipt_head_update(%d,%d,%d,NULL)",
					$user_id,
					$ar['client_id'],
					$ar['discount_id']
				));	
				
				$this->getDbLinkMaster()->query(sprintf(
					"UPDATE receipts
					SET
						disc_percent=%d,
						total=calc_total(price_no_disc*quant,%d)
					WHERE user_id=%d",
					$ar['disc_percent'],
					$ar['disc_percent'],
					$user_id
				));
				
				$this->addReceiptHead();		
			}			
		}
		else{
			//Материалы/Букеты
			
			if (strlen($full_code)==12){
				$full_code='0'.$full_code;
			}
			$item_type=($full_code[0]=='1')? 'm':'p';
		
			if (strlen($full_code)==13){				
				$full_code = substr($full_code,1,11);
				for ($i=1;$i<=strlen($full_code);$i++){
					if ($full_code[$i]!='0'){
						$code = substr($full_code,$i,strlen($full_code)-$i+1);
						break;
					}
				}
			}
			else{
				$code = SUBSTR($full_code,1);
			}
			$q = '';
			if ($item_type=="p"){
				$q = sprintf(
					"SELECT
						0 AS item_type,
						d.product_id AS item_id,
						d.id AS doc_id
					FROM doc_productions d
					WHERE d.number=%d",$code
				);
		
			}
			else if ($item_type=="m"){			
				$q = sprintf(
					"SELECT
						1 AS item_type,
						m.id AS item_id,
						0 AS doc_id
					FROM materials m
					WHERE m.id=%d",$code
				);
			}
			if (strlen($q)){
				$ar = $this->getDbLink()->query_first($q);
				if (is_array($ar)&&count($ar)){			
				
					$this->add_to_receipt(
						$ar['item_id'],$ar['doc_id'],$ar['item_type']);
				}
			}
		}
	}
	
	public function addReceiptHead(){
		$this->addNewModel(
		sprintf(
			"SELECT
				h.*,
				cl.name AS client_descr,
				d.name||'('||d.percent||'%%)' AS discount_descr,
				o.number_from_site||' '||date8_descr(o.date_time::date) AS doc_client_order_descr
			FROM receipt_head h
			LEFT JOIN clients cl ON cl.id=h.client_id
			LEFT JOIN discounts d ON d.id=h.discount_id
			LEFT JOIN doc_client_orders o ON o.id=h.doc_client_order_id
			WHERE h.user_id=%d",$_SESSION['user_id']),
		'ReceiptHeadList_Model');				
	
	}
	
	public function fill_on_client_order($pm){
		$store_id = $_SESSION['global_store_id'];
		if (!isset($store_id)){
			throw new Exception('Не задан салон!');
		}
		
		$p = new ParamsSQL($pm,$this->getDbLink());
		$p->addAll();
		
		$link = $this->getDbLinkMaster();
		
		$link->query(sprintf(
			"SELECT receipt_fill_on_client_order(%d,%d,%d)",
			$store_id,
			$_SESSION['user_id'],
			$p->getVal('doc_client_order_id')
			)
		);
		
		//selected head
		$this->addReceiptHead();
		
		/*
		$this->addNewModel(sprintf(
		"WITH
		order_t AS
		(SELECT
			o.client_id,
			(SELECT pt.id
			FROM payment_types_for_sale AS pt
			WHERE pt.client_order_payment_type=o.payment_type
			) AS payment_type_for_sale_id
		
		FROM doc_client_orders o
		WHERE o.id=%d
		),
		client_t AS (
			SELECT t.id,t.name FROM clients t WHERE t.id=(SELECT t.client_id FROM order_t t)
		)
	
		SELECT
			(SELECT t.id FROM client_t t) AS client_id,
			(SELECT t.name FROM client_t t) AS client_descr,
			(SELECT t.payment_type_for_sale_id FROM order_t t) AS payment_type_for_sale_id",
		$p->getVal('doc_client_order_id')
		),
		'fill_on_client_order'
		);
		*/
	}
	
	public function save_head($pm){
		$user_id = $_SESSION['user_id'];
		if (!isset($user_id)){
			throw new Exception('Не задан пользователь!');
		}
	
		$p = new ParamsSQL($pm,$this->getDbLink());
		$p->addAll();

		$client_id = ($p->getDbVal('client_id'))? $p->getDbVal('client_id'):'null';
		$discount_id = ($p->getDbVal('discount_id'))? $p->getDbVal('discount_id'):'null';
		$doc_client_order_id = ($p->getDbVal('doc_client_order_id'))? $p->getDbVal('doc_client_order_id'):'null';
		
		$this->getDbLinkMaster()->query(sprintf(
			"SELECT receipt_head_update(%s,%s,%s,%s)",
			$user_id,
			$client_id,
			$discount_id,
			$doc_client_order_id
		));
	}

	public function add_payment_type($pm){
		$user_id = $_SESSION['user_id'];
		if (!isset($user_id)){
			throw new Exception('Не задан пользователь!');
		}
	
		$p = new ParamsSQL($pm,$this->getDbLink());
		$p->addAll();
	
		$link = $this->getDbLinkMaster();
		
		$link->query(sprintf(
			"INSERT INTO receipt_payment_types
			(user_id,payment_type_for_sale_id,total)
			VALUES (%d,%d,0)",
			$user_id,$p->getDbVal('payment_type_for_sale_id')
		));
	}
	
	public function set_payment_type_total($pm){
		$user_id = $_SESSION['user_id'];
		if (!isset($user_id)){
			throw new Exception('Не задан пользователь!');
		}
	
		$p = new ParamsSQL($pm,$this->getDbLink());
		$p->addAll();

		$this->getDbLinkMaster()->query(sprintf(
			"UPDATE receipt_payment_types
			SET total=%f
			WHERE user_id=%d AND dt=%s",
			$p->getDbVal('total'),
			$user_id,
			$p->getDbVal('dt')			
		));
	}

	public function del_payment_type($pm){
		$user_id = $_SESSION['user_id'];
		if (!isset($user_id)){
			throw new Exception('Не задан пользователь!');
		}
	
		$p = new ParamsSQL($pm,$this->getDbLink());
		$p->addAll();

		$this->getDbLinkMaster()->query(sprintf(
			"DELETE FROM receipt_payment_types
			WHERE user_id=%d AND dt=%s",
			$user_id,
			$p->getDbVal('dt')			
		));
	}
	public function get_payment_type_list($pm){
		$user_id = $_SESSION['user_id'];
		if (!isset($user_id)){
			throw new Exception('Не задан пользователь!');
		}
	
		//payment type
		$this->addNewModel(sprintf("SELECT * FROM receipt_payment_types_list WHERE user_id=%d",$user_id),
		'ReceiptPaymentTypeList_Model');				
	}
	

}
?>