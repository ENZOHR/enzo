<?php
	
	include_once 'config.php';

	function genPassword($length = 8)
	{
	  $password = "";
	  $possible = "0123456789abcdfghjkmnpqrstvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	  $i = 0;
	  while ($i < $length) {
		$char = substr($possible, mt_rand(0, strlen($possible)-1), 1);
		if (!strstr($password, $char)) {
		  $password .= $char;
		  $i++;
		}
	  }
	  return $password;
	}

	function checkVerify($id, $con){
		$count = strlen($id);
		if($count != 32) return false;
	
		$query = 'SELECT confirmed,activation,pass,sec_q FROM user WHERE activation="' . $id . '" AND confirmed="N"';	
		$result = mysqli_query($con, $query);
	
		$num_rows = $result->num_rows;
		
		if($num_rows==1){
			while($row = mysqli_fetch_array($result)){
				if($row['confirmed']==='Y') return false;
			}		
		} else return false;
		
		$result->close();
	}
	
?>