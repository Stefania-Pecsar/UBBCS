<?php
$con = mysqli_connect("localhost", "root", "", "tren");
if (!$con) {
    die('Could not connect: ' . mysqli_error());
}

$result = mysqli_query($con, "SELECT DISTINCT producator FROM produse");

$data = array();
while($row = mysqli_fetch_assoc($result)) {
    $data[] = $row['producator'];
}

echo json_encode($data);

mysqli_close($con);
?>