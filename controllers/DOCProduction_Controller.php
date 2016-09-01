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

require_once('common/barcode.php');
require_once('common/barcodegen.1d-php5.v5.2.1/class/BCGFontFile.php');
require_once('common/barcodegen.1d-php5.v5.2.1/class/BCGColor.php');
require_once('common/barcodegen.1d-php5.v5.2.1/class/BCGDrawing.php');
require_once('common/barcodegen.1d-php5.v5.2.1/class/BCGean13.barcode.php');

require_once(FRAME_WORK_PATH.'basic_classes/ModelVars.php');
require_once(FRAME_WORK_PATH.'basic_classes/Field.php');

class DOCProduction_Controller extends ControllerSQLDOC{
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
		$param = new FieldExtInt('product_id'
				,array('required'=>TRUE,
				'alias'=>'Букет'
			));
		$pm->addParam($param);
		
				$param = new FieldExtEnum('product_order_type',',','sale,disposal,manual'
				,array(
				'alias'=>'Вид заявки'
			));
		$pm->addParam($param);
		$param = new FieldExtBool('on_norm'
				,array(
				'alias'=>'По норме'
			));
		$pm->addParam($param);
		$param = new FieldExtFloat('quant'
				,array(
				'alias'=>'Количество'
			));
		$pm->addParam($param);
		$param = new FieldExtFloat('price'
				,array(
				'alias'=>'Цена'
			));
		$pm->addParam($param);
		$param = new FieldExtText('florist_comment'
				,array(
				'alias'=>'Комментарий'
			));
		$pm->addParam($param);
		
		$pm->addParam(new FieldExtInt('ret_id'));
		
		
		$this->addPublicMethod($pm);
		$this->setInsertModelId('DOCProduction_Model');

			
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
		$param = new FieldExtInt('product_id'
				,array(
			
				'alias'=>'Букет'
			));
			$pm->addParam($param);
		
				$param = new FieldExtEnum('product_order_type',',','sale,disposal,manual'
				,array(
			
				'alias'=>'Вид заявки'
			));
			$pm->addParam($param);
		$param = new FieldExtBool('on_norm'
				,array(
			
				'alias'=>'По норме'
			));
			$pm->addParam($param);
		$param = new FieldExtFloat('quant'
				,array(
			
				'alias'=>'Количество'
			));
			$pm->addParam($param);
		$param = new FieldExtFloat('price'
				,array(
			
				'alias'=>'Цена'
			));
			$pm->addParam($param);
		$param = new FieldExtText('florist_comment'
				,array(
			
				'alias'=>'Комментарий'
			));
			$pm->addParam($param);
		
			$param = new FieldExtInt('id',array(
			));
			$pm->addParam($param);
		
		
			$this->addPublicMethod($pm);
			$this->setUpdateModelId('DOCProduction_Model');

			
		/* delete */
		$pm = new PublicMethod('delete');
		
		$pm->addParam(new FieldExtInt('id'
		));		
		
		$pm->addParam(new FieldExtInt('count'));
		$pm->addParam(new FieldExtInt('from'));				
		$this->addPublicMethod($pm);					
		$this->setDeleteModelId('DOCProduction_Model');

			
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
		
		$this->setListModelId('DOCProductionList_Model');
		
			
		/* get_object */
		$pm = new PublicMethod('get_object');
		$pm->addParam(new FieldExtInt('browse_mode'));
		
		$pm->addParam(new FieldExtInt('id'
		));
		
