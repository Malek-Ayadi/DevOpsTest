<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);

$conn = mysqli_connect($_ENV['DB_HOST'], $_ENV['DB_USER'], $_ENV['DB_PASSWORD']) or die('Failed to connect to DB.');
mysqli_select_db($conn, $_ENV['DB_NAME']) or die('Failed to connect to DB.');

echo "All fine :)."

?>
