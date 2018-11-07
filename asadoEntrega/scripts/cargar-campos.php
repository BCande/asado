<?php
include("clases/class.mysql.php");
include("clases/class.combos.php");
$selects = new selects();
$campos = $selects->cargarCampos();
foreach($campos as $key=>$value)
{
		echo "<option value=\"$key\">$value</option>";
}
?>