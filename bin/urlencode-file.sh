#!/usr/bin/env php
<?php

if ($_SERVER['argc'] < 2)  {
	echo 'Usage: ', basename(__FILE__), ' <file>', "\n", 'error: File not specified.', "\n";
	die();
}

$data = @file_get_contents($_SERVER['argv'][1]);
if ($data === false)  {
	echo 'error: Unable to open file `', $_SERVER['argv'][1], '`.', "\n";
	die();
}

echo urlencode($data);
die();


