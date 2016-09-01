<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="ViewBase.html.xsl"/>

<xsl:template match="/document">
<html>
	<head>
		<xsl:call-template name="initHead"/>		
		
		<title>Bellagio,авторизация</title>
		
		<script>		
			function pageLoad(){
			
				<xsl:call-template name="initApp"/>
				
				var view = new Login_View("Login",{app:application});				
				view.toDOM();
			}
		</script>		
		
	</head>
	<body onload="pageLoad();">
		<xsl:apply-templates select="model[@id='ModelServResponse']/row"/>		

		    <div id ="Login" class="container">
			<div class="row">				
			    <div class="col-md-4 col-md-offset-4">
				<div class="login-panel panel panel-default">
				    <div class="panel-heading">
				        <img class="logo" align="middle" src="img/logo.png"/>
				    </div>
				    <div class="panel-body">				    	
				        <form role="form">
				        	<div id="Login:error"></div>
						<fieldset>
							<div id="Login:user"/>
							<div id="Login:pwd"/>
					                <div id="Login:submit_login" class="btn btn-lg btn-success btn-block"/>
						</fieldset>
				        </form>
				    </div>
				</div>
			    </div>
			</div>
		    </div>
		
	<script>
			var n = document.getElementById("Login:user");
			if (n){
				if (document.activeElement.id!="Login:pwd"){
					n.focus();
				}
			}
	</script>
		
		<xsl:call-template name="initJS"/>
	</body>
</html>		
</xsl:template>

</xsl:stylesheet>
