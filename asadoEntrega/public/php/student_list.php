<?php 
require('config.php');

$query = mysqli_query($con, 'select * from labores_historicas');

$student_list = array();
while($rows = mysqli_fetch_assoc($query)){
	$student_list[] = $rows;
}

print json_encode($student_list);