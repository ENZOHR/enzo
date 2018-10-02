<?php
	$title = 'Potvrda korisničkog računa';
	if(isset($_GET['link'])){
		include 'header.php';
		include 'lang/hr.php';
		include 'includes/functions.php';
		$status = $fgmembersite->checkVerify($_GET['link']);
		if($status !== true) header('Location: index.php');
		if($fgmembersite->CheckLogin()) header('Location: index.php');
?>
			<div role="main" class="main">
				<div id="content" class="register_member">

					<div class="home-intro light"></div>
					
					<div class="container">

					<div class="row">
						<div class="col-md-12" style="margin-top:60px;">
							<div class="alert alert-success">
								<strong>Aktivirano !</strong> Korisnički račun Vam je aktiviran. Molimo Vas da postavite osobnu lozinku i sigurnosno pitanje.
							</div>
							<div class="row featured-boxes login">
								<div class="col-md-4">
									<div class="featured-box featured-box-secundary default info-content">
										<div class="box-content autorization" style="position:relative;">
											<h4>Autorizacija korisnika</h4>
											<form action="" id="" type="post">
												<div class="row">
													<div class="form-group">
														<div class="col-md-12">
															<label>Upišite svoj OIB</label>
															<input type="number" value="" placeholder="Upišite OIB" id="OIB" class="numberO form-control">
														</div>
													</div>
												</div>
												<div class="row">
													<div class="form-group">
														<div class="col-md-12">
															<label>Upišite tajni ključ</label>
															<input type="text" value="" id="secKey" placeholder="Tajni ključ..." class="numberO form-control">
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-md-6"></div>
													<div class="col-md-6">
														<input type="button" value="Autorizacija" id="autoRez" class="btn btn-primary pull-right push-bottom disabled">
													</div>
												</div>
											</form>
											<div class="overlay"></div>
											<div class="over" style="display:none;margin-top:-5px;"></div>
										</div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="featured-box featured-box-secundary default info-content">
										<div class="box-content new-pass-box" style="position:relative;">
											<h4>Postavljanje lozinke</h4>
											<form action="" id="" type="post">
												<div class="row">
													<div class="form-group">
														<div class="col-md-12">
															<label>Upišite svoju lozinku</label>
															<input type="password" value="" placeholder="Minimalno 6 znakova" id="pwdUser1" class="form-control">
														</div>
													</div>
												</div>
												<div class="row">
													<div class="form-group">
														<div class="col-md-12">
															<label>Ponovite svoju lozinku</label>
															<input type="password" value="" id="pwdUser" placeholder="Ponovite Vašu lozinku" class="form-control">
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-md-6"></div>
													<div class="col-md-6">
														<input type="button" value="Spremi lozinku" id="sPass" class="btn btn-primary pull-right push-bottom disabled">
													</div>
												</div>
											</form>
											<div class="overlay" style="display:none;margin-top:-5px;"></div>
											<div class="over" style="display:block;margin-top:-5px;"></div>
										</div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="featured-box featured-box-secundary default info-content sec-q">
										<div class="box-content">
											<h4>Tajno pitanje</h4>
											<form action="" id="" type="post">
												<div class="row">
													<div class="form-group">
														<div class="col-md-12">
															<label>Odaberite tajno pitanje</label>
															<select class="form-control secQ" name="tajno_pitanje">
																<option value="0">
																	Vaš omiljeni grad ?
																</option>
																<option value="1">
																	Naziv prvog kućnog ljubimca ?
																</option>
																<option value="2">
																	Omiljeni predmet u srednjoj školi ?
																</option>
																<option value="3">
																	Najdraži sportski klub ?
																</option>
																<option value="4">
																	Djevojačko prezime moje majke ?
																</option>
															</select>
														</div>
													</div>
												</div>
												<div class="row">
													<div class="form-group">
														<div class="col-md-12">
															<label>Odgovor na pitanje</label>
															<input type="text" value="" placeholder="Odgovor" class="form-control secA">
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-md-6"></div>
													<div class="col-md-6">
														<input type="button" value="Spremi sigurnosno pitanje" class="btn btn-primary pull-right push-bottom">
													</div>
												</div>
											</form>
											<div class="over" style="display:block;"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<input type="hidden" value="<?=$_GET['link'];?>" id="linkVer" />
				</div>
					

				<script src="vendor/jquery.js"></script>
				<script src="js/verifyMember.js"></script>				
								
								
				</div>
			</div>
<?php
	include 'footer.php';
	} else {
		header( 'Location: index.php' ) ;
	}
?>
