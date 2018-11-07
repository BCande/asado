<?php 
require('config.php');

$query = mysqli_query($con, 'select nb from producto');

$listProducto = array();
while($rows = mysqli_fetch_assoc($query)){
	$listProducto[] = $rows;
}

print json_encode($listProducto);