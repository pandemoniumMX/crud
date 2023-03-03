<?php
include 'conn.php';

//$IDK=$_GET['IDK'];
//$IDC=$_GET['IDC'];
//$USER=$_GET['USER'];


$sql=$conn->query("

SELECT * FROM `kindtbl` ORDER BY `kindtbl`.`KIND_NAME` ASC

"); 


$result=array();

while($fetchdata=$sql->fetch_assoc()) {
    $result[]=$fetchdata;

     }
     
     
echo json_encode($result);
?> 