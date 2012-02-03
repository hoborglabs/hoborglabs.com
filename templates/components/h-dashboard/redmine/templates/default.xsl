<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:php="http://php.net/xsl"
>
<xsl:output method="html" encoding="utf-8" indent="yes"/>
    <xsl:template match="/data/component">
        <script src="/scripts/rgraph/RGraph.common.core.js" ></script>
        <script src="/scripts/rgraph/RGraph.meter.js" ></script>
        <div class="h-widget h-widget-redmine {data/size}" redmine-url="{data/redmineUrl}">
            <div class="header"><h4><xsl:value-of select="data/title" /></h4></div>
            <div class="body">
                <!-- 
                <div class="h-widget-progressBar red"><div class="green" style="width: 0%"></div></div>
                <span class="h-widget-text-L">Sprint 6</span><span class="h-widget-text-XL done_ratio"> 68%</span>
                <canvas id="meter" width="350" height="170"><div class="canvasfallback">[No canvas support]</div></canvas>
                 -->
                <xsl:choose>
                    <xsl:when test="'progressMeter'= data/type">
		                <xsl:call-template name="progressMeter"></xsl:call-template>
				    </xsl:when>
				    <xsl:when test="'progressBar'= data/type">
                        <xsl:call-template name="progressBar"></xsl:call-template>
                    </xsl:when>
                    <xsl:when test="'storiesList'= data/type">
                        <xsl:call-template name="storiesList"></xsl:call-template>
                    </xsl:when>
				    <xsl:otherwise>
				        Template Error: Not valid type.
				    </xsl:otherwise>
				</xsl:choose>
            </div>
            <div class="footer">Foote text</div>
        </div>
    </xsl:template>
    
    <xsl:template name="progressBar">
        <span class="h-widget-text-L">Sprint 7</span><span class="h-widget-text-XXL done_ratio"> --%</span>
        <div class="h-widget-progressBar red"><div class="green" style="width: 0%"></div></div>
    </xsl:template>

    <xsl:template name="progressMeter">
        <span class="h-widget-text-L">Sprint 7</span><span class="h-widget-text-XXL done_ratio"> --%</span>
        <canvas id="meter" width="350" height="180"><div class="canvasfallback">[No canvas support]</div></canvas>
        <span class="h-widget-text-L">Sprint Ends 24.06</span>
    </xsl:template>
    
    <xsl:template name="storiesList">
        <span class="loading">Loading Stories data...</span>
    </xsl:template>
    
</xsl:stylesheet>