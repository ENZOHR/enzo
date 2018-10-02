<?php
	require_once("includes/oop/membersite_config.php");
?>
<!DOCTYPE html>
<!--[if IE 8]>			<html class="ie ie8"> <![endif]-->
<!--[if IE 9]>			<html class="ie ie9"> <![endif]-->
<!--[if gt IE 9]><!-->	<html> <!--<![endif]-->
	<head>

		<!-- Basic -->
		<meta charset="utf-8">
		<title>Naslovnica | Enzo.hr</title>
		<meta name="description" content="Enzo je besplatan web servis koji služi za najbolju pretragu certifikatora za pojedine usluge certifikacije.">
		<meta name="author" content="http://www.efortis.net">
		
		<link rel="icon" type="image/png" href="<?=$site_url;?>img/favicon.png" />

		<!-- Mobile Metas -->
		<meta name="viewport" content="width=device-width, initial-scale=1.0">

		<!-- Web Fonts  -->
		<link href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800|Shadows+Into+Light" rel="stylesheet" type="text/css">

		<!-- Libs CSS -->
		<link rel="stylesheet" href="css/bootstrap.css">
		<link rel="stylesheet" href="css/slider.css">
		<link rel="stylesheet" href="css/fonts/font-awesome/css/font-awesome.css">
		<link rel="stylesheet" href="vendor/owl-carousel/owl.carousel.css" media="screen">
		<link rel="stylesheet" href="vendor/owl-carousel/owl.theme.css" media="screen">
		<link rel="stylesheet" href="vendor/magnific-popup/magnific-popup.css" media="screen">

		<!-- Theme CSS -->
		<link rel="stylesheet" href="css/theme.css">
		<link rel="stylesheet" href="css/theme-elements.css">
		<link rel="stylesheet" href="css/theme-animate.css">

		<!-- Current Page Styles -->
		<link rel="stylesheet" href="vendor/rs-plugin/css/settings.css" media="screen">
		<link rel="stylesheet" href="vendor/circle-flip-slideshow/css/component.css" media="screen">

		<!-- Skin CSS -->
		<link rel="stylesheet" href="css/skins/blue.css">

		<!-- Custom CSS -->
		<link rel="stylesheet" href="css/custom.css">

		<!-- Responsive CSS -->
		<link rel="stylesheet" href="css/theme-responsive.css" />

		<!-- Head Libs -->
		<script src="vendor/modernizr.js"></script>

		<!--[if IE]>
			<link rel="stylesheet" href="css/ie.css">
		<![endif]-->

		<!--[if lte IE 8]>
			<script src="vendor/respond.js"></script>
		<![endif]-->
		
	</head>
	<body>
		<div class="body">
			<header>
				<div class="container">
					<h1 class="logo">
						<a href="index.php">
							<img alt="Enzo.hr | Službeni logo" src="<?=$site_url;?>img/logo.png">
						</a>
					</h1>
					<!--
					<div class="search">
						<form id="searchForm" action="page-search-results.html" method="get">
							<div class="input-group">
								<input type="text" class="form-control search" name="q" id="q" placeholder="Pretraga...">
								<span class="input-group-btn">
									<button class="btn btn-default" type="button"><i class="icon icon-search"></i></button>
								</span>
							</div>
						</form>
					</div>
					<nav>
						<ul class="nav nav-pills nav-top">
							<li>
								<a href="#"><i class="icon icon-angle-right"></i>O nama</a>
							</li>
							<li>
								<a href="#"><i class="icon icon-angle-right"></i>Kontaktirajte nas</a>
							</li>
							<li class="phone">
								<span><i class="icon icon-phone"></i>(123) 456-7890</span>
							</li>
						</ul>
					</nav>
					-->
					<button class="btn btn-responsive-nav btn-inverse" data-toggle="collapse" data-target=".nav-main-collapse">
						<i class="icon icon-bars"></i>
					</button>
				</div>
				<div class="navbar-collapse nav-main-collapse collapse">
					<div class="container">
						<nav class="nav-main mega-menu">
							<ul class="nav nav-pills nav-main" id="mainMenu">
								<li class="dropdown ">
									<a class="dropdown-toggle" href="index.php">
										Naslovnica
									</a>
								</li>
								<li><a href="<?=$site_url;?>login.php">Prijava korisnika</a></li>
							</ul>
						</nav>
					</div>
				</div>
			</header>