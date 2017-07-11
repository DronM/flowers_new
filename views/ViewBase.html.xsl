<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes"
			doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" 
			doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>

<xsl:variable name="BASE_PATH" select="/document/model[@id='ModelVars']/row[1]/basePath"/>
<xsl:variable name="VERSION" select="/document/model[@id='ModelVars']/row[1]/scriptId"/>
<xsl:variable name="TITLE" select="/document/model[@id='ModelVars']/row[1]/title"/>
	
	
<!--************* Main template ******************** -->		
<xsl:template match="/document">
<html>
	<head>
		<xsl:call-template name="initHead"/>
		
		<title>Bellagio</title>
		
		<script>
			function pageLoad(){				
				<xsl:call-template name="initApp"/>
				<xsl:call-template name="modelFromTemplate"/>
				
				<xsl:if test="/document/model[@id='ModelServResponse']/row/result='1'">
					throw Error(CommonHelper.longString(function () {/*
					<xsl:value-of select="/document/model[@id='ModelServResponse']/row/descr"/>
					*/}));
				</xsl:if>	
			}
		</script>
	</head>
	<body onload="pageLoad();">
		<!--  -->
		<!--<button onclick="alert(DateHelper.strtotime('2016-12-06T06:30:00'));">1111111111</button>-->
		<div id="wrapper">
			<xsl:call-template name="initMenu"/>
			
			<!-- Page Content -->
			<div id="page-wrapper">
			    <div class="container-fluid">
				<div class="row">
				    <div id="windowData" class="col-lg-12">
				    	<xsl:apply-templates select="model[@templateId]"/>
				    </div>
				    <!-- /.col-lg-12 -->
				    <div class="windowMessage hidden">
				    </div>
				</div>
				<!-- /.row -->
			    </div>
			    <!-- /.container-fluid -->
			</div>
			<!-- /#page-wrapper -->
		</div>
		<!-- /#wrapper -->
	    
		<xsl:call-template name="initJS"/>
	</body>
</html>		
</xsl:template>


<!--************* Javascript files ******************** -->
<xsl:template name="initJS">
	<!-- bootstrap resolution-->
	<div id="users-device-size">
	  <div id="xs" class="visible-xs"></div>
	  <div id="sm" class="visible-sm"></div>
	  <div id="md" class="visible-md"></div>
	  <div id="lg" class="visible-lg"></div>
	</div>

	<!--waiting  -->
	<div id="waiting">
		<div>Ждите</div>
		<img src="{$BASE_PATH}img/loading.gif"/>
	</div>
	
	<!--ALL js modules -->
	<xsl:apply-templates select="model[@id='ModelJavaScript']/row"/>
	
	<script>
		var dv = document.getElementById("waiting");
		if (dv!==null){
			dv.parentNode.removeChild(dv);
		}
	</script>
</xsl:template>


<!--************* Application instance ******************** -->
<xsl:template name="initApp">
	var application = new AppFlowers({
		host:'<xsl:value-of select="$BASE_PATH"/>',
		servVars:{
			"version":'<xsl:value-of select="$VERSION"/>',
			"role_id":'<xsl:value-of select="model[@id='ModelVars']/row/role_id"/>',
			"role_descr":'<xsl:value-of select="model[@id='ModelVars']/row/role_descr"/>',
			"user_id":'<xsl:value-of select="model[@id='ModelVars']/row/user_id"/>',
			"user_name":'<xsl:value-of select="model[@id='ModelVars']/row/user_name"/>',
			"multy_store":'<xsl:value-of select="model[@id='ModelVars']/row/multy_store"/>'
		}
		<xsl:if test="model[@id='ConstantValueList_Model']">
		,"constantXMLString":CommonHelper.longString(function () {/*
				<xsl:copy-of select="model[@id='ConstantValueList_Model']"/>
		*/})
		</xsl:if>
				
		<!--	
		<xsl:if test="/document/model[@id='ModelServResponse']/row/result='1'">
			,
			"error":"<xsl:value-of select="/document/model[@id='ModelServResponse']/row/descr"/>"
		</xsl:if>	
		-->
	});
	<xsl:call-template name="initAppWin"/>
	
	<xsl:if test="/document/model[@id='ModelVars']/row/cash_reg_id and model[@id='ModelVars']/row/role_id='cashier'">
	var opts = {
		"id":"<xsl:value-of select="/document/model[@id='ModelVars']/row/cash_reg_id"/>",
		"server":"<xsl:value-of select="/document/model[@id='ModelVars']/row/cash_reg_server"/>",
		"port":"<xsl:value-of select="/document/model[@id='ModelVars']/row/cash_reg_port"/>"
	};
	application.setCachRegister(new EquipServer(opts));
	</xsl:if>
