<?php
define('HD_PUBLIC', '/dashboard-assets');
define('CONFIG_DIR', __DIR__ . '/../../conf/');
include_once __DIR__ . '/../../vendors/dashboard/dashboard.phar';

$kernel = new \Hoborg\Dashboard\Kernel('prod');

$kernel->setPath('data', array(__DIR__ . '/../../data'));
$kernel->setDefaultParam('conf', 'hoborglabs-dashboard');

// and go, go, go...
$kernel->handle($_GET);
