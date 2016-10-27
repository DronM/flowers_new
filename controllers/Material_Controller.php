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
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/CondParamsSQL.php');

require_once('common/barcode.php');
require_once('common/barcodegen.1d-php5.v5.2.1/class/BCGFontFile.php');
require_once('common/barcodegen.1d-php5.v5.2.1/class/BCGColor.php');
require_once('common/barcodegen.1d-php5.v5.2.1/class/BCGDrawing.php');
require_once('common/barcodegen.1d-php5.v5.2.1/class/BCGean13.barcode.php');

require_once(FRAME_WORK_PATH.'basic_classes/ModelVars.php');
require_once(FRAME_WORK_PATH.'basic_classes/Field.php');

require_once(FRAME_WORK_PATH.'basic_classes/ModelWhereSQL.php');

class Material_Controller extends ControllerSQL{
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
		$param = new FieldExtInt('margin_percent'
				,array(
				'alias'=>'Наценка (%)'
			));
		$pm->addParam($param);
		$param = new FieldExtInt('material_group_id'
				,array('required'=>TRUE,
				'alias'=>'Группа'
			));
		$pm->addParam($param);
		
		$pm->addParam(new FieldExtInt('ret_id'));
		
		
		$this->addPublicMethod($pm);
		$this->setInsertModelId('Material_Model');

			
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
		$param = new FieldExtInt('margin_percent'
				,array(
			
				'alias'=>'Наценка (%)'
			));
			$pm->addParam($param);
		$param = new FieldExtInt('material_group_id'
				,array(
			
				'alias'=>'Группа'
			));
			$pm->addParam($param);
		
			$param = new FieldExtInt('id',array(
			
				'alias'=>'Код'
			));
			$pm->addParam($param);
		
		
			$this->addPublicMethod($pm);
			$this->setUpdateModelId('Material_Model');

			
		/* delete */
		$pm = new PublicMethod('delete');
		
		$pm->addParam(new FieldExtInt('id'
		));		
		
		$pm->addParam(new FieldExtInt('count'));
		$pm->addParam(new FieldExtInt('from'));				
		$this->addPublicMethod($pm);					
		$this->setDeleteModelId('Material_Model');

			
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
		
		$this->setListModelId('MaterialList_Model');
		
			
		/* get_object */
		$pm = new PublicMethod('get_object');
		$pm->addParam(new FieldExtInt('browse_mode'));
		
		$pm->addParam(new FieldExtInt('id'
		));
		
