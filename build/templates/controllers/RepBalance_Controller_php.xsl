<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="Controller_php.xsl"/>

<!-- -->
<xsl:variable name="CONTROLLER_ID" select="'RepBalance'"/>
<!-- -->

<xsl:output method="text" indent="yes"
			doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" 
			doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
			
<xsl:template match="/">
	<xsl:apply-templates select="metadata/controllers/controller[@id=$CONTROLLER_ID]"/>
</xsl:template>

<xsl:template match="controller"><![CDATA[<?php]]>
<xsl:call-template name="add_requirements"/>
require_once(FRAME_WORK_PATH.'basic_classes/CondParamsSQL.php');

class <xsl:value-of select="@id"/>_Controller extends ControllerSQL{
	public function __construct($dbLinkMaster=NULL){
		parent::__construct($dbLinkMaster);<xsl:apply-templates/>
	}	
	<xsl:call-template name="extra_methods"/>
}
<![CDATA[?>]]>
</xsl:template>

<xsl:template name="extra_methods">
	public function balance($pm){
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
	
		$this->addNewModel(sprintf(
		"SELECT * FROM rep_balance(%s,%s,%d)",
		$date_time_from,
		$date_time_to,
		$store_id
		),'balance');
	}
	public function get($pm){
	}
</xsl:template>

</xsl:stylesheet>
