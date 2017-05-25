<?php
/**
 * This is simple router for the build in server (php -S)
 */
$path = "public${_SERVER["REQUEST_URI"]}";

# append ".html" to path is resource does not exitst
if (!file_exists("$path")) {
	if (file_exists("${path}.html")) {
		readfile("${path}.html");
	}
}
else {
	return FALSE;
}