		$this->addPublicMethod($pm);
		$this->setObjectModelId('DOCProductionList_Model');		

			
		$pm = new PublicMethod('before_open');
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('doc_id',$opts));
	
			
		$this->addPublicMethod($pm);

			
		$pm = new PublicMethod('fill_on_spec');
		
				
	$opts=array();
	
		$opts['required']=TRUE;				
		$pm->addParam(new FieldExtInt('product_id',$opts));
	
				
	$opts=array();
	
		$opts['required']=TRUE;
		$opts['value']=1;				
		$pm->addParam(new FieldExtFloat('product_quant',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('store_id',$opts));
	
			
		$this->addPublicMethod($pm);
			
			
		$pm = new PublicMethod('get_balance_list');
		
		$this->addPublicMethod($pm);

			
		$pm = new PublicMethod('get_current_doc_cost');
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('store_id',$opts));
	
			
		$this->addPublicMethod($pm);

			
		$pm = new PublicMethod('add_to_open_doc');
		
				
	$opts=array();
	
		$opts['required']=TRUE;				
		$pm->addParam(new FieldExtInt('product_id',$opts));
	
				
	$opts=array();
	
		$opts['required']=TRUE;				
		$pm->addParam(new FieldExtInt('material_id',$opts));
	
			
		$this->addPublicMethod($pm);
						
			
		$pm = new PublicMethod('get_actions');
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('doc_id',$opts));
	
			
		$this->addPublicMethod($pm);

			
		$pm = new PublicMethod('get_print');
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('doc_id',$opts));
	
			
		$this->addPublicMethod($pm);
									
			
		$pm = new PublicMethod('print_barcode');
		
				
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
		//SMS
		$ar = $this->getDbLink()->query_first('SELECT const_cel_phone_for_sms_val() AS val');
		send_service_sms($ar['val'],'Комплектация');				
	}
	public function fill_on_spec($pm){
		if (isset($_SESSION['global_store_id'])){
			$store_id = $_SESSION['global_store_id'];
		}
		else{
			$store_id = $pm->getParamValue('store_id');
		}
		if (!isset($store_id)){
			throw new Exception("Не задан салон!");
		}
		
		$link = $this->getDbLinkMaster();
		$link->query(
		sprintf("SELECT doc_productions_fill_on_spec(%d,%d,%d,%f)",
		$_SESSION['LOGIN_ID'],$store_id,$pm->getParamValue('product_id'),
		$pm->getParamValue('product_quant'))
		);
	}	
	public function get_balance_list($pm){
		if (isset($_SESSION['global_store_id'])){
			$store_id = $_SESSION['global_store_id'];
		}
		else{
			$store_id = $pm->getParamValue('store_id');
		}
		if (!isset($store_id)){
			throw new Exception("Не задан салон!");
		}	
		$this->addNewModel(
			sprintf("SELECT * FROM doc_productions_list_with_balance(%d)",
			$store_id)
		,'get_balance_list');			
	}
	public function get_current_doc_cost($pm){
		if (isset($_SESSION['global_store_id'])){
			$store_id = $_SESSION['global_store_id'];
		}
		else{
			$store_id = $pm->getParamValue('store_id');
		}
		if (!isset($store_id)){
			throw new Exception("Не задан салон!");
		}	
		$this->addNewModel(
			sprintf("SELECT * FROM doc_productions_open_doc_cost(%d,%d)",
			$store_id,$_SESSION['LOGIN_ID'])
		,'get_current_doc_cost');			
	}
	public function add_to_open_doc($pm){
		if (isset($_SESSION['LOGIN_ID'])){
			$login_id = $_SESSION['LOGIN_ID'];
		}
		else{
			throw new Exception("Не задан логин!");
		}
		$product_id = $pm->getParamValue('product_id');
		$material_id = $pm->getParamValue('material_id');
		
		$link = $this->getDbLinkMaster();
		$link->query(sprintf('SELECT doc_productions_add_to_open_doc(%d,%d,%d)',
		$login_id,
		$product_id,
		$material_id
		));
	}
	public function get_print($pm){
		$this->addNewModel(
			sprintf(
			'SELECT number,
			get_date_str_rus(date_time::date) AS date_time_descr,
			store_descr,
			user_descr,
			product_id,
			product_descr,
			format_quant(quant) AS quant,
			price_descr,
			sum_descr,
			mat_sum_descr,
			on_norm
			FROM doc_productions_list_view
			WHERE id=%d',
			$pm->getParamValue('doc_id')),
		'head');
		$this->addNewModel(
			sprintf(
			'SELECT 
			t.line_number,
			m.name AS material_descr,
			format_quant(t.quant) AS quant,
			format_quant(t.quant_norm) AS quant_norm,
			format_money(m.price) AS price_descr,
			format_money(m.price*t.quant) AS total_descr
			FROM doc_productions_t_materials AS t
			LEFT JOIN materials AS m ON m.id=t.material_id
			WHERE doc_id=%d
			ORDER BY line_number',
			$pm->getParamValue('doc_id')),
		'materials');		
	}
	public function get_details($pm){		
		$model = new DOCProductionMaterialList_Model($this->getDbLink());	
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
	public function print_barcode($pm){
		$ar = $this->getDbLink()->query_first(sprintf(
			"SELECT
				number,
				date8_descr(date_time::date) AS date_time_descr,
				store_descr,
				user_descr,
				product_descr,
				sum_descr
			FROM doc_productions_list_view
			WHERE id=%d",
			$pm->getParamValue('doc_id')
		));
		if (!is_array($ar)||!count($ar)){
			throw new Exception('Document not found!');
		}
		/*
		всего 13 знаков
		1: 0 - букет, 1 -материал
		11 - номер документа/код материала
		1 - КС		
		*/
		$barcode_descr = '0'.substr('00000000000',1,11-strlen($ar['number'])).$ar['number'];
		$barcode_descr = $barcode_descr.EAN_check_sum($barcode_descr,13);
		//$barcode = ean13($barcode_descr);
		
		//**** Генерация баркода ****
		$colorFont = new BCGColor(0, 0, 0);
		$colorBack = new BCGColor(255, 255, 255);		
		//$font = new BCGFontFile('common/barcodegen.1d-php5.v5.2.1/font/Arial.ttf', 18);		
		$code = new BCGean13(); // Or another class name from the manual
		$code->setScale(1); // Resolution
		$code->setThickness(30); // Thickness
		$code->setForegroundColor($colorFont); // Color of bars
		$code->setBackgroundColor($colorBack); // Color of spaces
		$code->setFont(0); // Font (or 0) $font
		$code->parse($barcode_descr); // Text
		$drawing = new BCGDrawing('', $colorBack);
		$drawing->setBarcode($code);
		$drawing->draw();
		ob_start();
		$drawing->finish(BCGDrawing::IMG_FORMAT_PNG);
		$contents = ob_get_contents();
		ob_end_clean();
		//**** Генерация баркода ****
		
		$fields = array(
			new Field('number',DT_STRING,array('value'=>$ar['number'])),
			new Field('date_time_descr',DT_STRING,array('value'=>$ar['date_time_descr'])),
			new Field('store_descr',DT_STRING,array('value'=>$ar['store_descr'])),
			new Field('user_descr',DT_STRING,array('value'=>$ar['user_descr'])),
			new Field('product_descr',DT_STRING,array('value'=>$ar['product_descr'])),
			new Field('sum_descr',DT_STRING,array('value'=>$ar['sum_descr'])),
			//new Field('barcode',DT_STRING,array('value'=>$barcode)),
			new Field('barcode_descr',DT_STRING,array('value'=>$barcode_descr)),
			new Field('barcode_img_mime',DT_STRING,array('value'=>'image/png')),				
			new Field('barcode_img',DT_STRING,array('value'=>base64_encode($contents)))
		);
		$this->addModel(new ModelVars(
			array('id'=>'head',
				'values'=>$fields)
			)
		);
		//Добавим номенклатурный состав букета
		$this->addNewModel(sprintf(
		"SELECT
			t.material_descr,
			t.quant
		FROM doc_productions_t_materials_list_view t
		WHERE t.doc_id=%d
		ORDER BY t.line_number",
		$pm->getParamValue('doc_id')
		),
		't_materials');
	}
	
}
?>