</xsl:template>

<!--************* Window instance ******************** -->
<xsl:template name="initAppWin">	
	var applicationWin = new AppWin({
		"bsCol":("col-"+$('#users-device-size').find('div:visible').first().attr('id')+"-"),
		"app":application
		<!--
		<xsl:if test="/document/model[@id='ModelServResponse']/row/result='1'">
			,"error":"<xsl:value-of select="/document/model[@id='ModelServResponse']/row/descr"/>"
		</xsl:if>	
		-->
	});	
</xsl:template>

<!--************* Page head ******************** -->
<xsl:template name="initHead">
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
	<xsl:apply-templates select="model[@id='ModelVars']"/>
	<xsl:apply-templates select="model[@id='ModelStyleSheet']/row"/>
	<link rel="icon" type="image/png" href="{$BASE_PATH}img/favicon.png"/>
</xsl:template>


<!-- ************** Main Menu ******************** -->
<xsl:template name="initMenu">
	<xsl:if test="model[@id='MainMenu_Model']">
	<!-- Navigation -->
	<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
	    <div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
		    <span class="sr-only">Toggle navigation</span>
		    <span class="icon-bar"></span>
		    <span class="icon-bar"></span>
		    <span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="index.php">Bellagio, CRM</a>
	    </div>
	    <!-- /.navbar-header -->

	    <ul class="nav navbar-top-links navbar-right">
                <!-- /.dropdown 
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-bell fa-fw"></i>  <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-alerts">
                        <li>
                            <a href="#">
                                <div>
                                    <i class="fa fa-comment fa-fw"></i> New Comment
                                    <span class="pull-right text-muted small">4 minutes ago</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <i class="fa fa-comment fa-fw"></i> New Comment2
                                    <span class="pull-right text-muted small">4 minutes ago</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>                        
                        <li>
                            <a class="text-center" href="#">
                                <strong>Все сообщения </strong>
                                <i class="fa fa-angle-right"></i>
                            </a>
                        </li>
                    </ul>
                </li>
	    	-->
	    	
		<li class="dropdown">
		    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
		        <i class="fa fa-user fa-fw"></i>  <i class="fa fa-caret-down"></i>
		    </a>
		    <ul class="dropdown-menu dropdown-user">
		        <li><a href="index.php?c=User_Controller&amp;f=get_profile&amp;t=UserProfile"><i class="fa fa-user fa-fw"></i> Профиль пользователя</a>
		        </li>
		        <li class="divider"></li>
		        <li><a href="index.php?c=User_Controller&amp;f=logout_html"><i class="fa fa-sign-out fa-fw"></i> Выход</a>
		        </li>
		    </ul>
		    <!-- /.dropdown-user -->
		</li>
		<!-- /.dropdown -->
	    </ul>
	    <!-- /.navbar-top-links -->

	    <div class="navbar-default sidebar" role="navigation">
		<div class="sidebar-nav navbar-collapse">
		    <ul class="nav" id="side-menu">
		    	<!--
		        <li class="sidebar-search">
		            <div class="input-group custom-search-form">
		                <input type="text" class="form-control" placeholder="Search..."/>
		                <span class="input-group-btn">
		                <button class="btn btn-default" type="button">
		                    <i class="fa fa-search"></i>
		                </button>
		            </span>
		            </div>
		        </li>
		        -->
		        <xsl:apply-templates select="/document/model[@id='MenuMaterialGroup_Model']"/>
		        <xsl:apply-templates select="/document/model[@id='MainMenu_Model']"/>
		       
		        
			<li>
			    <a href="index.php?c=User_Controller&amp;f=get_profile&amp;t=UserProfile"><i class="fa fa-fw"></i> Профиль пользователя </a>
			</li>			
		        
			<li>
			    <a href="index.php?c=User_Controller&amp;f=logout_html"><i class="fa fa-fw"></i> Выход </a>
			</li>					        
		    </ul>
		</div>
		<!-- /.sidebar-collapse -->
	    </div>
	    <!-- /.navbar-static-side -->
	</nav>
	</xsl:if>
