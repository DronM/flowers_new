<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html"/>

<xsl:template name="format_num">
	<xsl:param name="val"/>
	<xsl:choose>
		<xsl:when test="$val='0' or string(number($val))='NaN'">
			<xsl:text>&#160;</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$val"/>
		</xsl:otherwise>		
	</xsl:choose>
</xsl:template>

<xsl:template name="format_money">
	<xsl:param name="val"/>
	<xsl:choose>
		<xsl:when test="$val='0' or string(number($val))='NaN'">
			<xsl:text>&#160;</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<!--<xsl:value-of select="format-number($val,'##0.00')"/>-->
			<xsl:call-template name="string-replace-all">
				<xsl:with-param name="text" select="format-number($val,'##0.00')"/>
				<xsl:with-param name="replace" select="'.'"/>
				<xsl:with-param name="by" select="','"/>
			</xsl:call-template>																					
			
		</xsl:otherwise>		
	</xsl:choose>
</xsl:template>

<xsl:template name="string-replace-all">
  <xsl:param name="text" />
  <xsl:param name="replace" />
  <xsl:param name="by" />
  <xsl:choose>
    <xsl:when test="contains($text, $replace)">
      <xsl:value-of select="substring-before($text,$replace)" />
      <xsl:value-of select="$by" />
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text"
        select="substring-after($text,$replace)" />
        <xsl:with-param name="replace" select="$replace" />
        <xsl:with-param name="by" select="$by" />
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$text" />
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="format_quant">
	<xsl:param name="val"/>
	<xsl:choose>
		<xsl:when test="$val='0' or string(number($val))='NaN'">
			<xsl:text>&#160;</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="string-replace-all">
				<xsl:with-param name="text" select="format-number( round(1000*$val) div 1000 ,'##0.000')"/>
				<xsl:with-param name="replace" select="'.'"/>
				<xsl:with-param name="by" select="','"/>
			</xsl:call-template>																					
		
			<!--<xsl:value-of select="format-number( round(1000*$val) div 1000 ,'##0.000')"/>-->
		</xsl:otherwise>		
	</xsl:choose>
</xsl:template>

<xsl:template name="format_tel">
	<xsl:param name="val"/>
	<xsl:value-of select="concat('+7-(',substring($val,1,3),')-',substring($val,4,3), '-', substring($val,7,2), '-', substring($val,9,2) )"/>
</xsl:template>

<xsl:template name="format_date8">
	<xsl:param name="val"/>
	<xsl:value-of select="concat(substring($val,9,2), '/', substring($val,6,2), '/', substring($val,1,2) )"/>
</xsl:template>

<xsl:template name="format_date10">
	<xsl:param name="val"/>
	<xsl:value-of select="concat(substring($val,9,2), '/', substring($val,6,2), '/', substring($val,1,4) )"/>
</xsl:template>

</xsl:stylesheet>
