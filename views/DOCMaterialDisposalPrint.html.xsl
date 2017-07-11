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
			<xsl:apply-templates select="document/model[@id='head']"/>	
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- Error -->
<xsl:template match="model[@id='ModelServResponse']">
	<div class="error">
		<xsl:value-of select="row[1]/descr"/>
	</div>
</xsl:template>

<xsl:template match="model[@id='head']">
<h3>Списание материалов №<xsl:value-of select="row/number"/> от <xsl:value-of select="row/date_time_descr"/></h3>
<div>
	<p>
		<span>Салон:</span>
		<span><xsl:value-of select="row/store_descr"/></span>
	</p>
	<p>
		<span>Автор:</span>
		<span><xsl:value-of select="row/user_descr"/></span>
	</p>		
	<tr>
		<td>Причина:</td>
		<td><xsl:value-of select="row/explanation"/></td>
	</tr>		
</div>
<xsl:apply-templates select="/document/model[@id='materials']"/>
</xsl:template>

<xsl:template match="model[@id='materials']">
<br></br>
<table style="width:100%;">
	<thead>
		<tr>
			<th style="width:5%">№</th>
			<th style="width:50%">Материал</th>
			<th style="width:15%">Кол-во</th>
			<th style="width:15%">Цена</th>
			<th style="width:15%">Сумма</th>
		</tr>
	</thead>
	<tbody>
	<xsl:apply-templates select="row"/>	
	</tbody>
	<tfoot>
	<tr>
		<td colspan="4">Итого</td>
		<td align="right">
		<xsl:call-template name="format_money">
			<xsl:with-param name="val" select="sum(row/total)"/>
		</xsl:call-template>							
		</td>
	</tr>	
	</tfoot>
</table>
</xsl:template>

<xsl:template match="model[@id='materials']/row">
	<tr>
		<td align="center"><xsl:value-of select="line_number"/></td>
		<td><xsl:value-of select="material_descr"/></td>
		<td align="right"><xsl:value-of select="quant"/></td>
		<td align="right">
			<xsl:call-template name="format_money">
				<xsl:with-param name="val" select="price"/>
			</xsl:call-template>												
		</td>
		<td align="right">
			<xsl:call-template name="format_money">
				<xsl:with-param name="val" select="total"/>
			</xsl:call-template>												
		</td>
	</tr>
</xsl:template>

</xsl:stylesheet>
