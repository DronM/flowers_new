<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="Controller_php.xsl"/>

<!-- -->
<xsl:variable name="CONTROLLER_ID" select="'DOCClientOrder'"/>
<!-- -->

<xsl:output method="text" indent="yes"
			doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" 
			doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
			
<xsl:template match="/">
	<xsl:apply-templates select="metadata/controllers/controller[@id=$CONTROLLER_ID]"/>
</xsl:template>

<xsl:template match="controller"><![CDATA[<?php]]>
<xsl:call-template name="add_requirements"/>
require_once(FRAME_WORK_PATH.'basic_classes/ControllerSQLDOC20.php');
require_once(FRAME_WORK_PATH.'basic_classes/ParamsSQL.php');

class <xsl:value-of select="@id"/>_Controller extends ControllerSQLDOC20{
	public function __construct($dbLinkMaster=NULL){
		parent::__construct($dbLinkMaster);<xsl:apply-templates/>
	}	
	<xsl:call-template name="extra_methods"/>
}
<![CDATA[?>]]>
</xsl:template>

<xsl:template name="extra_methods">
	public function set_state($pm){
		$p = new ParamsSQL($pm,$this->getDbLink());
		$p->addAll();
		
		$this->getDbLinkMaster()->query(sprintf(
		"UPDATE doc_client_orders
		SET client_order_state=%s
		WHERE id=%d",
		$p->getDbVal('state'),
		$p->getDbVal('doc_id')
		));
	}

	public function set_payed($pm){
		$p = new ParamsSQL($pm,$this->getDbLink());
		$p->addAll();
		
		$this->getDbLinkMaster()->query(sprintf(
		"UPDATE doc_client_orders
		SET payed=TRUE
		WHERE id=%d",
		$p->getDbVal('doc_id')
		));
	}
	
	public function get_print($pm){
		$p = new ParamsSQL($pm,$this->getDbLink());
		$p->set('doc_id',DT_INT,array('required'=>TRUE));
		
		$this->addNewModel(sprintf(
			"SELECT *,
				get_date_str_rus(date_time::date) AS date_time_descr
			FROM doc_client_orders_list
			WHERE id=%d",
		$p->getParamById('doc_id')),
		'head');		
		
		$this->addNewModel(sprintf(
			"SELECT * FROM doc_client_orders_t_materials_list
			WHERE doc_id=%d",
		$p->getParamById('doc_id')),
		'materials');		
		
		$this->addNewModel(sprintf(
			"SELECT * FROM doc_client_orders_t_products_list
			WHERE doc_id=%d",
		$p->getParamById('doc_id')),
		'products');		
		
	}
</xsl:template>

</xsl:stylesheet>
