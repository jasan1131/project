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
		$nameProduct = $_GET['nameProduct'];
		$typeproduct = $_GET['typeproduct'];
		$numberproduct = $_GET['numberproduct'];
		$priceProduct = $_GET['priceProduct'];
		$detailProduct = $_GET['detailProduct'];
		$images = $_GET['images'];
		
		
		
							
		$sql = "UPDATE `product` SET `nameProduct` = '$nameProduct', `typeproduct` = '$typeproduct', `numberproduct` = '$numberproduct', `priceProduct` = '$priceProduct', `detailProduct` = '$detailProduct', `Images` = '$Images' WHERE id = '$id'";

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