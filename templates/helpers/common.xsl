<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- 
	Template: Internal Link 
	This template displays link to internal page 
	-->
	<xsl:template name="InternalLink">
		<xsl:param name="link" />
		<a href="{$H_ROOT_PUBLIC}{$link/@href}">
			<xsl:value-of disable-output-escaping="yes" select="$link" />
		</a>
	</xsl:template>

	<!-- Template: Page Head @param type - generic name for you data. You can 
		use the same name to combine data or to controll incidence @incidence (onceonly|instance) 
		- @data - html string that will be included to pae head section. -->
	<xsl:template name="PageHead">
		<xsl:param name="type" />
		<xsl:param name="incidence" />
		<xsl:param name="data" />
		<xsl:value-of
			select="php:function('hTag_PageHead', $type, $incidence, $data)" />
	</xsl:template>

	<xsl:template name="GetPageHead">
		<xsl:value-of disable-output-escaping="yes"
			select="php:function('hTag_GetPageHead', $type, $incidence, $data)" />
	</xsl:template>

</xsl:stylesheet>
