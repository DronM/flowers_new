<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html"/>

<xsl:template name="format_delivery_note_type">
	<xsl:param name="val"/>
	<xsl:param name="loc"/>
	<xsl:choose>
		<xsl:when test="$val='by_call' and $loc='ru'">
			<xsl:text>звонок</xsl:text>
		</xsl:when>
		<xsl:when test="$val='by_sms' and $loc='ru'">
			<xsl:text>SMS</xsl:text>
		</xsl:when>		
		<xsl:otherwise>
			<xsl:text>---</xsl:text>
		</xsl:otherwise>		
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
