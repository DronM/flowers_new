<?php

require_once(FRAME_WORK_PATH.'basic_classes/ControllerSQLDOC.php');

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
class DOCSale_Controller extends ControllerSQLDOC{
	public function __construct($dbLinkMaster=NULL){
		parent::__construct($dbLinkMaster);
			
		/* insert */
		$pm = new PublicMethod('insert');
		$param = new FieldExtDateTime('date_time'
				,array('required'=>TRUE,
				'alias'=>'Дата'
			));
		$pm->addParam($param);
		$param = new FieldExtInt('number'
				,array(
				'alias'=>'Номер'
			));
		$pm->addParam($param);
		$param = new FieldExtBool('processed'
				,array(
				'alias'=>'Проведен'
			));
		$pm->addParam($param);
		$param = new FieldExtInt('store_id'
				,array(
				'alias'=>'Магазин'
			));
		$pm->addParam($param);
		$param = new FieldExtInt('user_id'
				,array(
				'alias'=>'Продавец'
			));
		$pm->addParam($param);
		$param = new FieldExtInt('payment_type_for_sale_id'
				,array(
				'alias'=>'Магазин'
			));
		$pm->addParam($param);
		$param = new FieldExtFloat('total'
				,array(
				'alias'=>'Сумма'
			));
		$pm->addParam($param);
		$param = new FieldExtFloat('total_material_cost'
				,array(
				'alias'=>'Себест.материалов'
			));
		$pm->addParam($param);
		$param = new FieldExtFloat('total_product_cost'
				,array(
				'alias'=>'Себест.продукции'
			));
		$pm->addParam($param);
		$param = new FieldExtInt('client_id'
				,array(
				'alias'=>'Клиент'
			));
		$pm->addParam($param);
		
		$pm->addParam(new FieldExtInt('ret_id'));
		
		
		$this->addPublicMethod($pm);
		$this->setInsertModelId('DOCSale_Model');

			
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
			
				'alias'=>'Дата'
			));
			$pm->addParam($param);
		$param = new FieldExtInt('number'
				,array(
			
				'alias'=>'Номер'
			));
			$pm->addParam($param);
		$param = new FieldExtBool('processed'
				,array(
			
				'alias'=>'Проведен'
			));
			$pm->addParam($param);
		$param = new FieldExtInt('store_id'
				,array(
			
				'alias'=>'Магазин'
			));
			$pm->addParam($param);
		$param = new FieldExtInt('user_id'
				,array(
			
				'alias'=>'Продавец'
			));
			$pm->addParam($param);
		$param = new FieldExtInt('payment_type_for_sale_id'
				,array(
			
				'alias'=>'Магазин'
			));
			$pm->addParam($param);
		$param = new FieldExtFloat('total'
				,array(
			
				'alias'=>'Сумма'
			));
			$pm->addParam($param);
		$param = new FieldExtFloat('total_material_cost'
				,array(
			
				'alias'=>'Себест.материалов'
			));
			$pm->addParam($param);
		$param = new FieldExtFloat('total_product_cost'
				,array(
			
				'alias'=>'Себест.продукции'
			));
			$pm->addParam($param);
		$param = new FieldExtInt('client_id'
				,array(
			
				'alias'=>'Клиент'
			));
			$pm->addParam($param);
		
			$param = new FieldExtInt('id',array(
			));
			$pm->addParam($param);
		
		
			$this->addPublicMethod($pm);
			$this->setUpdateModelId('DOCSale_Model');

			
		/* delete */
		$pm = new PublicMethod('delete');
		
		$pm->addParam(new FieldExtInt('id'
		));		
		
		$pm->addParam(new FieldExtInt('count'));
		$pm->addParam(new FieldExtInt('from'));				
		$this->addPublicMethod($pm);					
		$this->setDeleteModelId('DOCSale_Model');

			
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
		
		$this->setListModelId('DOCSaleList_Model');
		
			
		/* get_object */
		$pm = new PublicMethod('get_object');
		$pm->addParam(new FieldExtInt('browse_mode'));
		
		$pm->addParam(new FieldExtInt('id'
		));
		
		$this->addPublicMethod($pm);
		$this->setObjectModelId('DOCSaleDialog_Model');		

			
		$pm = new PublicMethod('before_open');
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('doc_id',$opts));
	
			
		$this->addPublicMethod($pm);

			
		$pm = new PublicMethod('get_actions');
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('doc_id',$opts));
	
			
		$this->addPublicMethod($pm);

			
		$pm = new PublicMethod('get_print');
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('doc_id',$opts));
	
			
		$this->addPublicMethod($pm);
									
			
		$pm = new PublicMethod('get_mat_details');
		
				
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
					
		$pm->addParam(new FieldExtInt('from',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('count',$opts));
				
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('ord_fields',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('ord_directs',$opts));
					
			
		$this->addPublicMethod($pm);
												
			
		$pm = new PublicMethod('get_prod_details');
		
				
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
					
		$pm->addParam(new FieldExtInt('from',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('count',$opts));
				
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('ord_fields',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtString('ord_directs',$opts));
								
			
		$this->addPublicMethod($pm);
															
		
	}	
	public function insert($pm){
		//doc owner
		$pm->setParamValue('user_id',$_SESSION['user_id']);		
		parent::insert();		
		
		//SMS
		$ar = $this->getDbLink()->query_first('SELECT const_cel_phone_for_sms_val() AS val');
		send_service_sms($ar['val'],'Продажа');		
	}
	public function delete(){
		$link = $this->getDbLinkMaster();
		$link->query(
		sprintf("DELETE FROM doc_sales_t_tmp_materials WHERE login_id=%s",
		$_SESSION['LOGIN_ID']));		
		$link->query(
		sprintf("DELETE FROM doc_sales_t_tmp_products WHERE login_id=%s",
		$_SESSION['LOGIN_ID']));				
		parent::delete();		
	}
	
	
	public function get_print($pm){
		$this->addNewModel(
			sprintf(
			'SELECT number,
			get_date_str_rus(date_time::date) AS date_time_descr,
			store_descr,
			user_descr,
			payment_type_descr,
			format_money(total) AS total_descr
			FROM doc_sales_list_view
			WHERE id=%d',
			$pm->getParamValue('doc_id')),
		'head');
		$this->addNewModel(
			sprintf(
			'SELECT line_number,
			material_descr,
			quant,
			format_money(price) AS price_descr,
			format_money(total) AS total_descr,
			total
			FROM doc_sales_t_materials_list_view
			WHERE doc_id=%d
			ORDER BY line_number',
			$pm->getParamValue('doc_id')),
		'materials');		
		$this->addNewModel(
			sprintf(
			'SELECT line_number,
			product_descr,
			quant,
			format_money(price) AS price_descr,
			format_money(total) AS total_descr
			FROM doc_sales_t_products_list_view
			WHERE doc_id=%d
			ORDER BY line_number',
			$pm->getParamValue('doc_id')),
		'products');				
	}
	public function get_prod_details($pm){		
		$model = new DOCSaleProductList_Model($this->getDbLink());	
		$from = null; $count = null;
		$limit = $this->limitFromParams($pm,$from,$count);
		$calc_total = ($count>0);
		if ($from){
			$model->setListFrom($from);
		}
		if ($count){
			$model->setRowsPerPage($count);
		}		
		$order = $this->orderFromParams($pm,$model);
		$where = $this->conditionFromParams($pm,$model);
		$fields = $this->fieldsFromParams($pm);		
		
		$model->select(FALSE,$where,$order,
			$limit,$fields,NULL,NULL,
			$calc_total,TRUE);
		$this->addModel($model);
	}
	public function get_mat_details($pm){		
		$model = new DOCSaleMaterialList_Model($this->getDbLink());	
		$from = null; $count = null;
		$limit = $this->limitFromParams($pm,$from,$count);
		$calc_total = ($count>0);
		if ($from){
			$model->setListFrom($from);
		}
		if ($count){
			$model->setRowsPerPage($count);
		}		
		$order = $this->orderFromParams($pm,$model);
		$where = $this->conditionFromParams($pm,$model);
		$fields = $this->fieldsFromParams($pm);		
		
		$model->select(FALSE,$where,$order,
			$limit,$fields,NULL,NULL,
			$calc_total,TRUE);
		$this->addModel($model);
	}
	

}
?>
