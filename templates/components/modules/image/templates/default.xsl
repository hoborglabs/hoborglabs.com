<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:php="http://php.net/xsl"
>
<xsl:output method="html" encoding="utf-8" indent="yes"/>
	<xsl:template match="/component">
		<img src="{$H_ROOT_PUBLIC}{data/src}" alt="{data/alt}" class="{data/size} {data/align}" />
	</xsl:template>
</xsl:stylesheet>
