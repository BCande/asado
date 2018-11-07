<?php 
require('config.php');

$query = mysqli_query($con, 'select nb from maquinista');

$listMaquinista = array();
while($rows = mysqli_fetch_assoc($query)){
	$listMaquinista[] = $rows;
}

print json_encode($listMaquinista);