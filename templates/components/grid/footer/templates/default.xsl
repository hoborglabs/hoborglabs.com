<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:php="http://php.net/xsl"
>
<xsl:output method="html" encoding="utf-8" indent="yes"/>
    <xsl:template match="/component">
        <div id="footer" class="fixed">
            <div id="footer-inner" class="fullWidth">
                <div class="footer-about">
                    <xsl:value-of select="data/about" disable-output-escaping="yes"  />
                </div>
                <div class="footer-other">
                    <xsl:value-of select="data/other" disable-output-escaping="yes" />
                </div>
            </div>
        </div>
    </xsl:template>
</xsl:stylesheet>
