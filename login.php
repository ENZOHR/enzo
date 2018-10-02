<?php
	$title = 'Prijava';
	include 'header.php';
	if($fgmembersite->CheckLogin()) $fgmembersite->RedirectToURL("index.php");
	
	if(isset($_POST['username']))
	{
	   if($fgmembersite->Login())
	   {			
			$type = $fgmembersite->getMembershipType();
			if($type==='member') $fgmembersite->RedirectToURL("account_member.php");
			else $fgmembersite->RedirectToURL("index.php");
	   }
	}
?>
			<div role="main" class="main">
				<div id="content" class="register_member">

					<div class="home-intro light">
						<div class="container">						
							<div class="row">
								<div class="col-md-8">
									<!--
									<p style="font-family:Calibri,Arial,Helvetica;">
										Ukoliko već nemate svoj <em>korisnički račun</em> ?
										<span>Registirajte se besplatno.</span>
									</p>
									-->
								</div>
								<!--
								<div class="col-md-4">
									<div class="get-started">
										<a href="<?=$site_url;?>register.php" class="btn btn-lg btn-primary">Registracija</a>
									</div>
								</div>
								-->
							</div>

						</div>
					</div>
					
					<div class="container">

					<div class="row">
						<div class="col-md-12" style="margin-top:60px;">

													<?								
								if(isset($_POST['username']))
									{
									   if(!$fgmembersite->Login())
									   { ?>
											
											<div class="alert alert-danger">
												<strong>Neuspješna prijava !</strong> Nažalost, Vaš OIB i lozinka se ne podudaraju. Molimo Vas da provjerite svoje podatke i pokušate se prijaviti ponovo.
											</div>
											
									   <? }
									}							
							?>	
						
							<div class="row featured-boxes login">
								<div class="col-md-6">
									<div class="featured-box featured-box-secundary default info-content" style="height: 336px;">
										<div class="box-content">
											<h4>Prijava korisnika</h4>
											<form action="login.php" id="prijava" method="POST">
												<div class="row">
													<div class="form-group">
														<div class="col-md-12">
															<label>Upišite svoj OIB</label>
															<input type="text" value="" maxlength="11" id="oib" name="username" placeholder="12345678901" class="form-control">
														</div>
													</div>
												</div>
												<div class="row">
													<div class="form-group">
														<div class="col-md-12">
															<a class="pull-right" href="#">Zaboravljena lozinka</a>
															<label>Lozinka</label>
															<input type="password" value="" id="pwdUser" name="password" placeholder="Lozinka ili tajni ključ" class="form-control">
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-md-6"></div>
													<div class="col-md-6">
														<input type="submit" value="Prijava" class="btn btn-primary pull-right push-bottom">
													</div>
												</div>
											</form>
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="featured-box featured-box-secundary default info-content">
										<div class="box-content">
											<!--
											<h4>Registracija korisnika</h4>
											<p>
												Naručite željeni certifikat u samo 4 koraka. <br /><br /> Kako bi ste napravili narudžbu brže, preporučamo Vam da kreirate svoj korisnički račun,
												te tako smanjite proces narudžbe. <br /><br />
												
												Vaš korisnički račun na Enzo.hr je u potpunosti siguran.<br /><br />
											</p>
											<a href="http://dev.efortis.net/LN_hr/register.php" class="btn btn-primary pull-right push-bottom">Registracija</a>
											<p class="clear"></p>
											-->
										</div>
									</div>
								</div>
							</div>

						</div>
					</div>

				</div>
								
								
								
								
								
				</div>
			</div>
<?php
	include 'footer.php';
?>
