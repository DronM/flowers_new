<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html"/>

<xsl:template name="format_payment_type">
	<xsl:param name="val"/>
	<xsl:param name="loc"/>
	<xsl:choose>
		<xsl:when test="$val='cash' and $loc='ru'">
			<xsl:text>Наличными</xsl:text>
		</xsl:when>
		<xsl:when test="$val='bank' and $loc='ru'">
			<xsl:text>Банковской картой</xsl:text>
		</xsl:when>		
		<xsl:when test="$val='yandex' and $loc='ru'">
			<xsl:text>Яндекс деньги</xsl:text>
		</xsl:when>		
		<xsl:when test="$val='trans_to_card' and $loc='ru'">
			<xsl:text>Перевод на карту</xsl:text>
		</xsl:when>		
		<xsl:when test="$val='web_money' and $loc='ru'">
			<xsl:text>Web money</xsl:text>
		</xsl:when>		
		
		<xsl:otherwise>
			<xsl:text>---</xsl:text>
		</xsl:otherwise>		
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
