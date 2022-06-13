<?php
	include 'connected.php';
	header("Access-Control-Allow-Origin: *");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
				
		$avatar = $_GET['avatar'];
		$type = $_GET['type'];
		$user = $_GET['user'];
		$seconname = $_GET['seconname'];
		$password = $_GET['password'];
		$address = $_GET['address'];
		$phone = $_GET['phone'];
		$lat = $_GET['lat'];
		$lng = $_GET['lng'];
		
							
		$sql = "INSERT INTO `user`(`avatar`, `type`, `user`, `seconname`, `username`, `password`, `address`, `phone`, `lat`, `lng`) VALUES ('$avatar','$type','$user','$seconname',Null,'$password','$address','$phone','$lat','$lng')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome Shopping";
   
}
	mysqli_close($link);
?>