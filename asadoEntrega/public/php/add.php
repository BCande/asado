<?php
require('config.php');

$data = json_decode(file_get_contents("php://input"));

$name = mysqli_real_escape_string($con, $data->name);
$email = mysqli_real_escape_string($con, $data->email);

$query = mysqli_query($con, "insert into students (student_name, student_email) values ('$name', '$email')") or die ('Unable to execute query. '. mysqli_error($con));



if (
   !empty($_POST['name']) && !empty($_POST['age']) &&
   is_array($_POST['name']) && is_array($_POST['age']) &&
   count($_POST['name']) === count($_POST['age'])
) {
    $name_array = $_POST['name'];
    $age_array = $_POST['age'];
    for ($i = 0; $i < count($name_array); $i++) {

        $name = mysql_real_escape_string($name_array[$i]);
        $age = mysql_real_escape_string($age_array[$i]);

        mysql_query("insert into users (name, age) values ('$name', '$age')");
    } 
}

?>