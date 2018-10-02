<?php
	// Connection's Parameters
	$db_host="localhost";
	$db_name="";
	$username="";
	$password="";

	$site_url = ''; // https

	$db_con=mysql_connect($db_host,$username,$password);
	$connection_string=mysql_select_db($db_name);

	// Connection
	$con=mysqli_connect($db_host,$username,$password, $db_name);

?>