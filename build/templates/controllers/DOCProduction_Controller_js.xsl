<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="Controller_js20.xsl"/>

<!-- -->
<xsl:variable name="CONTROLLER_ID" select="'DOCProduction'"/>
<!-- -->

<xsl:output method="text" indent="yes"
			doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" 
			doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
			
<xsl:template match="/">
	<xsl:apply-templates select="metadata/controllers/controller[@id=$CONTROLLER_ID]"/>
	
DOCProduction_Controller.prototype.getPrintList = function(){
	return  [
		new PrintObj({
			"caption":"Комплектация",
			"publicMethod":this.getPublicMethod("get_print"),
			"templ":"DOCProductionPrint",
			"publicMethodKeyIds":["doc_id"]
		}),
	
		new PrintObj({
			"caption":"Этикетка",
			"publicMethod":this.getPublicMethod("print_barcode"),
			"templ":"DOCProductionBarcode",
			"publicMethodKeyIds":["doc_id"]
		})
	];
}
	
</xsl:template>

</xsl:stylesheet>
