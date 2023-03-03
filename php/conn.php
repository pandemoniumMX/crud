<?php
//include 'checksesion.php';

$servername = "localhost";
$username = "autotrad";
$password = "Hesoyam01.";
$dbname = "autotrad_crud";

$conn = @mysqli_connect($servername, $username, $password,$dbname) or die("Connect failed: %s\n". $conn -> error);
 
if (!$conn) {
   die("Connection failed: " . mysqli_connect_error());
}

mysqli_set_charset($conn,"utf8mb4");



?>