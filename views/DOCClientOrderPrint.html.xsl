<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" 
 xmlns:html="http://www.w3.org/TR/REC-html40"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:fo="http://www.w3.org/1999/XSL/Format">

<xsl:import href="functions.xsl"/>
<xsl:import href="enum/Enum_delivery_types.xsl"/>
<xsl:import href="enum/Enum_recipient_types.xsl"/>
<xsl:import href="enum/Enum_delivery_note_types.xsl"/>
<xsl:import href="enum/Enum_payment_types.xsl"/>

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
<h3>Заказ №<xsl:value-of select="row/number"/> от <xsl:value-of select="row/date_time_descr"/></h3>
<div>
	<p>
		<span>Салон:</span>
		<span><xsl:value-of select="row/store_descr"/></span>
	</p>
	
	<p>
		<span>Номер с сайта:</span>
		<span><xsl:value-of select="row/number"/></span>
	</p>
	<p>
		<span>Вид доставки:</span>
		<span>
			<xsl:call-template name="format_delivery_type">
				<xsl:with-param name="lang" select="'rus'"/>
				<xsl:with-param name="val" select="row/delivery_type"/>
			</xsl:call-template>												
		</span>
	</p>
	<p>
		<span>Покупатель:</span>
		<span><xsl:value-of select="row/client_name"/></span>
	</p>
	<p>
		<span>Телефон:</span>
		<span>
			<xsl:call-template name="format_tel">
				<xsl:with-param name="val" select="row/client_tel"/>
			</xsl:call-template>												
		</span>
	</p>
	
	<p>
		<span>Вид получателя:</span>
		<span>
			<xsl:call-template name="format_recipient_type">
				<xsl:with-param name="lang" select="'rus'"/>
				<xsl:with-param name="val" select="row/recipient_type"/>
			</xsl:call-template>												
		</span>
	</p>
	
	<xsl:if test="row/recipient_type/node()!='self'">
		<p>
			<span>Имя получателя:</span>
			<span><xsl:value-of select="row/recipient_name"/></span>
		</p>
		<p>
			<span>Телефон получателя:</span>
			<span>
				<xsl:call-template name="format_tel">
					<xsl:with-param name="val" select="row/recipient_tel"/>
				</xsl:call-template>																
			</span>
		</p>
	
	</xsl:if>
	
	<p>
		<span>Адрес:</span>
		<span><xsl:value-of select="row/address"/></span>
	</p>
	
	<p>	
		<span>Доставка на:</span>
		<span>
			<xsl:call-template name="format_date8">
				<xsl:with-param name="val" select="row/delivery_date"/>
			</xsl:call-template>																
		</span>
	</p>
	
	<p>
		<span>Время:</span>
		<span><xsl:value-of select="row/delivery_hour_descr"/></span>
	</p>
	
	<p>
		<span>Комментарий дост.:</span>
		<span><xsl:value-of select="row/delivery_comment"/></span>
	</p>
	
	<xsl:if test="row/card/node()='true'">
		<p>
			<span>Открытка с текстом:</span>
			<span><xsl:value-of select="row/card_text"/></span>
		</p>
	</xsl:if>
	
	<xsl:if test="row/anonym_gift/node()='true'">
		<p>
			<span><strong>Доставить ананомно.</strong></span>
		</p>
	</xsl:if>

	<p>
		<span>Уведомление о доставке:</span>
		<span>
			<xsl:call-template name="format_delivery_note_type">
				<xsl:with-param name="lang" select="'rus'"/>
				<xsl:with-param name="val" select="row/delivery_note_type"/>
			</xsl:call-template>												
			
		</span>
	</p>
	
	<p>
		<span>Комментарий:</span>
		<span><xsl:value-of select="row/extra_comment"/></span>
	</p>
	
	<xsl:if test="row/payed/node()='true'">
		<p>
			<span>Оплата:</span>
			<span>
			<xsl:call-template name="format_payment_type">
				<xsl:with-param name="lang" select="'rus'"/>
				<xsl:with-param name="val" select="row/payment_type"/>
			</xsl:call-template>												
			</span>
			
		</p>
	</xsl:if>
</div>

<xsl:if test="count(/document/model[@id='materials']/row) or count(/document/model[@id='products']/row)">
<br></br>
<table style="width:100%;">
	<thead>
		<tr>
			<th style="width:5%">№</th>
			<th style="width:35%">Номенклатура</th>
			<th style="width:15%">Кол-во</th>
			<th style="width:15%">Цена</th>
			<th style="width:15%">Скидка,(%)</th>
			<th style="width:15%">Сумма</th>
		</tr>
	</thead>
	<tbody>
	<xsl:apply-templates select="/document/model[@id='materials']"/>
	<xsl:apply-templates select="/document/model[@id='products']"/>		
	</tbody>
	<tfoot>
	<tr>
		<td colspan="5">Итого</td>
		<td align="right">
		<xsl:call-template name="format_money">
			<xsl:with-param name="val" select="sum(/document/model[@id='materials']/row/total)+sum(/document/model[@id='products']/row/total)"/>
		</xsl:call-template>							
		</td>
	</tr>		
	</tfoot>
</table>
</xsl:if>
</xsl:template>


<xsl:template match="model[@id='materials']/row">
	<tr>
		<td align="center"><xsl:value-of select="line_number"/></td>
		<td><xsl:value-of select="material_descr"/></td>
		<td align="right">
			<xsl:call-template name="format_quant">
				<xsl:with-param name="val" select="quant"/>
			</xsl:call-template>												
		</td>
		<td align="right">
			<xsl:call-template name="format_money">
				<xsl:with-param name="val" select="price"/>
			</xsl:call-template>												
		</td>
		<td align="right">
			<xsl:value-of select="disc_percent"/>
		</td>
		
		<td align="right">
			<xsl:call-template name="format_money">
				<xsl:with-param name="val" select="total"/>
			</xsl:call-template>												
		</td>
	</tr>
</xsl:template>

<xsl:template match="model[@id='products']/row">
	<tr>
		<td align="center"><xsl:value-of select="number(line_number) + count(/document/model[@id='products']/row)"/></td>
		<td><xsl:value-of select="product_descr"/></td>
		<td align="right">
			<xsl:call-template name="format_quant">
				<xsl:with-param name="val" select="quant"/>
			</xsl:call-template>												
		</td>
		<td align="right">
			<xsl:call-template name="format_money">
				<xsl:with-param name="val" select="price"/>
			</xsl:call-template>												
		</td>
		<td align="right">
			<xsl:value-of select="disc_percent"/>
		</td>		
		<td align="right">
			<xsl:call-template name="format_money">
				<xsl:with-param name="val" select="total"/>
			</xsl:call-template>												
		</td>
	</tr>
</xsl:template>

</xsl:stylesheet>
