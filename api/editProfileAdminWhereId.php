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
			
		$id = $_GET['id'];
		$avatar = $_GET['avatar'];
		$name = $_GET['name'];
		$seconname = $_GET['seconname'];
		$address = $_GET['address'];
		$phone = $_GET['phone'];
		$lat = $_GET['lat'];
		$lng = $_GET['lng'];
		
		
		
		
							
		$sql = "UPDATE `user` SET `avatar` = '$avatar', `name` = '$name', `seconname` = '$seconname', `address` = '$address', `phone` = '$phone', `lat` = '$lat', `lng` = '$lng' WHERE id = '$id'";

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