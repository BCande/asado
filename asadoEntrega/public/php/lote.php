<?php 
require('config.php');

$query = mysqli_query($con, 'select lote_nb from lote');

$listCampos = array();
while($rows = mysqli_fetch_assoc($query)){
	$listCampos[] = $rows;
}

print json_encode($listCampos);