<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:php="http://php.net/xsl"
>
<xsl:output method="html" encoding="utf-8" indent="yes"/>
    <xsl:template match="/data/component">
        <div class="h-widget {data/size}">
            <div class="header"><h4>Project Status</h4></div>
            <div class="body">
                <div class="h-jenkins" jenkins-url="{data/jenkinsUrl}">
                    <ul class="h-jenkins-projects"></ul>
                    <span class="loading">Loading Jenkins stats...</span>
                </div>
            </div>
            <div class="footer">Foote text</div>
        </div>
    </xsl:template>
</xsl:stylesheet>