<?php
	$title = 'Naslovnica';
	include 'header.php';
	include 'lang/hr.php';
	
	$l = 1;	
?>
			<div role="main" class="main">
				<div id="content" class="content full home">

					<div class="home-intro light">
						<div class="container">
							<div class="row center upF">
								<div class="col-md-12">
									<h2 class="short word-rotator-title" style="font-family:Calibri,Arial,Helvetica;">
										Riješite svoj problem u 
										<strong class="inverted"><span>četiri</span></strong>
										koraka.
									</h2>
								</div>
							</div>	
						</div>
					</div>
					
					<div class="container" id="appl">
					
						<div class="row">
							<div class="col-md-12">
								<div class="tabs" id="mainGame">
									<!--
									<ul class="nav nav-tabs">
										<li class="active"><a href="#izborUsluge" data-name="Usluge" data-toggle="tab">Usluge</a></li>
										<li><a class="disabled" href="#nekretnine" data-name="Nekretnina" data-toggle="tab">2</a></li>
										<li><a class="disabled" href="#lokacija" data-name="Lokacija" data-toggle="tab">3</a></li>
										<li><a class="disabled" href="#ponude" data-name="Ponude" data-toggle="tab">4</a></li>
									</ul>
									-->
									<div class="tab-content" id="chooseCer">
										<div class="tab-pane active" id="izborUsluge">				
											<div class="row featured-boxes">
												<!--
												<h1>1 - Izaberite uslugu</h1>
												-->
												<div class="col-md-12">
													<div class="col-md-3">
														<div class="featured-box featured-box-simple featured-box-primary notificationPick">
															<h1>Izaberite uslugu</h1>
														</div>
													</div>
													<div class="col-md-3">
														<div class="featured-box featured-box-simple featured-box-tertiary avail">
															<a href="#izborUsluge" data-hash class="box-content mCall">
																<i class="image-icon user big"></i>
																<h4>Energetski <br /> certifikat</h4>
															</a>
														</div>
													</div>
													<div class="col-md-3">
														<div class="featured-box featured-box-simple featured-box-primary avail">
															<a href="#izborUsluge" data-hash class="box-content mCall">
																<i class="image-icon user big"></i>
																<h4>Energetski <br /> pregled</h4>															
															</a>
														</div>
													</div>
													<div class="col-md-3">
														<div class="featured-box featured-box-simple featured-box-tertiary disabled">
															<a href="#izborUsluge" data-hash class="box-content mCall disabled">
																<i class="image-icon user big"></i>
																<h4>CO2 Certifikat <br />* uskoro *</h4>
															</a>
														</div>
													</div>
												</div>
											</div>
											<div class="overlay"></div>						
										</div>
										<div class="tab-pane">
											<div class="col-md-6" id="nekretnine">
												<!--
												<h1>2 - Izaberite tip nekretnine</h1>
												-->
												<div class="panel-body vnch">
													<div class="col-md-6"><a href="#lokacija" data-hash class="btn choice btn-default form-control">Stan</a></div>
													<div class="col-md-6"><a href="#lokacija" data-hash class="btn choice btn-default form-control">Kuća</a></div>
													<div class="col-md-6"><a href="#lokacija" data-hash class="btn choice btn-default form-control">Apartman</a></div>
													<div class="col-md-6"><a href="#lokacija" data-hash class="btn choice btn-default form-control">Poslovni prostor</a></div>
													<div class="col-md-6"><a href="#lokacija" data-hash class="btn choice btn-default form-control">Vikendica</a></div>
													<div class="col-md-6"><a href="#lokacija" data-hash class="btn choice btn-default form-control">Zgrada</a></div>
												</div>							
											</div>
											<div class="col-md-6" id="lokacija">
												<div class="panel-body">
													<div class="col-md-6">
														<select class="regions"></select>
													</div>
													<div class="col-md-6">
														<select class="city">
															<option value="0">Grad</option>
														</select>
													</div>						
													
													<label class="col-md-12">
														Broj kvadrata :
													</label>
													<div class="col-md-8">
														<input id="kvadrati" data-slider-id="kvadrati" data-slider-tooltip="hide" type="text" data-slider-min="0" data-slider-max="1000" data-slider-step="1" data-slider-value="500" value="0" />
													</div>
													
													<div class="col-md-4">
														<div class="input-group square">
															<input type="number" id="square" placeholder="25" class="form-control">
															<span class="input-group-addon">m&sup2;</span>
														</div>
													</div>
													<div class="col-md-8"></div>
													<div class="col-md-4 conf">
														<a href="#chooseCer" data-hash class="btn btn-primary getList form-control disabled">Potvrdi</a>
													</div>
												</div>
												<div class="over"></div>												
											</div>
											<p class="clear"></p>
											<button type="button" class="btn choice btn-info" id="izCert" style="margin-top:-40px;">
												<span class="icon icon-th-large"></span> Povratak na izbor usluge
											</button>
											<div class="overlay"></div>	
										</div>
										
										<div class="tab-pane" id="lista">
											<div class="panel">
												<!--
												<h1>3 - Odaberite ponudu</h1>
												-->
												<div class="filter">
													<!-- Dodati filter za pretragu -->
												</div>
												<table class="table">
													<thead>
													  <tr>
														<th>Naziv tvrtke</th>
														<th>Lokacija</th>
														<th>Ponuda (HRK)</th>
													  </tr>
													</thead>
													<!--
													<tbody>
													<?
														for($i=0;$i<10;$i++){
													?>
													  <tr>
														<td><strong>HEP</strong><br /><img src="http://cdn.easyeartraining.com/images/stars4.png" /></td>
														<td>Vukovarska 1, Zagreb</td>
														<td>
															<button type="button" data-toggle="modal" data-target="#ponuda"  class="btn btn-success">3140.27</button>
														</td>
													  </tr>
													<? } ?>
													</tbody>
													-->
											    </table>
												<p style="text-align:center;margin:100px 0;font-size:20px;">
														<strong>
														NARUDŽBA KUPONA ĆE BITI OMOGUĆENA 31.03.2014.
														</strong>
													</p>
											</div>												
										</div>
										
									</div>
								</div>
							</div>
						</div>
					
						
					</div>
					
					<div class="container" style="margin-top:-30px;">
						<div class="home-intro light cert4">
							<div class="row">
								<div class="col-md-8">
									<p style="font-family:Calibri,Arial,Helvetica;font-weight:bold;">
										Najbrži način za naručivanje <em>energetskih certifikata.</em>
										<span style="float:left;">Obavite sve na jednom mjestu u samo 4 koraka</span>
									</p>
								</div>
							</div>
						</div>
					</div>
					
					
					<div class="home-concept">
						<div class="container">

							<div class="row center">
								<span class="sun"></span>
								<span class="cloud" style="top: 47.82666666666667px;"></span>
								<div class="col-md-2 col-md-offset-1">
									<div class="process-image appear-animation bounceIn appear-animation-visible" data-appear-animation="bounceIn">
										<img src="img/ic1.jpg" alt="">
										<strong>Usluga</strong>
									</div>
								</div>
								<div class="col-md-2">
									<div class="process-image appear-animation bounceIn appear-animation-visible" data-appear-animation="bounceIn" data-appear-animation-delay="200" style="-webkit-animation: 200ms;">
										<img src="img/ic2.jpg" alt="">
										<strong>Nekretnina</strong>
									</div>
								</div>
								<div class="col-md-2">
									<div class="process-image appear-animation bounceIn appear-animation-visible" data-appear-animation="bounceIn" data-appear-animation-delay="400" style="-webkit-animation: 400ms;">
										<img src="img/ic3.jpg" alt="">
										<strong>Lokacija</strong>
									</div>
								</div>
								<div class="col-md-4 col-md-offset-1">
									<div class="project-image">
										<div id="fcSlideshow" class="fc-slideshow">
											<ul class="fc-slides">
												<li style="display: none;"><a href="#"><img class="img-responsive" src="img/project.jpg"></a></li>
												<li style="display: none;"><a href="#"><img class="img-responsive" src="img/projects/project-home-2.jpg"></a></li>
												<li style="display: list-item;"><a href="#"><img class="img-responsive" src="img/projects/project-home-3.jpg"></a></li>
											</ul>
										<nav><div class="fc-left"><span></span><span></span><span></span><i class="icon icon-arrow-left"></i></div><div class="fc-right"><span></span><span></span><span></span><i class="icon icon-arrow-right"></i></div></nav><div class="fc-flip" style="display: none; transition: none; -webkit-transition: none; -webkit-transform: none;"><div class="fc-front"><div><a href="portfolio-single-project.html"><img class="img-responsive" src="img/projects/project-home-2.jpg"></a></div><div class="fc-overlay-light" style="transition: opacity 538.4615384615385ms; -webkit-transition: opacity 538.4615384615385ms; opacity: 1;"></div></div><div class="fc-back" style="-webkit-transform: rotate3d(1, 1, 0, 180deg);"><div><a href="portfolio-single-project.html"><img class="img-responsive" src="img/projects/project-home-3.jpg"></a></div><div class="fc-overlay-dark" style="transition: opacity 538.4615384615385ms; -webkit-transition: opacity 538.4615384615385ms; opacity: 0;"></div></div></div></div>
										<strong class="our-work">Izaberi ponudu</strong>
									</div>
								</div>
							</div>

						</div>
					</div>
				
					<div class="container">
						<div class="row center upF" style="margin-top:40px;">
							<div class="col-md-12">
								<h2 class="short word-rotator-title" style="font-family:Calibri,Arial,Helvetica;">
									<strong>Besplatno</strong> naručite uslugu kod
									<strong class="inverted">
										<span class="word-rotate active">
											<span class="word-rotate-items">
												<span>provjerenih</span>
												<span>pouzdanih</span>
												<span>povoljnih</span>
										</span>
									</strong>
									Certifikatora.
								</h2>
								<p class="featured lead">
									Bez banaka, kredita, posrednika, čekanja u redovima.<br />
									Platite uslugu certifikatora po odabranoj cijeni !!! <br />
									Nagradite se odlaskom na kavu ili u kupovinu :) <br />
									Sve ostalo prepustite nama. <br />								
								</p>
							</div>
						</div>					
					</div>
					
					<!--
					<div class="container" style="margin-top:50px;">
					
						<div class="col-md-12">
							<div class="owl-carousel" data-plugin-options='{"items": 5, "singleItem": false, "autoPlay": true}'>
								<div>
									<img class="img-responsive" src="img/logos/logo-1.png" alt="">
								</div>
								<div>
									<img class="img-responsive" src="img/logos/logo-2.png" alt="">
								</div>
								<div>
									<img class="img-responsive" src="img/logos/logo-3.png" alt="">
								</div>
								<div>
									<img class="img-responsive" src="img/logos/logo-4.png" alt="">
								</div>
								<div>
									<img class="img-responsive" src="img/logos/logo-5.png" alt="">
								</div>
								<div>
									<img class="img-responsive" src="img/logos/logo-6.png" alt="">
								</div>
								<div>
									<img class="img-responsive" src="img/logos/logo-5.png" alt="">
								</div>
								<div>
									<img class="img-responsive" src="img/logos/logo-4.png" alt="">
								</div>
								<div>
									<img class="img-responsive" src="img/logos/logo-3.png" alt="">
								</div>
								<div>
									<img class="img-responsive" src="img/logos/logo-2.png" alt="">
								</div>
								<div>
									<img class="img-responsive" src="img/logos/logo-1.png" alt="">
								</div>
								<div>
									<img class="img-responsive" src="img/logos/logo-6.png" alt="">
								</div>
							</div>
						</div>	
					
					</div>
					-->
				
					<div class="modal fade" id="ponuda">
					  <div class="container">
						<div class="modal-content">
						  <div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							<h4 class="modal-title">Modal <span> title</span></h4>
						  </div>
						  <div class="modal-body">
							
							<div class="row">
								<div class="col-md-4" style="text-align:center;">
									<div class="owl-carousel  owl-theme owl-carousel-init" data-plugin-options="{&quot;items&quot;: 1, &quot;transitionStyle&quot;: &quot;fade&quot;}" style="display: block; opacity: 1;">
										<div class="owl-wrapper-outer">
											<div class="owl-wrapper" style="width: 1440px; left: 0px; display: block;">
												<div class="owl-item" style="width: 360px;">
													<div>
														<div class="thumbnail">
															<img alt="" height="300" class="img-responsive" src="http://www.hep.hr/hep/novosti/img/HEP_Opskrba.jpg">
														</div>
													</div>
												</div>
											</div>
										</div>										
									</div>
									
									<label>Ocijena pružatelja</label><br />
									<img src="img/stars.png" style="max-width:60%;margin-bottom:40px;" />
									<div style="text-align:justify;">

										<h2 class="shorter"><strong>HEP</strong> opskrba d.o.o.</h2>
										<h4>Hrvatska Elektroprivreda</h4>
										
										<h3 style="width:100%;padding:20px 0;text-align:center;border:1px solid #d3d3d3;margin-bottom:20px;color:green;">
										
												3140.27 HRK
											
										</h3>
									</div>						
								</div>
								
								<div class="col-md-8">
									<h3>UNOS PODATAKA ZA DOBIVANJE KUPONA</h3>
									<form id="contactForm" action="contact-us-advanced.php#contact-sent" method="POST" enctype="multipart/form-data" novalidate="novalidate">
										<input type="hidden" value="true" name="emailSent" id="emailSent">
										<div class="row">
											<div class="form-group">
												<div class="col-md-4">
													<label>Vaš OIB</label>
													<input type="text" placeholder="12345678901" value="" data-msg-required="Molimo Vas da upišite svoj OIB." maxlength="11" class="form-control" name="oib" id="oib">
												</div>
												<div class="col-md-4">
													<label>Vaše ime</label>
													<input type="text" placeholder="Ivan" value="" data-msg-required="Molimo Vas da upišite svoje ime." maxlength="50" class="form-control" name="ime" id="ime">
												</div>
												<div class="col-md-4">
													<label>Vaše prezime</label>
													<input type="text" placeholder="Horvat" value="" data-msg-required="Molimo Vas da upišete svoje prezime." maxlength="50" class="form-control" name="prezime" id="prezime">
												</div>
											</div>
										</div>
										<div class="row">
											<div class="form-group">
												<div class="col-md-4">
													<label>Ulica</label>
													<input type="text" value="" placeholder="Avenija Dubrovnik"  maxlength="150" class="form-control" name="ulica" id="ulica">
												</div>
												<div class="col-md-2">
													<label>Kućni broj</label>
													<input type="text" value="" placeholder="3 A" maxlength="10" class="form-control" name="kbroj" id="kbroj">
												</div>
												<div class="col-md-3">
													<label>Županija</label>
													<select class="form-control regions" name="zupanija"></select>
												</div>
												<div class="col-md-3">
													<label>Grad</label>
													<select class="form-control city" name="grad"><option value="0">Grad</option></select>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="form-group">
												<div class="col-md-4">
													<label>Vaša e-mail adresa</label>
													<input type="text" value="" class="form-control" placeholder="demo@email.com" name="email" id="email">
												</div>
												<div class="col-md-4">
													<label>Ponovite vašu e-mail adresu</label>
													<input type="text" value="" class="form-control" placeholder="demo@email.com" name="email" id="email">
												</div>
												<div class="col-md-4">
													<label>Kontakt mob/tel</label>
													<input type="text" value="" maxlength="50" class="form-control" placeholder="01 1234 567" name="kontaktm" id="kontaktm">
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-4">
												<label>Kontaktirajte me putem : </label>
												<br />
												<label class="checkbox-inline">
													<input type="checkbox" name="checkboxes[]" id="nKon" value="1"> mobitela
												</label>
												<br />
												<label class="checkbox-inline">
													<input type="checkbox" name="checkboxes[]" id="nKon" value="2"> email adrese
												</label>
											</div>
											<div class="col-md-4">
												<label>Kontaktirajte me u terminu : </label>
												<br />
												<label class="checkbox-inline">
													<input type="radio" name="checkboxes[]" id="termin" value="1"> 08:00 - 12:00
												</label>
												<br />
												<label class="checkbox-inline">
													<input type="radio" name="checkboxes[]" id="termin" value="2"> 12:00 - 14:00
												</label>
												<br />
												<label class="checkbox-inline">
													<input type="radio" name="checkboxes[]" id="termin" value="3"> 14:00 - 16:00
												</label>
												<br />
												<label class="checkbox-inline">
													<input type="radio" name="checkboxes[]" id="termin" value="3"> 16:00 - 20:00
												</label>
											</div>
										</div>
										<div class="modal-footer" style="border-top:0px;">
											<button type="button" class="btn btn-default" data-dismiss="modal">Zatvori</button>
											<button type="button" class="btn btn-success disabled takeSer">Naruči kupon</button>
											<span>* Dostupno od 17.03.2014.</span>
										</div>
									</form>
								</div>
								<p class="clear"></p>
								<div class="col-md-12">
										
										<hr style="width:100%;" />										
									
										<p>
											Hrvatska elektroprivreda (HEP grupa) je nacionalna elektroenergetska tvrtka, koja se više od jednog stoljeća bavi proizvodnjom, prijenosom i distribucijom električne energije, a u posljednjih nekoliko desetljeća i opskrbom kupaca toplinom i distribucijom plina.
											Hrvatska elektroprivreda organizirana je u obliku koncerna kao grupacija povezanih društava (tvrtke kćerke). 
											Vladajuće društvo (matica) HEP grupe je HEP d.d., koje obavlja funkciju korporativnog upravljanja HEP grupom i jamči uvjete za sigurnu i pouzdanu opskrbu kupaca električnom energijom.
											Unutar HEP grupe jasno su odvojena (upravljački, računovodstveno i pravno) društva koja obavljaju regulirane djelatnosti (prijenos i distribucija) od nereguliranih djelatnosti (proizvodnja i opskrba).
											Početkom srpnja 2013. provedene su statusne promjene HEP Operatora prijenosnog sustava (sada: Hrvatski operator prijenosnog sustava d.o.o., skraćeno HOPS d.o.o.) radi razdvajanja prema ITO modelu u skladu sa Zakonom o tržištu električne energije i odlukom Skupštine HEP-a d.d. o odabiru modela „neovisnog operatora prijenosa“ 
										</p>

										<ul class="list icons list-unstyled">
											<li><i class="icon icon-check"></i> Pristupačna cijena.</li>
											<li><i class="icon icon-check"></i> Brza dostava.</li>
											<li><i class="icon icon-check"></i> Iznadprosječna kvaliteta.</li>
										</ul>

									
									
								</div>
							</div>
							</div>
						  <p class="clear"></p>						  
						</div><!-- /.modal-content -->
					  </div><!-- /.modal-dialog -->
					</div><!-- /.modal -->
					
				</div>
			</div>
<?php
	include 'footer.php';
?>