</xsl:template>


<!--************* Menu item ******************-->
<xsl:template match="menuItem">
	<xsl:choose>
		<xsl:when test="menuItem">			
			<!-- multylevel-->
			<li>
				<a href="#"><i class="fa fa-fw"></i> <xsl:value-of select="@descr"/><span class="fa arrow"></span></a>
				<ul class="nav nav-second-level">
					<xsl:apply-templates select="menuItem"/>
				</ul>						
			</li>
		</xsl:when>
		<xsl:otherwise>
			<!-- one level-->
			<li>
			    <a href="index.php?c={@c}&amp;f={@f}&amp;t={@t}"><i class="fa fa-fw"></i> <xsl:value-of select="@descr"/> </a>
			</li>			
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="model[@id='MenuMaterialGroup_Model']">
	<li>
		<a href="#"><i class="fa fa-fw"></i>Номенклатура<span class="fa arrow"></span></a>
		<ul class="nav nav-second-level">
			<li>
			    <a href="index.php?c=Product_Controller&amp;f=get_list_for_sale&amp;t=DOCSaleCashier"><i class="fa fa-fw"></i>Букеты</a>
			</li>			
		
			<xsl:apply-templates select="row"/>
		</ul>						
	</li>
</xsl:template>

<xsl:template match="model[@id='MenuMaterialGroup_Model']/row">
	<!-- one level-->
	<li>
	    <a href="index.php?c=Material_Controller&amp;f=get_list_for_sale&amp;t=DOCSaleCashier&amp;cond_fields=group_id&amp;cond_vals={id}&amp;cond_sgns=e"><i class="fa fa-fw"></i> <xsl:value-of select="name"/> </a>
	</li>			
</xsl:template>

<!--*************** templates ********************* -->
<xsl:template match="model[@templateId]">
<xsl:copy-of select="*"/>
</xsl:template>

