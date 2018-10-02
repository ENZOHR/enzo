<?php

	require_once("includes/oop/membersite_config.php");
	
	$fgmembersite->LogOut();
	
	$fgmembersite->RedirectToURL("index.php");
    
	exit;

?>