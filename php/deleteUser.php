<?php
include 'conn.php';


$ID=$_GET['ID'];


$sql=$conn->query("

UPDATE `usertbl` SET `USU_STATUS` = 'B' WHERE `usertbl`.`idusertbl` = $ID;


"); 


$result=array();

while($fetchdata=$sql->fetch_assoc()) {
    $result[]=$fetchdata;

     }
     
     
echo json_encode($result);
?> 