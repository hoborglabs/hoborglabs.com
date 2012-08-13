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
	
	<xsl:template match="/page">
		<!--
		<xsl:variable name="head">
			<xsl:value-of disable-output-escaping="yes" select="php:function('get_head')" />
		</xsl:variable>
		-->
		<html lang="EN" xml:lang="EN" dir="ltr" xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
				<meta http-equiv="Content-Language" content="en" />
				
				<!-- 
				<script src="{$H_BASE_PATH}/scripts/mootools_src.js"></script>
				 -->
				
				<link rel="stylesheet" type="text/css" media="all" href="{$H_BASE_PATH}/styles/css/grid.css" />
				<link rel="stylesheet" type="text/css" media="all" href="{$H_BASE_PATH}/styles/css/global.css" />
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-21753843-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>				
				<!--
				<xsl:copy-of select="$head" />
				-->
			</head>
			
			<body>
				<xsl:value-of select="$H_SUB_COMPONENTS" disable-output-escaping="yes" />
				<div id="footer">
				    <div class="wrapper clearfix">
				        <span>copyrights 2011 - EFA, email: <a href="mailto:contact@efa-academy.co.uk">contact us</a></span>
					   <span class="hoborg">powered by <a href="http://hoborglabs.com" title="Hoborg CMS">Hoborg</a></span>
				    </div>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
