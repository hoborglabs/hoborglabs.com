<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:php="http://php.net/xsl"
>
<xsl:output method="html" encoding="utf-8" indent="yes"/>
    <xsl:template match="/component">
        <div id="main" class="{data/type}">
            <div id="main_inner" class="fullWidth">
                <xsl:value-of select="$H_SUB_COMPONENTS" disable-output-escaping="yes" />
                <br class="clear" />
            </div>
        </div>
    </xsl:template>

</xsl:stylesheet>