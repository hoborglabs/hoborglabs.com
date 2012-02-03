<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:php="http://php.net/xsl"
>
<xsl:output method="html" encoding="utf-8" indent="yes"/>
    <xsl:template match="/data/component">
        <div class="h-widget h-widget-dateTime {data/size}">
            <div class="header"><h4>Time</h4></div>
            <div class="body">
                <span class="h-widget-text-XL time">--:--</span>
                <span class="h-widget-text-M pmam"> --</span>
                <br />
                <span class="h-widget-text-M date">--</span>
                <br />
                <span class="h-widget-text-M day" >--</span>
                <span class="h-widget-text-M year"> ----</span>
            </div>
            <div class="footer">Foote text</div>
        </div>
    </xsl:template>
</xsl:stylesheet>