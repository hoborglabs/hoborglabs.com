<?php
require_once __DIR__ . '/../autoload.php';

use Hoborg\Component\Assetic\Builder;

$path = preg_replace('#/+#', '/', $_SERVER['PATH_INFO']);

// 302 redirects
if (is_readable(__DIR__ . $path)) {
	header('Status: 302');
	header("Location: {$path}");
	exit;
}

$builder = new Builder(__DIR__, __DIR__ . '/../conf/assets.yml');

$builder->setHeaders($path);
echo $builder->buildForPath($path);