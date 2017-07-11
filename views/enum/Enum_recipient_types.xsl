<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html"/>

<xsl:template name="format_recipient_type">
	<xsl:param name="val"/>
	<xsl:param name="loc"/>
	<xsl:choose>
		<xsl:when test="$val='self' and $loc='ru'">
			<xsl:text>я получатель</xsl:text>
		</xsl:when>
		<xsl:when test="$val='other' and $loc='ru'">
			<xsl:text>другой человек</xsl:text>
		</xsl:when>		
		<xsl:otherwise>
			<xsl:text>---</xsl:text>
		</xsl:otherwise>		
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
