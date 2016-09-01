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
class DOCProductDisposal_Controller extends ControllerSQLDOC{
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
				'alias'=>'Флорист'
			));
		$pm->addParam($param);
		$param = new FieldExtInt('doc_production_id'
				,array('required'=>TRUE,
				'alias'=>'Комплектация'
			));
		$pm->addParam($param);
		$param = new FieldExtText('explanation'
				,array(
				'alias'=>'Причина списания'
			));
		$pm->addParam($param);
		
		$pm->addParam(new FieldExtInt('ret_id'));
		
		
		$this->addPublicMethod($pm);
		$this->setInsertModelId('DOCProductDisposal_Model');

			
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
			
				'alias'=>'Флорист'
			));
			$pm->addParam($param);
		$param = new FieldExtInt('doc_production_id'
				,array(
			
				'alias'=>'Комплектация'
			));
			$pm->addParam($param);
		$param = new FieldExtText('explanation'
				,array(
			
				'alias'=>'Причина списания'
			));
			$pm->addParam($param);
		
			$param = new FieldExtInt('id',array(
			));
			$pm->addParam($param);
		
		
			$this->addPublicMethod($pm);
			$this->setUpdateModelId('DOCProductDisposal_Model');

			
		/* delete */
		$pm = new PublicMethod('delete');
		
		$pm->addParam(new FieldExtInt('id'
		));		
		
		$pm->addParam(new FieldExtInt('count'));
		$pm->addParam(new FieldExtInt('from'));				
		$this->addPublicMethod($pm);					
		$this->setDeleteModelId('DOCProductDisposal_Model');

			
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
		
		$this->setListModelId('DOCProductDisposalList_Model');
		
			
		/* get_object */
		$pm = new PublicMethod('get_object');
		$pm->addParam(new FieldExtInt('browse_mode'));
		
		$pm->addParam(new FieldExtInt('id'
		));
		
		$this->addPublicMethod($pm);
		$this->setObjectModelId('DOCProductDisposalList_Model');		

			
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

			
		$pm = new PublicMethod('get_details');
		
				
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
	}
	public function fill_on_spec($pm){
		$link = $this->getDbLinkMaster();		
		$link->query(
		sprintf("SELECT doc_product_disposals_fill_on_spec(%d,%d,%f)",
		$_SESSION['LOGIN_ID'],$pm->getParamValue('product_id'),
		$pm->getParamValue('product_quant'))
		);
	}	
	public function before_open($pm){
	}	
	
	public function get_print($pm){
		$this->addNewModel(
			sprintf(
			'SELECT number,
			product_descr,
			doc_production_descr,
			get_date_str_rus(date_time::date) AS date_time_descr,
			store_descr,
			user_descr,
			explanation
			FROM doc_product_disposals_list_view
			WHERE id=%d',
			$pm->getParamValue('doc_id')),
		'head');
		$this->addNewModel(
			sprintf(
			'SELECT 
			m.name AS material_descr,
			format_quant(ra.quant) AS quant
			FROM ra_materials AS ra
			LEFT JOIN materials AS m ON m.id=ra.material_id
			WHERE doc_id=%d
			ORDER BY material_descr',
			$pm->getParamValue('doc_id')),
		'materials');		
	}
	public function get_details($pm){		
		$model = new DOCProductDisposalMaterialList_Model($this->getDbLink());	
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
		$material_group_id = $where->getFieldValueForDb('material_group_id','=',0,0);
		if ($material_group_id==0){
			//throw new Exception($material_group_id);
			$where->deleteField('material_group_id','=');
		}
		
		$model->select(FALSE,$where,$order,
			$limit,$fields,NULL,NULL,
			$calc_total,TRUE);
		//
		$this->addModel($model);
	}		
}
?>
