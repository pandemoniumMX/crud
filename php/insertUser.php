<?php
include 'conn.php';

$NAME=$_GET['NAME'];
$LAST=$_GET['LAST'];
$MAIL=$_GET['MAIL'];
$KIND=$_GET['KIND'];


$sql=$conn->query("


INSERT INTO `usertbl` (`idusertbl`, `USU_NAME`, `USU_LASTNAME`, `USU_MAIL`, `USU_STATUS`, `kindtbl_idkindtbl`) 
VALUES (NULL, '$NAME', '$LAST', '$MAIL', 'A', '$KIND');

"); 


$result=array();

while($fetchdata=$sql->fetch_assoc()) {
    $result[]=$fetchdata;

     }
     
     
echo json_encode($result);
?> 