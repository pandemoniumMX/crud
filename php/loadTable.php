<?php
include 'conn.php';

//$IDK=$_GET['IDK'];
//$IDC=$_GET['IDC'];
//$USER=$_GET['USER'];


$sql=$conn->query("


SELECT * FROM usertbl u, kindtbl k 
WHERE u.kindtbl_idkindtbl=k.idkindtbl
AND u.USU_STATUS='A'
AND k.KIND_STATUS='A'

"); 


$result=array();

while($fetchdata=$sql->fetch_assoc()) {
    $result[]=$fetchdata;

     }
     
     
echo json_encode($result);
?> 