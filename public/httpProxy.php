<?php

$method = $_SERVER['REQUEST_METHOD'];
$params = array();
$url = !empty($_POST['_proxyUrl']) ? $_POST['_proxyUrl'] : $_GET['_proxyUrl'];
$headers = !empty($_POST['_proxyHaders']) ? $_POST['_proxyHeaders'] : 
        !empty($_GET['_proxyHeaders']) ? $_GET['_proxyHeaders'] : 'false';
$mimeType = !empty($_POST['_proxyMimeType']) ? $_POST['_proxyMimeType'] : 
        !empty($_GET['_proxyMimeType']) ? !empty($_GET['_proxyMimeType']) : '';

$session = curl_init();
if ('POST' == $method) {
	$params = $_POST;
} else {
	$params = $_GET;
}

$vars = '';
while ($element = current($params)) {
    $vars .= key($params).'='.$element.'&';
    next($params);
}

if ('POST' == $method) {
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt ($session, CURLOPT_POST, true);
    curl_setopt ($session, CURLOPT_POSTFIELDS, $vars);
}
else {
    curl_setopt($session, CURLOPT_URL, $url . '?' . $vars);
}

// Don't return HTTP headers. Do return the contents of the call
curl_setopt($session, CURLOPT_HEADER, ($headers == "true") ? true : false);

curl_setopt($session, CURLOPT_FOLLOWLOCATION, true); 
curl_setopt($session, CURLOPT_RETURNTRANSFER, true);

// Make the call
$response = curl_exec($session);

if ($mimeType != "") {
    // The web service returns XML. Set the Content-Type appropriately
    header("Content-Type: ".$mimeType);
}

echo $response;