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
			<xsl:apply-templates select="document/model[@id='report']"/>	
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
	<br></br>
	<div class="scrollable-area">
	<table id="{@model_id}" class="table table-bordered table-responsive table-striped">
		<thead>
			<tr>
				<th align="center" rowspan="2">Салон</th>
				<th align="center" rowspan="2">Материал</th>
				<th align="center" colspan="2">Продажи</th>
				<th align="center" colspan="2">Списание</th>
			</tr>
			<tr>
				<th align="center">Кол-во</th>
				<th align="center">Сумма</th>
				<th align="center">Кол-во</th>
				<th align="center">Сумма</th>
			</tr>
			
		</thead>
	
		<tbody>
			<xsl:apply-templates/>
		</tbody>
		
		<!-- ИТОГИ -->
		<tfoot>
			<tr class="grid_foot">
				<td colspan="2">Итого</td>
				<td colspan="2" align="right">
					<xsl:call-template name="format_money">
						<xsl:with-param name="val" select="sum(//cost_sale/.)"/>
					</xsl:call-template>									
				</td>
				<td colspan="2" align="right">
					<xsl:call-template name="format_money">
						<xsl:with-param name="val" select="sum(//cost_disp/.)"/>
					</xsl:call-template>									
				</td>
				
			</tr>
		</tfoot>
	</table>
	</div>
</xsl:template>

<!-- table header -->

<!-- tr -->
<xsl:template match="row">
	<tr>
	<xsl:apply-templates/>
	</tr>
</xsl:template>

<!-- td -->
<xsl:template match="row/store_descr">
	<td><xsl:value-of select="node()"/></td>
</xsl:template>
<xsl:template match="row/store_id">
</xsl:template>

<xsl:template match="row/material_id">
</xsl:template>

<xsl:template match="row/material_descr">
	<td><xsl:value-of select="node()"/></td>
</xsl:template>

<xsl:template match="row/quant_sale">
	<td align="right">
		<xsl:call-template name="format_num">
			<xsl:with-param name="val" select="node()"/>
		</xsl:call-template>									
	</td>
</xsl:template>

<xsl:template match="row/cost_sale">
	<td align="right">
		<xsl:call-template name="format_money">
			<xsl:with-param name="val" select="node()"/>
		</xsl:call-template>									
	</td>
</xsl:template>

<xsl:template match="row/quant_disp">
	<td align="right">
		<xsl:call-template name="format_num">
			<xsl:with-param name="val" select="node()"/>
		</xsl:call-template>									
	</td>
</xsl:template>

<xsl:template match="row/cost_disp">
	<td align="right">
		<xsl:call-template name="format_money">
			<xsl:with-param name="val" select="node()"/>
		</xsl:call-template>									
	</td>
</xsl:template>

</xsl:stylesheet>
