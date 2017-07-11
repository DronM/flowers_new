<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" 
 xmlns:html="http://www.w3.org/TR/REC-html40"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:fo="http://www.w3.org/1999/XSL/Format">

<xsl:import href="functions.xsl"/>

<xsl:key name="periods" match="row" use="period/."/>
<xsl:key name="expence_types" match="row" use="expence_type_id/."/>
<xsl:key name="periods_expence_types" match="row" use="concat(period/.,'|',expence_type_id/.)"/>

<!-- Main template-->
<xsl:template match="/">
	<xsl:choose>
		<xsl:when test="not(document/model[@id='ModelServResponse']/row[1]/result='0')">
		<xsl:apply-templates select="document/model[@id='ModelServResponse']"/>	
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="document/model[@id='balance']"/>	
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
				<th align="center">Месяц</th>
				<th align="center">Выручка</th>
				<th align="center">Себест. материалов</th>
				<th align="center">Списание материалов</th>
				<th align="center">Прибыль</th>
				<xsl:for-each select="//row[generate-id() =
				generate-id(key('expence_types',expence_type_id/.)[1])]">
					<xsl:sort select="expence_type_descr/."/>
					<xsl:if test="expence_type_id/. &gt; 0">
					<th align="center">
						<xsl:value-of select="expence_type_descr/."/>
					</th>
					</xsl:if>
				</xsl:for-each>			
				<th align="center">Расходы всего</th>
				<th align="center">Прибыль</th>
			</tr>
		</thead>
	
		<tbody>
		<xsl:for-each select="//row[generate-id() =
		generate-id(key('periods',period/.)[1])]">
			<xsl:sort select="period/."/>
			
			<xsl:variable name="period" select="period/."/>
			<xsl:variable name="total_expences" select="sum(key('periods',$period)/total_expences/.)"/>
			<xsl:variable name="common_val_row" select="key('periods_expence_types',concat(period/.,'|'))"/>
			<xsl:variable name="income" select="$common_val_row/total_sales/. - $common_val_row/total_mat_cost/. - $common_val_row/total_mat_disp/."/>
			
			<xsl:variable name="row_class">
				<xsl:choose>
					<xsl:when test="position() mod 2">odd</xsl:when>
					<xsl:otherwise>even</xsl:otherwise>													
				</xsl:choose>
			</xsl:variable>
						
			<tr class="{$row_class}">
				<!-- месяц -->
				<td align="center"><xsl:value-of select="mon/."/></td>
				
				<!-- выручка -->
				<td align="right">
					<xsl:call-template name="format_money">
						<xsl:with-param name="val" select="$common_val_row/total_sales/."/>
					</xsl:call-template>									
				</td>
				
				<!-- Себест. материалов -->
				<td align="right">
					<xsl:call-template name="format_money">
						<xsl:with-param name="val" select="$common_val_row/total_mat_cost/."/>
					</xsl:call-template>									
				</td>

				<!-- Списание материалов -->
				<td align="right">
					<xsl:call-template name="format_money">
						<xsl:with-param name="val" select="$common_val_row/total_mat_disp/."/>
					</xsl:call-template>									
				</td>

				<!-- Прибыль -->
				<td align="right">
					<xsl:call-template name="format_money">
						<xsl:with-param name="val" select="$income"/>
					</xsl:call-template>									
				</td>
				
				<!-- Расходы -->
				<xsl:for-each select="//row[generate-id() =
				generate-id(key('expence_types',expence_type_id/.)[1])]">
					<xsl:sort select="expence_type_descr/."/>
					<xsl:if test="expence_type_id/. &gt; 0">
						<xsl:variable name="exp_row" select="key('periods_expence_types',concat($period,'|',expence_type_id/.))"/>

						<td align="right">
							<xsl:choose>
							<xsl:when test="$exp_row/total_expences/.">
							<xsl:call-template name="format_money">
								<xsl:with-param name="val" select="$exp_row/total_expences/."/>
							</xsl:call-template>									
							</xsl:when>
							<xsl:otherwise></xsl:otherwise>
							</xsl:choose>
						</td>						
					</xsl:if>
				</xsl:for-each>			
				
				<!-- Расходы всего-->
				<td align="right">
					<xsl:call-template name="format_money">
						<xsl:with-param name="val" select="$total_expences"/>
					</xsl:call-template>									
				</td>										
				
				<!-- Прибыль-->
				<td align="right">
					<xsl:call-template name="format_money">
						<xsl:with-param name="val" select="$income - $total_expences"/>
					</xsl:call-template>									
				</td>										
				
			</tr>
			
			
		</xsl:for-each>
		</tbody>
		
		<!-- ИТОГИ -->
		<tfoot>
			<xsl:variable name="tot_sales" select="sum(//total_sales/.)"/>
			<xsl:variable name="tot_mat_cost" select="sum(//total_mat_cost/.)"/>
			<xsl:variable name="tot_mat_disp" select="sum(//total_mat_disp/.)"/>
			<xsl:variable name="tot_income" select="$tot_sales - $tot_mat_cost - $tot_mat_disp"/>
			<xsl:variable name="tot_expences" select="sum(//total_expences/.)"/>
			
			<tr class="grid_foot">
				<td>Итого</td>
				
				<!-- ВЫРУЧКА -->
				<td align="right">
					<xsl:call-template name="format_money">
						<xsl:with-param name="val" select="$tot_sales"/>
					</xsl:call-template>									
				</td>										
				
				<!-- Себест. материалов -->
				<td align="right">
					<xsl:call-template name="format_money">
						<xsl:with-param name="val" select="$tot_mat_cost"/>
					</xsl:call-template>									
				</td>										

				<!-- Списание материалов -->
				<td align="right">
					<xsl:call-template name="format_money">
						<xsl:with-param name="val" select="$tot_mat_disp"/>
					</xsl:call-template>									
				</td>										

				<!-- Списание материалов -->
				<td align="right">
					<xsl:call-template name="format_money">
						<xsl:with-param name="val" select="$tot_income"/>
					</xsl:call-template>									
				</td>										
				
				<!-- РАСХОДЫ -->
				<xsl:for-each select="//row[generate-id() =
				generate-id(key('expence_types',expence_type_id/.)[1])]">
					<xsl:sort select="expence_type_descr/."/>
					<xsl:if test="expence_type_id/. &gt; 0">
						<td align="right">
							<xsl:call-template name="format_money">
								<xsl:with-param name="val" select="sum(key('expence_types',expence_type_id/.)/total_expences/.)"/>
							</xsl:call-template>									
						</td>						
					</xsl:if>
				</xsl:for-each>			
				
				<!-- Расходы всего-->
				<td align="right">
					<xsl:call-template name="format_money">
						<xsl:with-param name="val" select="$tot_expences"/>
					</xsl:call-template>									
				</td>										
				
				<!-- Прибыль-->
				<td align="right">
					<xsl:call-template name="format_money">
						<xsl:with-param name="val" select="$tot_income - $tot_expences"/>
					</xsl:call-template>									
				</td>										
			</tr>
		</tfoot>
	</table>
	</div>
</xsl:template>

<!-- table header -->

</xsl:stylesheet>
