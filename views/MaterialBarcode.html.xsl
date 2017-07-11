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
			<div id="printLabel" style="font-size:70%;
				border:0.5px dotted black;
				width:50mm;
				height:auto;
				padding:3px 3px;">
			<xsl:apply-templates select="document/model[@id='head']"/>	
			</div>
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
<div style="display:table;width:100%;">
	<div style="display:table-row;">
		<div style="display:table-cell;text-align:center;">
		<img src="data:{row/barcode_img_mime};base64,{row/barcode_img}"/>
		</div>
	</div>
	<div style="display:table-row;">
		<div style="display:table-cell;text-align:center;
			font-size:80%;
			padding:0px;
			margin:5px 0px;">
			<xsl:value-of select="row/barcode_descr"/>
		</div>
	</div>
	<div style="display:table-row;">
		<div style="display:table-cell;font-size:110%;font-weight:bold;text-align:center;">
			<xsl:value-of select="row/product_descr"/>
		</div>
	</div>		
</div>
</xsl:template>


</xsl:stylesheet>
