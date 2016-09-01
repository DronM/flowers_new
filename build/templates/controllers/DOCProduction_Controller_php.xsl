<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="Controller_php.xsl"/>

<!-- -->
<xsl:variable name="CONTROLLER_ID" select="'DOCProduction'"/>
<!-- -->

<xsl:output method="text" indent="yes"
			doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" 
			doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
			
<xsl:template match="/">
	<xsl:apply-templates select="metadata/controllers/controller[@id=$CONTROLLER_ID]"/>
</xsl:template>

<xsl:template match="controller"><![CDATA[<?php]]>
<xsl:call-template name="add_requirements"/>
require_once('functions/SMS.php');

require_once('common/barcode.php');
require_once('common/barcodegen.1d-php5.v5.2.1/class/BCGFontFile.php');
require_once('common/barcodegen.1d-php5.v5.2.1/class/BCGColor.php');
require_once('common/barcodegen.1d-php5.v5.2.1/class/BCGDrawing.php');
require_once('common/barcodegen.1d-php5.v5.2.1/class/BCGean13.barcode.php');

require_once(FRAME_WORK_PATH.'basic_classes/ModelVars.php');
require_once(FRAME_WORK_PATH.'basic_classes/Field.php');

class <xsl:value-of select="@id"/>_Controller extends ControllerSQLDOC{
	public function __construct($dbLinkMaster=NULL){
		parent::__construct($dbLinkMaster);<xsl:apply-templates/>
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
<![CDATA[?>]]>
</xsl:template>

</xsl:stylesheet>