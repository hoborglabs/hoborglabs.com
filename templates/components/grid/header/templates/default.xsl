<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:php="http://php.net/xsl">
	<xsl:output method="html" encoding="utf-8" indent="yes" />
	<xsl:include href="../../../../helpers/common.xsl" />

	<xsl:template match="/component">
		<div id="header">
		    <div class="flags">
			    <a href="{$H_ROOT_PUBLIC}/pl" class="flag pl">PL</a>, <a href="{$H_ROOT_PUBLIC}/en" class="flag gb">EN</a>
		    </div>
			<div id="headerInner" class="fullWidth">
				<img class="logo" src="{$H_ROOT_PUBLIC}/images/logo.png" />
				<div id="logo">
					<h1>
						<span>
							<xsl:value-of select="data/titlePrimary" />
						</span>
						<xsl:value-of select="data/titleSecondary" />
					</h1>
					<h2>
						<xsl:value-of select="data/subtitle" />
					</h2>
				</div>
				<div id="menu">
					<ul>
						<xsl:apply-templates select="data/menu/en/link" />
					</ul>
				</div>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="link" name="link">
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="position() = last()">
					<![CDATA[last ]]>
					<xsl:value-of select="@active" />
				</xsl:when>
				<xsl:when test="position() = 1">
                    <![CDATA[first ]]>
                    <xsl:value-of select="@active" />
                </xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="@active" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<li class="{$class}">
		    <a href="{$H_ROOT_PUBLIC}{@href}"><xsl:value-of disable-output-escaping="yes" select="." /></a>
		</li>
		<!-- 
		<xsl:apply-templates name="linkLi">
			<xsl:with-param name="class" select="$class" />
		</xsl:apply-templates>
		-->
	</xsl:template>

	<xsl:template name="linkLi">
		<xsl:param name="class" />
		<li class="{$class}">
			<xsl:call-template name="InternalLink">
				<xsl:with-param name="link" select="." />
			</xsl:call-template>
		</li>
	</xsl:template>

</xsl:stylesheet>
