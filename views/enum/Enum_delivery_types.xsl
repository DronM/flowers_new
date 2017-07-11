<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html"/>

<xsl:template name="format_delivery_type">
	<xsl:param name="val"/>
	<xsl:param name="lang"/>
	<xsl:choose>
		<xsl:when test="$val='courier' and $lang='rus'">
			<xsl:text>курьер</xsl:text>
		</xsl:when>
		<xsl:when test="$val='by_client' and $lang='rus'">
			<xsl:text>самовывоз</xsl:text>
		</xsl:when>		
		<xsl:otherwise>
			<xsl:text>---</xsl:text>
		</xsl:otherwise>		
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
