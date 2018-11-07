<?php
include("clases/class.mysql.php");
include("clases/class.combos.php");
$lotes = new selects();
$lotes->code = $_GET["code"];
$lotes = $lotes->cargarLotes();
foreach($lotes as $key=>$value)
{
		echo "<option value=\"$key\">$value</option>";
}
?>