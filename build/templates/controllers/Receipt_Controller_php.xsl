<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="Controller_php.xsl"/>

<!-- -->
<xsl:variable name="CONTROLLER_ID" select="'Receipt'"/>
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

require_once(FRAME_WORK_PATH.'basic_classes/ParamsSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/ModelVars.php');

class <xsl:value-of select="@id"/>_Controller extends ControllerSQL{
	public function __construct($dbLinkMaster=NULL){
		parent::__construct($dbLinkMaster);<xsl:apply-templates/>
	}	
	<xsl:call-template name="extra_methods"/>
}
<![CDATA[?>]]>
</xsl:template>

<xsl:template name="extra_methods">
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
			for ($i=1;$i&lt;=strlen($full_code);$i++){
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
			if (is_array($ar)&amp;&amp;count($ar)){			
				
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
	
</xsl:template>

</xsl:stylesheet>