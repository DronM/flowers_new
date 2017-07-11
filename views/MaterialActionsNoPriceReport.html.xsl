<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" 
 xmlns:html="http://www.w3.org/TR/REC-html40"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:fo="http://www.w3.org/1999/XSL/Format">

<xsl:import href="functions.xsl"/>

<!-- Main template-->
<xsl:template match="/">
	<xsl:choose>
		<xsl:when test="not(document/model[@id='ModelServResponse']/row[1]/result='0')">
		<xsl:apply-templates select="document/model[@id='ModelServResponse']"/>	
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="document/model[@id='Material_Model']"/>	
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
<br></br>
<div class="scrollable-area">
<table id="{@model_id}" class="table table-bordered table-responsive table-striped">
	<thead align="center">
		<tr>
			<th rowspan="3">Материал&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</th>
			<th colspan="2">Остаток на начало</th>
			<th colspan="2">Приход на склад</th>
			<th colspan="4">Расход со склада</th>
			<th colspan="2">Остаток на конец</th>
		</tr>
		<tr>
			<!-- остаток-->
			<th>Материалы</th>
			<th>Букеты</th>
			<!-- Приход-->
			<th>От поставщиков</th>
			<th>Разукомплектация</th>
			<!-- Расход-->
			<th>Комплектация</th>
			<th>Списание материалов</th>
			<th>Продажа материалов</th>
			<th>Продажа букетов</th>
			<!-- остаток-->
			<th>Материалы</th>
			<th>Букеты</th>			
		</tr>		
	</thead>
	<tbody>
		<xsl:apply-templates select="row"/>
	</tbody>	
	
</table>
</div>
</xsl:template>

<xsl:template match="row">
	<xsl:variable name="class_name">
		<xsl:choose>
			<xsl:when test="position() mod 2 = 0">even</xsl:when>
			<xsl:otherwise>odd</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<tr class="{$class_name}">
		<td class="col_mat"><xsl:value-of select="material_descr"/></td>
		
		<!-- остаток материалы-->
		<td class="balance_beg mat" align="right">
		<xsl:call-template name="format_quant">
			<xsl:with-param name="val" select="beg_mat_quant"/>
		</xsl:call-template>																					
		</td>
		
		<!-- остаток Букеты-->
		<td class="balance_beg prod" align="right">
		<xsl:call-template name="format_quant">
			<xsl:with-param name="val" select="beg_prod_quant"/>
		</xsl:call-template>																					
		</td>
		
		<!-- Приход от поставщиков -->
		<td class="procur supp" align="right">
		<xsl:call-template name="format_quant">
			<xsl:with-param name="val" select="procur_quant"/>
		</xsl:call-template>																					
		</td>

		<!-- Разукомплектация -->
		<td class="procur prod_disp" align="right">
		<xsl:call-template name="format_quant">
			<xsl:with-param name="val" select="prod_disp_quant"/>
		</xsl:call-template>																					
		</td>

		<!-- Комплектация -->
		<td class="flow production" align="right">
		<xsl:call-template name="format_quant">
			<xsl:with-param name="val" select="production_quant"/>
		</xsl:call-template>																					
		</td>

		<!-- Списание материалов -->
		<td class="flow mat_disp" align="right">
		<xsl:call-template name="format_quant">
			<xsl:with-param name="val" select="mat_disp_quant"/>
		</xsl:call-template>																					
		</td>

		<!-- Продажа материалов -->
		<td class="flow mat_sale" align="right">
		<xsl:call-template name="format_quant">
			<xsl:with-param name="val" select="mat_sale_quant"/>
		</xsl:call-template>																					
		</td>

		<!-- Продажа букетов -->
		<td class="flow prod_sale" align="right">
		<xsl:call-template name="format_quant">
			<xsl:with-param name="val" select="prod_sale_quant"/>
		</xsl:call-template>																					
		</td>
		
		<!-- остаток материалы-->
		<td class="balance_end mat" align="right">
		<xsl:call-template name="format_quant">
			<xsl:with-param name="val" select="end_mat_quant"/>
		</xsl:call-template>																					
		</td>
		
		<!-- остаток Букеты-->
		<td class="balance_end prod" align="right">
		<xsl:call-template name="format_quant">
			<xsl:with-param name="val" select="end_prod_quant"/>
		</xsl:call-template>																					
		</td>

	</tr>
</xsl:template>

</xsl:stylesheet>