		$this->addPublicMethod($pm);
		$this->setObjectModelId('Material_Model');		

			
		/* complete  */
		$pm = new PublicMethod('complete');
		$pm->addParam(new FieldExtString('pattern'));
		$pm->addParam(new FieldExtInt('count'));
		$pm->addParam(new FieldExtInt('ic'));
		$pm->addParam(new FieldExtInt('mid'));
		$pm->addParam(new FieldExtString('name'));		
		$this->addPublicMethod($pm);					
		$this->setCompleteModelId('MaterialList_Model');

			
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

			
		$pm = new PublicMethod('get_balance_list');
		
				
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
			
			
		$pm = new PublicMethod('get_list_for_sale');
		
				
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
			
			
		$pm = new PublicMethod('material_procur_plan_report');
		
				
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
			
			
		$pm = new PublicMethod('procur_avg_price_report');
		
				
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
						
			
		$pm = new PublicMethod('actions_report');
		
				
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
									
			
		$pm = new PublicMethod('print_barcode');
		
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('material_id',$opts));
	
			
		$this->addPublicMethod($pm);
			
		
	}
	
	public function get_list_with_balance($pm){
		$link = $this->getDbLink();		
		$model = new MaterialBalanceList_Model($link);	
		$where = $this->conditionFromParams($pm,$model);
		
		if (!$where){
			$where = new ModelWhereSQL();
			$where->addField(new FieldSQLInt($link,NULL,NULL,NULL,'group_id'));
			$where->addField(new FieldSQLDate($link,NULL,NULL,NULL,'date_time'),'=');
		}
		
		$group_id = $where->getFieldValueForDb('material_group_id','=');		
		if (is_null($group_id)){
			$ar = $link->query_first("SELECT const_def_material_group_val() AS val");
			$group_id = $ar['val'];
		}
		$date_time = $where->getFieldValueForDb('date_time','=',0,"'".date('Y-m-d H:i:s')."'");
		$count = 0;
		$from = 0;	
		$limit = $this->limitFromParams($pm,$from,$count);
		
		if (isset($_SESSION['global_store_id'])){
			$store_id = $_SESSION['global_store_id'];
		}
		else if ($where){
			$store_id = $where->getFieldValueForDb('store_id','=',0,'');
		}
		else{
			$store_id = '1';
		}
		
		$name = $where->getFieldValueForDb('name','LIKE');
		$name_q = '';
		if (!is_null($name)){
			$name_q = ' WHERE lower(name) LIKE lower('.$name.')';
		}
				
		$model->setSelectQueryText(
			sprintf("SELECT * FROM material_list_with_balance(%d,%d,%s)%s",$store_id,$group_id,$date_time,$name_q)
		);
		$model->select(false,null,null,
			$limit,null,null,null,null,TRUE);
		//
		$this->addModel($model);		
	}
	public function get_list_for_sale($pm){
		$link = $this->getDbLink();		
		$model = new ModelSQL($link,array('id'=>'get_list_with_balance'));	
		$model->addField(new FieldSQLInt($link,null,null,"group_id",DT_INT));
		$where = $this->conditionFromParams($pm,$model);
		$group_id = $where->getFieldValueForDb('group_id','=',0,'');
		if (isset($_SESSION['global_store_id'])){
			$store_id = $_SESSION['global_store_id'];
		}
		if (!isset($store_id)){
			throw new Exception('Пустое значение салона!');
		}
		$this->addNewModel(
			sprintf("SELECT * FROM material_list_for_sale(%d)
			WHERE group_id=%d",
			$store_id,$group_id)		
		,'get_list_for_sale');	
	}
	public function get_balance_list($pm){
		$link = $this->getDbLink();		
		$model = new ModelSQL($link,array('id'=>'get_balance_list'));	
		$model->addField(new FieldSQLInt($link,null,null,"store_id",DT_INT));
		$where = $this->conditionFromParams($pm,$model);
		
		$count = 0;
		$from = 0;	
		$limit = $this->limitFromParams($pm,$from,$count);
		if (isset($_SESSION['global_store_id'])){
			$store_id = $_SESSION['global_store_id'];
		}
		else if ($where){
			$store_id = $where->getFieldValueForDb('store_id','=',0,'');
		}
		if (!isset($store_id)){
			throw new Exception('Пустое значение салона!');
		}
		$group_id = ($where)? $where->getFieldValueForDb('material_group_id','=',0,'0'):0;
		$model->setSelectQueryText(
			sprintf("SELECT * FROM material_list_with_balance(%d,%d)",
			$store_id,$group_id)
		);
		$model->select(false,null,null,
			$limit,null,null,null,null,TRUE);
		//
		$this->addModel($model);		
	}
	public function material_procur_plan_report($pm){
		$cond = new CondParamsSQL($pm,$this->getDbLink());
		$day_count = $cond->getValForDb('day_count','e',DT_INT);
		if ($cond->paramExists('store_id','e')){
			$store_id = $cond->getValForDb('store_id','e',DT_INT);
		}
		
		if (isset($_SESSION['global_store_id'])){
			$store_id = $_SESSION['global_store_id'];
		}
		if (!isset($store_id)){
			throw new Exception('Пустое значение салона!');
		}
		
		$day_turnovers = '';
		$day_turnovers_from_sunday=array(1,1,1,1,1,1,1);
		for ($i = 1; $i <= 7; $i++) {
			$v = $cond->getValForDb('day_turnover_'.$i,'e',DT_FLOAT);
			$day_turnovers.= ($day_turnovers=='')? '':',';
			$day_turnovers.= $v;
			$day_turnovers_from_sunday[($i==7)? 0:$i]=$v;
		}
		$dt = mktime();
		$dow = date('N',$dt);
		if ($dow > 1){
			$dt = strtotime('-'.($dow-1).' days');
		}
		$date_from = date('Y-m-d',$dt);
		
		$f = sprintf("WITH day_ratios AS
			(SELECT '{%s}'::text[] AS ratio)
		SELECT
			dates.d::date AS date,
			date_part('day',dates.d::date)||' '||get_month_rus(dates.d::date) AS date_descr,
			dow_descr(dates.d::date) AS dow,
			(SELECT day_ratios.ratio[EXTRACT(DOW FROM dates.d::date)+1]
			FROM day_ratios
			) AS ratio
		FROM generate_series('%s','%s'::date+'%d days'::interval,'1 day') AS dates(d)",
		implode(',',$day_turnovers_from_sunday),
		$date_from,
		$date_from,
		$day_count-1);
		//days and ratios
		$this->addNewModel($f,'header');	
		
		$this->addNewModel(
		sprintf('SELECT * FROM material_procurement_plan(
			%d,ARRAY[%s],%d,%d)',
		$day_count,
		$day_turnovers,
		$cond->getValForDb('stock_day_count','e',DT_INT),
		$store_id
		),
		'material_procur_plan_report');	
	}
	public function procur_avg_price_report($pm){
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
		
		$this->addNewModel(
		sprintf('SELECT *
			FROM materials_avg_price(
			%s,%s,%d,%d)',
		$date_time_from,
		$date_time_to,
		$store_id,
		$cond->getValForDb('material_group_id','e',DT_INT)		
		));	
		
	}
	public function actions_report($pm){
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
		
		$this->addNewModel(
		sprintf('SELECT *
			FROM materials_actions(
			%s::timestamp,%s::timestamp,%d,%d)',
		$date_time_from,
		$date_time_to,
		$store_id,
		$cond->getValForDb('material_group_id','e',DT_INT)		
		));		
	}
	public function print_barcode($pm){
		if (isset($_SESSION['global_store_id'])){
			$store_id = $_SESSION['global_store_id'];
		}
		else{
			$store_id = 1;//???ToDo
		}
	
		$ar = $this->getDbLink()->query_first(sprintf(
			"SELECT
				m.id AS number,
				(SELECT st.name FROM stores st WHERE st.id=%d) AS store_descr,
				m.name AS product_descr,
				m.price sum_descr
			FROM materials_list_view AS m
			WHERE m.id=%d",
			$store_id,
			$pm->getParamValue('material_id')
		));
		if (!is_array($ar)||!count($ar)){
			throw new Exception('Material not found!');
		}
		/*
		всего 13 знаков
		1: 0 - букет, 1 -материал
		11 - номер документа/код материала
		1 - КС		
		*/
		$barcode_descr = '1'.substr('00000000000',1,11-strlen($ar['number'])).$ar['number'];
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
			new Field('store_descr',DT_STRING,array('value'=>$ar['store_descr'])),
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
	}
	
}
?>
