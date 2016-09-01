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
					
		$pm->addParam(new FieldExtString('code',$opts));
	
			
		$this->addPublicMethod($pm);
						
			
		$pm = new PublicMethod('fill_on_client_order');
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('doc_client_order_id',$opts));
	
			
		$this->addPublicMethod($pm);
						
		
	}	
	
	public function insert($pm){
		//doc owner
		$pm->setParamValue('user_id',$_SESSION['user_id']);		
		parent::insert();		
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
	public function clear($pm){
		$link = $this->getDbLinkMaster();
		$link->query(
			sprintf("DELETE FROM receipts WHERE user_id=%d",
			$_SESSION['user_id']));
	}
	public function close($pm){
		$store_id = $_SESSION['global_store_id'];
		if (!isset($store_id)){
			throw new Exception('Не задан салон!');
		}
		
		$p = new ParamsSQL($pm,$this->getDbLink());
		$p->addAll();
		
		$pt = $p->getDbVal('payment_type_for_sale_id');
		$pt = ($pt=='null')? 1:$pt;
		
		$link = $this->getDbLinkMaster();
		$link->query(
			sprintf("SELECT receipt_close(%d,%d,%s,%s,%s)",
			$store_id,$_SESSION['user_id'],
			$pt,
			$p->getDbVal('client_id'),
			$p->getDbVal('doc_client_order_id')
			)
		);
		//SMS
		$ar = $this->getDbLink()->query_first('SELECT const_cel_phone_for_sms_val() AS val');
		//send_service_sms($ar['val'],'Продажа');					
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
		$p->add('code',DT_STRING,$pm->getParamValue('code'));
		
		$full_code = $p->getVal('code');
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
	}
	

}
?>
