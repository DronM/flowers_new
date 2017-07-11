<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="Controller_php.xsl"/>

<!-- -->
<xsl:variable name="CONTROLLER_ID" select="'Product'"/>
<!-- -->

<xsl:output method="text" indent="yes"
			doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" 
			doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
			
<xsl:template match="/">
	<xsl:apply-templates select="metadata/controllers/controller[@id=$CONTROLLER_ID]"/>
</xsl:template>

<xsl:template match="controller"><![CDATA[<?php]]>
<xsl:call-template name="add_requirements"/>
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once('models/ProductBalanceList_Model.php');

class <xsl:value-of select="@id"/>_Controller extends ControllerSQL{
	public function __construct($dbLinkMaster=NULL){
		parent::__construct($dbLinkMaster);<xsl:apply-templates/>
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
<![CDATA[?>]]>
</xsl:template>

</xsl:stylesheet>
