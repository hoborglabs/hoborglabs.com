<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:php="http://php.net/xsl"
>
<xsl:output method="html" 
    encoding="utf-8"
    media-type="text/html" 
    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
    cdata-section-elements="script style"
    indent="yes"
/>
    
    <xsl:template match="/component">
        <!--
        <xsl:variable name="head">
            <xsl:value-of disable-output-escaping="yes" select="php:function('get_head')" />
        </xsl:variable>
        -->
        <html>
            <head>
                <meta http-equiv="content-type" content="text/html; charset=utf-8" />
                <title>Hoborg Labs</title>
                <meta name="keywords" content="" />
                <meta name="description" content="" />

                <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
                <link rel="icon" href="/favicon.ico" type="image/x-icon" />

                <!-- 
                <script src="{$H_BASE_PATH}/scripts/mootools_src.js"></script>
                -->
                <script src="{$H_BASE_PATH}/scripts/jquery.js"></script>
                <script src="{$H_BASE_PATH}/scripts/jquery.ui.js"></script>
                <script src="{$H_BASE_PATH}/scripts/hoborg.jenkins.js"></script>
                <script src="{$H_BASE_PATH}/scripts/hoborg.dashboard.redmine.js"></script>
                <script src="{$H_BASE_PATH}/scripts/hoborg.dashboard.dateTime.js"></script>
                
                <link rel="stylesheet" type="text/css" media="all" href="{$H_BASE_PATH}/styles/css/grid.css" />
                <link rel="stylesheet" type="text/css" media="all" href="{$H_BASE_PATH}/styles/css/global.css" />
                <link rel="stylesheet" type="text/css" media="all" href="{$H_BASE_PATH}/styles/css/modules.css" />
                <link rel="stylesheet" type="text/css" media="all" href="{$H_BASE_PATH}/styles/css/dashboard.css" />
                <link rel="stylesheet" type="text/css" media="all" href="{$H_BASE_PATH}/styles/css/handheld.css" />
                <meta name="viewport" content="initial-scale = 1.0,maximum-scale = 1.0" />
            </head>
            <body>
                <xsl:value-of select="$H_SUB_COMPONENTS" disable-output-escaping="yes" />
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
