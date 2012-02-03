<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:php="http://php.net/xsl"
>
<xsl:output method="html" encoding="utf-8" indent="yes"/>
	<xsl:template match="/component">
	    <div class="content">
		    <h4><span>Projects</span> stats</h4>
			<div class="h-jenkins" jenkins-url="{data/jenkinsUrl}">
			    <ul class="h-jenkins-projects"></ul>
			    <span class="loading">Loading Jenkins stats</span>
		    </div>
	    </div>
	</xsl:template>
</xsl:stylesheet>
