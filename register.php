<?php
	$title = 'Registracija korisnika';
	include 'header.php';
	if($fgmembersite->CheckLogin()) $fgmembersite->RedirectToURL("index.php");
	include 'lang/hr.php';
	
	$l = 1;	
?>
			<div role="main" class="main">
				<div id="content" class="register_member">

					<div class="home-intro light">
						<div class="container">

							<div class="row">
								<div class="col-md-8">
									<p style="font-family:Calibri,Arial,Helvetica;">
										Već ste naš registrirani <em>korisnik</em> ?
										<span>Molimo Vas da se prijavite</span>
									</p>
								</div>
								<div class="col-md-4">
									<div class="get-started">
										<a href="<?=$site_url;?>login.php" class="btn btn-lg btn-primary">Prijava</a>
									</div>
								</div>
							</div>

						</div>
					</div>
					
					<div class="container">

					<div class="row">
						<div class="col-md-12">

							<div class="row featured-boxes login">
								<div class="col-md-12">
									<div class="featured-box featured-box-secundary default info-content">
										<div class="box-content registracija">
											<h4>Registracija novog korisnika</h4>
											<form action="" id="" type="post">
													<form id="contactForm" action="contact-us-advanced.php#contact-sent" method="POST" enctype="multipart/form-data" novalidate="novalidate">
														<input type="hidden" value="true" name="emailSent" id="emailSent">
														<div class="row">
																<div class="col-md-12">
																	<label>Vaš OIB</label>
																	<input type="text" placeholder="12345678901" value="" data-msg-required="Molimo Vas da upišite svoj OIB." maxlength="11" class="form-control" name="oib" id="oib">
																</div>
																<div class="col-md-6">
																	<label>Vaše ime</label>
																	<input type="text" placeholder="Ivan" value="" data-msg-required="Molimo Vas da upišite svoje ime." maxlength="50" class="form-control" name="ime" id="ime">
																</div>
																<div class="col-md-6">
																	<label>Vaše prezime</label>
																	<input type="text" placeholder="Horvat" value="" data-msg-required="Molimo Vas da upišete svoje prezime." maxlength="50" class="form-control" name="prezime" id="prezime">
																</div>
														</div>
														<div class="row">
																<div class="col-md-9">
																	<label>Ulica</label>
																	<input type="text" value="" placeholder="Avenija Dubrovnik" maxlength="150" class="form-control" name="ulica" id="ulica">
																</div>
																<div class="col-md-3">
																	<label>Kućni broj</label>
																	<input type="text" value="" placeholder="3 A" maxlength="10" class="form-control" name="kbroj" id="kbroj">
																</div>
																<div class="col-md-6">
																	<label>Županija</label>
																	<select class="form-control regions" name="zupanija"><option value="0">Županija</option><option value="1">ZAGREBAČKA</option><option value="2">KRAPINSKO-ZAGORSKA</option><option value="3">SISAČKO-MOSLAVAČKA</option><option value="4">KARLOVAČKA</option><option value="5">VARAŽDINSKA</option><option value="6">KOPRIVNIČKO-KRIŽEVAČKA</option><option value="7">BJELOVARSKO-BILOGORSKA</option><option value="8">PRIMORSKO-GORANSKA</option><option value="9">LIČKO-SENJSKA</option><option value="10">VIROVITIČKO-PODRAVSKA</option><option value="11">POŽEŠKO-SLAVONSKA</option><option value="12">BRODSKO-POSAVSKA</option><option value="13">ZADARSKA</option><option value="14">OSJEČKO-BARANJSKA</option><option value="15">ŠIBENSKO-KNINSKA</option><option value="16">VUKOVARSKO-SRIJEMSKA</option><option value="17">SPLITSKO-DALMATINSKA</option><option value="18">ISTARSKA</option><option value="19">DUBROVAČKO-NERETVANSKA</option><option value="20">MEĐIMURSKA</option><option value="21">GRAD ZAGREB</option></select>
																</div>
																<div class="col-md-6">
																	<label>Grad</label>
																	<select class="form-control city" name="grad"><option value="0">Grad</option><option value="1">Dugo Selo</option><option value="2">Ivanić Grad</option><option value="3">Jastrebarsko</option><option value="4">Samobor</option><option value="5">Sveta Nedelja</option><option value="6">Sveti Ivan Zelina</option><option value="7">Velika Gorica</option><option value="8">Vrbovec</option><option value="9">Zaprešić</option><option value="10">Bedenica</option><option value="11">Bistra</option><option value="12">Brckovljani</option><option value="13">Brdovec</option><option value="14">Dubrava</option><option value="15">Dubravica</option><option value="16">Farkaševac</option><option value="17">Gradec</option><option value="18">Jakovlje</option><option value="19">Klinča Sela</option><option value="20">Kloštar Ivanić</option><option value="21">Krašić</option><option value="22">Kravarsko</option><option value="23">Križ</option><option value="24">Luka</option><option value="25">Marija Gorica</option><option value="26">Orle</option><option value="27">Pisarovina</option><option value="28">Pokupsko</option><option value="29">Preseka</option><option value="30">Pušća</option><option value="31">Rakovec</option><option value="32">Rugvica</option><option value="33">Stupnik</option><option value="34">Žumberak</option></select>
																</div>
														</div>
														<div class="row">
																<div class="col-md-6">
																	<label>Vaša e-mail adresa</label>
																	<input type="text" value="" class="form-control" placeholder="demo@email.com" name="email" id="email">
																</div>
																<div class="col-md-6">
																	<label>Ponovite vašu e-mail adresu</label>
																	<input type="text" value="" class="form-control" placeholder="demo@email.com" name="email" id="email">
																</div>
																<div class="col-md-12">
																	<label>Kontakt mob/tel</label>
																	<input type="text" value="" maxlength="50" class="form-control" placeholder="01 1234 567" name="kontaktm" id="kontaktm">
																</div>
														</div>
														<div class="row">
															<div class="col-md-6">
																<label>Kontaktirajte me putem : </label>
																<br>
																<label class="checkbox-inline">
																	<input type="checkbox" name="checkboxes[]" id="nKon" value="1"> mobitela
																</label>
																<br>
																<label class="checkbox-inline">
																	<input type="checkbox" name="checkboxes[]" id="nKon" value="2"> email adrese
																</label>
															</div>
															<div class="col-md-6">
																<label>Kontaktirajte me u terminu : </label>
																<br>
																<label class="checkbox-inline">
																	<input type="radio" name="checkboxes[]" id="termin" value="1"> 08:00 - 12:00
																</label>
																<br>
																<label class="checkbox-inline">
																	<input type="radio" name="checkboxes[]" id="termin" value="2"> 12:00 - 14:00
																</label>
																<br>
																<label class="checkbox-inline">
																	<input type="radio" name="checkboxes[]" id="termin" value="3"> 14:00 - 16:00
																</label>
																<br>
																<label class="checkbox-inline">
																	<input type="radio" name="checkboxes[]" id="termin" value="3"> 16:00 - 20:00
																</label>
															</div>
														</div>
														<div class="modal-footer" style="border-top:0px;">
															<button type="button" class="btn btn-success disabled takeSer">Registracija</button>
														</div>
											</form>
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
