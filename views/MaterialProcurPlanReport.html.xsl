<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" 
 xmlns:html="http://www.w3.org/TR/REC-html40"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:fo="http://www.w3.org/1999/XSL/Format">

<xsl:output method="html"/> 


<!-- Main template-->
<xsl:template match="/">
	<xsl:choose>
		<xsl:when test="not(document/model[@id='ModelServResponse']/row[1]/result='0')">
		<xsl:apply-templates select="document/model[@id='ModelServResponse']"/>	
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="document/model[@id='material_procur_plan_report']"/>	
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- Error -->
<xsl:template match="model[@id='ModelServResponse']">
	<div class="error">
		<xsl:value-of select="row[1]/descr"/>
	</div>
</xsl:template>

<!-- table -->
<xsl:template match="model">
	<xsl:variable name="model_id" select="@id"/>	
	<table id="{@model_id}">
		<thead>
			<tr>
				<th align="center" rowspan="2">Материалы&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</th>
				<th align="center" colspan="4">Начало</th>
				<xsl:for-each select="/document/model[@id='header']/row">
				<th align="center" colspan="5"><xsl:value-of select="concat(date_descr,', ',dow,' (',ratio,')')"/></th>
				</xsl:for-each>
				
			</tr>
			<tr>
				<th align="center">Норма</th>
				<th align="center">Склад</th>
				<th align="center">Витрина</th>
				<th align="center">Сальдо</th>
				<xsl:for-each select="/document/model[@id='header']/row">
				<th align="center">Приход</th>
				<th align="center">Заказано</th>
				<th align="center">Расход</th>
				<th align="center">Сальдо</th>
				<th align="center">Надо</th>
				</xsl:for-each>				
			</tr>
		</thead>
	
		<tbody>
			<xsl:apply-templates/>
		</tbody>
	</table>
</xsl:template>

<!-- table header -->

<!-- table row -->
<xsl:template match="row">
	<tr>
		<td align="left">
		<xsl:value-of select="material_descr/node()"/>
		</td>
		<td align="right">
		<xsl:value-of select="quant_norm/node()"/>
		</td>
		<td align="right">
		<xsl:value-of select="quant_balance_begin/node()"/>
		</td>
		<td align="right">
		<xsl:value-of select="quant_on_products/node()"/>
		</td>
		<td align="right">
		<xsl:value-of select="quant_balance_end/node()"/>
		</td>
		<xsl:variable name="procur" select="quant_procur/element"/>
		<xsl:variable name="order" select="quant_order/element"/>
		<xsl:variable name="flow" select="quant_flow/element"/>
		<xsl:variable name="balance" select="quant_balance/element"/>
		<xsl:variable name="need" select="quant_need/element"/>
		
		<xsl:for-each select="quant_procur/element">
		<xsl:variable name="pos" select="position()"/>
		<td align="right">
		<xsl:value-of select="node()"/>
		</td>		
		<td align="right">
		<xsl:value-of select="$order[$pos]/node()"/>
		</td>		
		<td align="right">
		<xsl:value-of select="$flow[$pos]/node()"/>
		</td>		
		<td align="right">
		<xsl:value-of select="$balance[$pos]/node()"/>
		</td>				
		<td align="right" class="MaterialProcurPlanReport_need">
		<xsl:value-of select="$need[$pos]/node()"/>
		</td>						
		</xsl:for-each>
	</tr>
</xsl:template>

</xsl:stylesheet>