<xsl:template name="modelFromTemplate">
	<xsl:for-each select="model[@templateId]">
		<xsl:variable name="templateId" select="@templateId"/>
		<xsl:variable name="templateModelId" select="div[1]/@modelId"/>
	
		var v_<xsl:value-of select="$templateId"/> = new <xsl:value-of select="$templateId"/>_View("<xsl:value-of select="$templateId"/>",{

			"app":application
			<xsl:choose>
			<xsl:when test="count(models/model) &gt; 0">
			<xsl:for-each select="models/model">
			<xsl:variable name="m_id" select="@id"/>
			,"<xsl:value-of select="$m_id"/>":CommonHelper.longString(function () {/*
			<xsl:copy-of select="/document/model[@id=$m_id]"/>
			*/})						
			</xsl:for-each>

			</xsl:when>
			
			<xsl:otherwise>
			,"modelDataStr":CommonHelper.longString(function () {/*
			<xsl:choose>
				<xsl:when test="$templateModelId">
					<xsl:copy-of select="/document/model[@id=$templateModelId]"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="/document/model[@id=concat($templateId,'_Model')]"/>
				</xsl:otherwise>
			</xsl:choose>
			*/})			
			</xsl:otherwise>	

			</xsl:choose>
			<xsl:if test="/document/model[@id='VariantStorage_Model']">
			,"variantStorageModel":new VariantStorage_Model({"data":CommonHelper.longString(function () {/*
				<xsl:copy-of select="/document/model[@id='VariantStorage_Model']"/>
			*/})})
			</xsl:if>		
			});

		v_<xsl:value-of select="$templateId"/>.toDOM();					
	</xsl:for-each>
	<!--
	<xsl:variable name="template_params" select="/document/model[@id='TemplateParamValList_Model']"/>
	
	<xsl:for-each select="model[@templateId]">
		<xsl:variable name="templateId" select="@templateId"/>
		<xsl:variable name="templateModelId" select="div[1]/@modelId"/>
	
		/*modelId=<xsl:value-of select="div[1]/@modelId"/>*/
	
		var t_params = {};
		<xsl:for-each select="$template_params/row">
		<xsl:choose>
		<xsl:when test="param_type='DateTime' or param_type='DT_DATE'">
		t_params.<xsl:value-of select="paramid"/> = DateHelper.strtotime('<xsl:value-of select="val"/>');
		</xsl:when>
		<xsl:when test="param_type='Int'">
		t_params.<xsl:value-of select="paramid"/> = parseInt('<xsl:value-of select="val"/>');
		</xsl:when>	
		<xsl:when test="param_type='Float'">
		t_params.<xsl:value-of select="paramid"/> = parseFloat('<xsl:value-of select="val"/>');
		</xsl:when>		
		<xsl:when test="param_type='Structure'">
		t_params.<xsl:value-of select="paramid"/> = <xsl:value-of select="val"/>;
		</xsl:when>						
		<xsl:otherwise>
		t_params.<xsl:value-of select="paramid"/> = '<xsl:value-of select="val"/>';
		</xsl:otherwise>
		</xsl:choose>	
		</xsl:for-each>

		application.setTemplateParams('<xsl:value-of select="$templateId"/>',t_params);
	
		var v_<xsl:value-of select="$templateId"/> = new <xsl:value-of select="$templateId"/>_View("<xsl:value-of select="$templateId"/>",{
			"app":application
			<xsl:choose>
			<xsl:when test="count(models/model) &gt; 0">
			<xsl:for-each select="models/model">
			<xsl:variable name="m_id" select="@id"/>
			,"<xsl:value-of select="$m_id"/>":CommonHelper.longString(function () {/*
			<xsl:copy-of select="/document/model[@id=$m_id]"/>
			*/})						
			</xsl:for-each>
			</xsl:when>
			
			<xsl:otherwise>
			,"modelDataStr":CommonHelper.longString(function () {/*
			<xsl:choose>
				<xsl:when test="$templateModelId">
					<xsl:copy-of select="/document/model[@id=$templateModelId]"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="/document/model[@id=concat($templateId,'_Model')]"/>
				</xsl:otherwise>
			</xsl:choose>
			*/})			
			</xsl:otherwise>	
			</xsl:choose>
			<xsl:if test="$template_params">
			,"templateParams":t_params
			</xsl:if>		
			});
		v_<xsl:value-of select="$templateId"/>.toDOM();				
	</xsl:for-each>
	-->
</xsl:template>


<!-- ERROR 
<xsl:template match="model[@id='ModelServResponse']/row/result='1'">
throw Error(CommonHelper.longString(function () {/*
<xsl:value-of select="descr"/>
*/}));
</xsl:template>
-->

<!--System variables -->
<xsl:template match="model[@id='ModelVars']/row">
	<xsl:if test="author">
		<meta name="Author" content="{author}"></meta>
	</xsl:if>
	<xsl:if test="keywords">
		<meta name="Keywords" content="{keywords}"></meta>
	</xsl:if>
	<xsl:if test="description">
		<meta name="Description" content="{description}"></meta>
	</xsl:if>
	
</xsl:template>

<!-- CSS -->
<xsl:template match="model[@id='ModelStyleSheet']/row">	
	<link rel="stylesheet" href="{concat(href,'?',$VERSION)}" type="text/css"/>
</xsl:template>

<!-- Javascript -->
<xsl:template match="model[@id='ModelJavaScript']/row">
	<script src="{concat(href,'?',$VERSION)}"></script>
</xsl:template>

<!-- Error
<xsl:template match="model[@id='ModelServResponse']/row">
	<xsl:if test="result/node()='1'">
	<div class="error"><xsl:value-of select="descr"/></div>
	</xsl:if>
</xsl:template>
 -->

</xsl:stylesheet>
