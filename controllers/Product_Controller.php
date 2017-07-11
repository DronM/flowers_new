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
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once('models/ProductBalanceList_Model.php');

class Product_Controller extends ControllerSQL{
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
				,array('required'=>TRUE,
				'alias'=>'Описание'
			));
		$pm->addParam($param);
		$param = new FieldExtFloat('price'
				,array('required'=>TRUE,
				'alias'=>'Розничная цена'
			));
		$pm->addParam($param);
		$param = new FieldExtBool('for_sale'
				,array(
				'alias'=>'Для продажи'
			));
		$pm->addParam($param);
		$param = new FieldExtBool('make_order'
				,array(
				'alias'=>'Заказывать автоматически'
			));
		$pm->addParam($param);
		$param = new FieldExtFloat('min_stock_quant'
				,array(
				'alias'=>'Минимальный остаток'
			));
		$pm->addParam($param);
		
		$pm->addParam(new FieldExtInt('ret_id'));
		
		
		$this->addPublicMethod($pm);
		$this->setInsertModelId('Product_Model');

			
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
			
				'alias'=>'Описание'
			));
			$pm->addParam($param);
		$param = new FieldExtFloat('price'
				,array(
			
				'alias'=>'Розничная цена'
			));
			$pm->addParam($param);
		$param = new FieldExtBool('for_sale'
				,array(
			
				'alias'=>'Для продажи'
			));
			$pm->addParam($param);
		$param = new FieldExtBool('make_order'
				,array(
			
				'alias'=>'Заказывать автоматически'
			));
			$pm->addParam($param);
		$param = new FieldExtFloat('min_stock_quant'
				,array(
			
				'alias'=>'Минимальный остаток'
			));
			$pm->addParam($param);
		
			$param = new FieldExtInt('id',array(
			
				'alias'=>'Код'
			));
			$pm->addParam($param);
		
		
			$this->addPublicMethod($pm);
			$this->setUpdateModelId('Product_Model');

			
		/* delete */
		$pm = new PublicMethod('delete');
		
		$pm->addParam(new FieldExtInt('id'
		));		
		
		$pm->addParam(new FieldExtInt('count'));
		$pm->addParam(new FieldExtInt('from'));				
		$this->addPublicMethod($pm);					
		$this->setDeleteModelId('Product_Model');

			
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
		
		$this->setListModelId('ProductList_Model');
		
			
		/* get_object */
		$pm = new PublicMethod('get_object');
		$pm->addParam(new FieldExtInt('browse_mode'));
		
		$pm->addParam(new FieldExtInt('id'
		));
		
		$this->addPublicMethod($pm);
		$this->setObjectModelId('Product_Model');		

			
		/* complete  */
		$pm = new PublicMethod('complete');
		$pm->addParam(new FieldExtString('pattern'));
		$pm->addParam(new FieldExtInt('count'));
		$pm->addParam(new FieldExtInt('ic'));
		$pm->addParam(new FieldExtInt('mid'));
		$pm->addParam(new FieldExtString('price'));		
		$this->addPublicMethod($pm);					
		$this->setCompleteModelId('ProductList_Model');

			
		$pm = new PublicMethod('complete_for_spec');
		
				
	$opts=array();
	
		$opts['alias']='Наименование';		
		$pm->addParam(new FieldExtString('name',$opts));
	
			
		$this->addPublicMethod($pm);

			
		$pm = new PublicMethod('get_list_with_balance');
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('cond_fields',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('cond_vals',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('cond_sgns',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('cond_ic',$opts));
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('field_sep',$opts));
			
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('from',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('count',$opts));
				
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('ord_fields',$opts));
				
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('ord_directs',$opts));
				
			
		$this->addPublicMethod($pm);

			
		$pm = new PublicMethod('get_list_for_sale');
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('cond_fields',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('cond_vals',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('cond_sgns',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('cond_ic',$opts));
				
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('from',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('count',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('ord_fields',$opts));
				
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('ord_directs',$opts));
								
			
		$this->addPublicMethod($pm);
			
			
		$pm = new PublicMethod('get_price');
		
				
	$opts=array();
	
		$opts['required']=TRUE;				
		$pm->addParam(new FieldExtInt('product_id',$opts));
	
			
		$this->addPublicMethod($pm);
	
		
	}
	
	public function get_list_with_balance($pm){
		$link = $this->getDbLink();		
		//$model = new ModelSQL($link,array('id'=>'get_list_with_balance'));	
		$model = new ProductBalanceList_Model($link);	
		//$model->addField(new FieldSQLInt($link,null,null,"store_id",DT_INT));
		$where = $this->conditionFromParams($pm,$model);
		
		if (isset($_SESSION['global_store_id'])){
			$store_id = $_SESSION['global_store_id'];
		}
		else if ($where){
			$store_id = $where->getFieldValueForDb('store_id','e',0,'');
		}
		else{
			$store_id = '1';
		}
		
		$q = sprintf("SELECT * FROM product_list_with_balance(%d)",$store_id);
			
		if (!is_null($where)){
			$q.=' '.$where->getSQL();
		}
		
		$model->setSelectQueryText($q);
		
		$model->select(false,null,null,
			null,null,null,null,null,TRUE);
		//
		$this->addModel($model);		
	}
	public function get_list_for_sale($pm){
		if (isset($_SESSION['user_id'])){
			$user_id = $_SESSION['user_id'];
		}
		if (!isset($user_id)){
			throw new Exception('Пустое значение пользователя!');
		}
	
		$store_id = NULL;
		if (isset($_SESSION['global_store_id'])){
			$store_id = $_SESSION['global_store_id'];
		}
		if (!isset($store_id)){
			throw new Exception('Пустое значение салона!');
		}
		$this->addNewModel(
		sprintf('SELECT * FROM product_list_for_sale(%d)',$store_id),
		'get_list_for_sale');		
		
		//selected items
		$this->addNewModel(
		sprintf('SELECT * FROM receipts_list_view WHERE user_id=%d',$user_id),
		'ReceiptList_Model');		
		
		//selected head
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
			WHERE h.user_id=%d",$user_id),
		'ReceiptHeadList_Model');				

		//payment type
		$this->addNewModel(sprintf("SELECT * FROM receipt_payment_types_list WHERE user_id=%d",$user_id),
		'ReceiptPaymentTypeList_Model');				

		//payment types
		$this->addNewModel("SELECT * FROM payment_types_for_sale ORDER BY name",
		'PaymentTypeForSale_Model');				
		
	}
	public function get_price($pm){
		$product_id = $pm->getParamValue('product_id');
		if (!isset($product_id)){
			throw new Exception('Пустое значение букета!');
		}
		$this->addNewModel(
		sprintf('SELECT 
			price,
			format_money(price) AS price_descr
		FROM products WHERE id=%d',$product_id),
		'get_price');		
	}	
	public function complete_for_spec($pm){
		$q = sprintf("SELECT
		DISTINCT p.id,
			p.name||', код: '||d_p.number AS name
		FROM ra_products AS ra
		LEFT JOIN products AS p
			ON p.id=ra.product_id AND
			ra.doc_type='production'::doc_types
		LEFT JOIN doc_productions AS d_p ON d_p.id=ra.doc_id
		WHERE lower(p.name) LIKE lower('%s%%')",
		$pm->getParamValue('name'));
		//throw new Exception($q);
		$this->addNewModel($q,'complete_for_spec');			
	}
}
?>