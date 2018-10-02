<?php
	$title = 'Korisnički račun';
	include 'header.php';
	
	if(!$fgmembersite->CheckLogin()) {
		$fgmembersite->RedirectToURL("index.php");
	}
	else if($fgmembersite->getMembershipType() != 'member') $fgmembersite->RedirectToURL("index.php");
	$member = $fgmembersite->getMember($_SESSION['id']);
	if ($_SERVER['REQUEST_METHOD'] === 'POST') {	
		if($_POST['type']==='config'){
			if(!isset($_POST['con1'])) $con1 = 'N' ;
			else $con1 = 'Y';		
			if(!isset($_POST['con2'])) $con2 = 'N' ;
			else $con2 = 'Y';		
			if(!isset($_POST['con3'])) $con3 = 'N' ;
			else $con3 = 'Y';		
			if(!isset($_POST['con4'])) $con4 = 'N' ;
			else $con4 = 'Y';
			$fgmembersite->saveMemberTC($con1, $con2, $con3, $con4, $_SESSION['id']);
			
			if(isset($_POST['sPrice'])){
				$savePrice = $_POST['sPrice'];
				$savePriceC = $_POST['sPriceCheck'];				
				foreach($savePrice as $key => $price){ if(!isset($savePriceC[$key])) $savePriceC[$key]='off';}
				$save = $fgmembersite->saveServicesPrice($savePrice, $savePriceC, $_SESSION['id']);
			}
			$fgmembersite->RedirectToURL("account_member.php?step=service_config");
		} else if($_POST['type']==='locations'){		
			if($_POST['zupanija']>0){
				$state = $_POST['zupanija'];
				$fgmembersite->registerMemberLocationsClear($member[0]['id']);
				$save1 = $fgmembersite->registerMemberLocations($member[0]['id'], $state);
			} else {
				$fgmembersite->registerMemberLocationsClear($member[0]['id']);
			}
			$fgmembersite->RedirectToURL("account_member.php?step=locations");
		} else if($_POST['type']==='services'){
			$services = $_POST['services'];				
			$fgmembersite->registerMemberServicesClear($member[0]['id']);
			if($services>0) $save = $fgmembersite->regigisterMemberAddServices($_SESSION['id'], $member[0]['id'], $services);
			$fgmembersite->RedirectToURL("account_member.php?step=service_config");
		} else if($_POST['type']==='account_settings'){		
			$street = $_POST['ulica'];
			$mob = $_POST['kontaktm'];
			$email = $_POST['email'];
			$rez = $fgmembersite->saveMemberAccountF($member[0]['id'], $mob, $email, $street);
			$fgmembersite->RedirectToURL("account_member.php");
		} else if($_POST['type']==='activate'){
			$active = $_POST['active'];
			if(isset($active)){
				$fgmembersite->registerMemberActiveTurnO($member[0]['id'], $active);
			}
		}

	}
	
	$con = $fgmembersite->getCon();
?>
			<div role="main" class="main">
				<div id="content" class="account_member">

					<div class="home-intro light">
						<div class="container">

							<div class="row">
								<div class="col-md-8">
									<p style="font-family:Calibri,Arial,Helvetica;">
										Uredite postavke u sovm <em>korisničkom računu</em> ?
										<span>Usluge, lokacije rada i osobne informacije.</span>
									</p>
								</div>
							</div>

						</div>
					</div>
					
					<div class="container">

					<div class="row" style="margin-top:40px;">
						<div class="col-md-3" style="margin-bottom:40px;">						
							<div class="panel-group" id="accordion">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle collapsed" href="<?=$site_url;?>account_member.php">
												<i class="icon icon-comment"></i>
												Korisnički podaci
											</a>
										</h4>
									</div>
								</div>
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle collapsed" href="<?=$site_url;?>account_member.php?step=services">
												<i class="icon icon-pencil-square-o"></i>
												Izbor usluga
											</a>
										</h4>
									</div>
								</div>
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle collapsed" href="<?=$site_url;?>account_member.php?step=service_config">
												<i class="icon  icon-gear"></i>
												Postavke izabranih usluga
											</a>
										</h4>
									</div>
								</div>
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle collapsed" href="<?=$site_url;?>account_member.php?step=locations">
												<i class="icon icon-map-marker"></i>
												Lokacije gdje pružam usluge
											</a>
										</h4>
									</div>
								</div>
								<!--
								<div class="panel panel-default" style="margin-bottom:50px;">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle collapsed" href="<?=$site_url;?>account_member.php?step=profile">
												<i class="icon icon-laptop"></i>
												Moj javni profil
											</a>
										</h4>
									</div>
								</div>
								-->
								<form action="account_member.php" method="post">
									<input type="hidden" name="type" value="activate"/>
									<?
									$a = $fgmembersite->checkActivationMember($member[0]['id']);
									if($a===1) echo '<input type="hidden" name="active" value="Y"/><button type="submit" style="margin-top:30px;width:100%;padding:12px 0;" class="btn btn-success pull-right push-bottom"><i class="icon icon-play"></i> Aktiviraj ponude</button>';
									else if ($a===2) echo '<a href="#" style="margin-top:30px;width:100%;padding:12px 0;" class="btn btn-success pull-right push-bottom disabled"><i class="icon icon-play"></i> Aktiviraj ponude</a>';
									else if ($a===3) echo '<input type="hidden" name="active" value="N"/><button type="submit" style="margin-top:30px;width:100%;padding:12px 0;" class="btn btn-danger pull-right push-bottom"><i class="icon icon-power-off"></i> Deaktiviraj ponude</button>';
									?>
								</form>	
									
							</div>						
						</div>
						
						
						<? if (!isset($_GET['step'])){ ?>
						<div class="col-md-9 services">
							<? if($save === true){
								echo '<div class="alert alert-success"><strong>Uspješno</strong> ste spremili svoje postavke.</div>';
							} ?>
							<div class="featured-box featured-box-secundary default info-content" style="margin-top:0;">
								<div class="box-content">
									<form action="account_member.php" method="post">
										<input type="hidden" name="type" value="account_settings" />
										<h1 style="text-align:right;font-family:'Source Sans Pro', sans-serif;">
											<?
												echo $fgmembersite->getFullName('member', $_SESSION['id']);
											?>
										</h1>
										<hr />
										<div class="row">
											<div class="form-group">												
												<div class="col-md-4">
													<label>Vaš OIB</label>
													<input type="number" placeholder="12345678901" disabled value="<?=$member[0]['oib'];?>" data-msg-required="Molimo Vas da upišite svoj OIB." class="form-control validate numberO"  id="oib">
												</div>
												<div class="col-md-4">
													<label>Naziv osobe/tvrtke</label>
													<input type="text" placeholder="Upišite naziv" disabled value="<?=$member[0]['name'];?>" data-msg-required="Molimo Vas da upišite svoje ime." maxlength="128" class="form-control validate lettO" id="naziv">
												</div>
												<div class="col-md-4">
													<label>Broj ovlaštenja Ministarstva</label>
													<input type="text" disabled value="<?=$member[0]['apt_no'];?>" class="form-control validate" maxlength="9" placeholder="X-Y/YYYY" id="licenca">
												</div>
											</div>
										</div>
										<div class="row">
											<div class="form-group">
												<div class="col-md-6">
													<label>Adresa</label>
													<input type="text" value="<?=$member[0]['street'];?>" placeholder="Unesite adresu"  maxlength="150" class="form-control validate combO" name="ulica" id="ulica">
												</div>
												<div class="col-md-6">
													<label>Kontakt mobitel</label>
													<input type="text" value="<?=$member[0]['mob'];?>" maxlength="20" class="form-control validate mobO" placeholder="01 1234 567" name="kontaktm" id="kontaktm">
												</div>		
											</div>
										</div>
										<div class="row">
											<div class="form-group">
												<div class="col-md-6">
													<label>Vaša e-mail adresa</label>
													<input type="email" value="<?=$member[0]['email'];?>" class="form-control validate emailO1" placeholder="demo@email.com" name="email1" id="email1">
												</div>
												<div class="col-md-6">
													<label>Ponovite vašu e-mail adresu</label>
													<input type="email"value="<?=$member[0]['email'];?>" class="form-control validate emailO" placeholder="demo@email.com" name="email" id="email">
												</div>							
											</div>
										</div>
										<hr />
										<div class="modal-footer" style="border-top:0px;">
											<button type="submit"class="btn btn-success takeSer" >Spremite podatke</button>
										</div>										
									</form>
								</div>
							</div>					
						</div>
						<? } else if($_GET['step']==='service_config') { ?>
						<div class="col-md-9 services">
							<? if($save === true){
								echo '<div class="alert alert-success"><strong>Uspješno</strong> ste spremili svoje postavke.</div>';
							} ?>
							<div class="featured-box featured-box-secundary default info-content" style="margin-top:0;">
								<div class="box-content">
									<form action="account_member.php" method="post">
										<input type="hidden" name="type" value="config" />
										<h1 style="text-align:left;">Moje usluge</h1>
										<p>
											
											<?
												$rez = $fgmembersite->getServiceClass($member[0]['id']);												
											?>
											
										</p>
										<?
											if($rez!==0){
										?>
										<hr />
										<div class="col-md-12" style="text-align:left;">
											<label><input type="checkbox" class="conAll <? if($con[0][0]==='Y') echo 'disClick'; ?>" name="con1" <? if($con[0][0]==='Y') echo 'checked'; ?> id="tnc"/> Prihvaćam <a href="#uKoristenja" data-toggle="modal" data-target="#uKoristenja">uvjete korištenja</a></label><br />
											<label><input type="checkbox" class="conAll <? if($con[0][1]==='Y') echo 'disClick'; ?>" name="con2" <? if($con[0][1]==='Y') echo 'checked'; ?> id="ug"/> Prihvaćam <a href="#ugovor"  data-toggle="modal" data-target="#ugovor">uvjete i odredbe ugovora</a></label><br />
											<label><input type="checkbox" class="conAll <? if($con[0][2]==='Y') echo 'disClick'; ?>" name="con3" <? if($con[0][2]==='Y') echo 'checked'; ?> id="iii1"/> Potvrđujem da su iskazane informacije istinite</label><br />
											<label><input type="checkbox" class="conAll <? if($con[0][3]==='Y') echo 'disClick'; ?>" name="con4" <? if($con[0][3]==='Y') echo 'checked'; ?> id="iii2"/> Potvrđujem dostupnost navedenih usluga po postavljenim uvjetima</label><br />
											<small>
												* u trenutku kada prihvatite naše uvijete korištenja, bit ćete u mogućnosti aktivirati svoj korisnički račun
											</small>
										</div>
										<div class="col-md-12 footer_1sub">
												<div class="alert alert-info col-md-8" style="margin-top:15px;padding:5px;">
													<i class="icon icon-warning"></i> <strong> Pažnja!</strong> Potvrdite izmjene pritiskom na tipku "Spremi postavke"
												</div>
											<input type="submit" style="margin-top:15px;" class="btn btn-success pull-right push-bottom saveServicesAll disabled col-md-3" value="Spremi postavke" />
										</div>
										<? } ?>
										<p class="clear"></p>
									</form>
								</div>
							</div>					
						</div>
						<? } else if($_GET['step']==='profile') { ?>
						<div class="col-md-9 profile">
						<? if($save === true){
								echo '<div class="alert alert-success"><strong>Uspješno</strong> ste spremili svoje postavke.</div>';
							} ?>
							<div class="featured-box featured-box-secundary default info-content" style="margin-top:0;">
								<div class="box-content">
									<h4>Uredi profil</h4>
									<p>
										
									</p>
									<h3>Usluga još nije dostupna.</h3>
									<p class="clear"></p>
								</div>
							</div>
						</div>				
						<? }  else if($_GET['step']==='services') { ?>
						<div class="col-md-9 profile">
						<? if($save1 === true){
								echo '<div class="alert alert-success"><strong>Uspješno</strong> ste spremili svoje postavke.</div>';
							} ?>
							<div class="featured-box featured-box-secundary default info-content" style="margin-top:0;">
								<form action="account_member.php" method="post">
									<input type="hidden" name="type" value="services" />
									<div class="box-content">
										<h3 class="col-md-12" style="margin:20px 0 40px;">Izaberite usluge koje obavljate</h3>
												<div class="form-group">		
													<select class="form-control validate multipleCh" id="services" name="services[]" multiple='multiple'>
															<? $fgmembersite->listMemberServices(); ?>
													</select>
												</div>
										<div class="col-md-12">
												<div class="alert alert-info col-md-9" style="padding:5px;">
													<i class="icon icon-warning"></i> <strong> Pažnja!</strong> Potvrdite izmjenu usluga pritiskom na tipku "Spremi usluge"
												</div>
												<input type="submit" style="margin-top:00px;" class="btn btn-success pull-right push-bottom col-md-2" value="Spremi usluge" />
										</div>
										<p class="clear"></p>
									</div>
								</form>
							</div>
						</div>
						<? }  else if($_GET['step']==='locations') { ?>
						<div class="col-md-9 profile">
						<? if($save2 === true){
								echo '<div class="alert alert-success"><strong>Uspješno</strong> ste spremili svoje postavke.</div>';
							} ?>
							<div class="featured-box featured-box-secundary default info-content" style="margin-top:0;">
								<form action="account_member.php" method="post">
									<input type="hidden" name="type" value="locations" />
									<div class="box-content">
										<h3 class="col-md-12" style="margin:20px 0 40px;">Odaberite područje rada</h3>
												<div class="form-group">									
													<select class="form-control validate multipleCh" id="zupanija" name="zupanija[]" multiple='multiple'>
															<? $fgmembersite->listLocMultSelected(); ?>
													</select>
												</div>
											<div class="col-md-12">
												<div class="alert alert-info col-md-9" style="padding:5px;">
													<i class="icon icon-warning"></i> <strong> Pažnja!</strong> Potvrdite izmjenu gradova pritiskom na tipku "Spremi lokacije"
												</div>
												<input type="submit" style="margin-top:0px;" class="btn btn-success pull-right push-bottom col-md-2" value="Spremi lokacije" />
											</div>
										<p class="clear"></p>
									</div>
								</form>
							</div>
						</div>
						<? }  ?>
					</div>
				</div>
				<link rel="stylesheet" href="css/mselect.css">
						<script src="vendor/jquery.js"></script>
						<script src="js/multiselect.js"></script>
						<script src="js/quickSearch.js"></script>
						<script src="js/account_member.js"></script>
						<script type="text/javascript">
								$('#services').multiSelect({ 		
									selectableOptgroup: true,
									selectableHeader: '<p class="col-md-12"><strong>Izbor usluga</strong></p>',
									selectionHeader: '<p class="col-md-12"><strong>Izabrane usluge</strong></p>'
								});
								$('#zupanija').multiSelect({ 													
													selectableOptgroup: true ,
													selectableHeader: "<input type='text' class='search-input form-control' autocomplete='off' placeholder='Pretraga županija/gradova' style='margin-bottom:5px'>",
													selectionHeader: "<input type='text' class='search-input form-control' autocomplete='off' placeholder='Odabrani gradovi' style='margin-bottom:5px'>",
													afterInit: function(ms){
													var that = this,
														$selectableSearch = that.$selectableUl.prev(),
														$selectionSearch = that.$selectionUl.prev(),
														selectableSearchString = '#'+that.$container.attr('id')+' .ms-elem-selectable:not(.ms-selected)',
														selectionSearchString = '#'+that.$container.attr('id')+' .ms-elem-selection.ms-selected';

													that.qs1 = $selectableSearch.quicksearch(selectableSearchString)
													.on('keydown', function(e){
													  if (e.which === 40){
														that.$selectableUl.focus();
														return false;
													  }
													});

													that.qs2 = $selectionSearch.quicksearch(selectionSearchString)
													.on('keydown', function(e){
													  if (e.which == 40){
														that.$selectionUl.focus();
														return false;
													  }
													});
												  }

											});
						</script>
						<div class="container">			
							<div class="modal fade" id="uKoristenja" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							  <div class="modal-dialog" style="width:100%;max-width:1024px;">
								<div class="modal-content">
								  <div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
									<h4 class="modal-title">Uvijeti korištenja</h4>
								  </div>
								  <div class="modal-body">
										<p>Enzo.hr internet stranice mogu se koristiti za Va&scaron;u privatnu upotrebu bez ikakvih naknada&nbsp;</p>

										<p>za kori&scaron;tenje, a prema navedenim uvjetima i pravilima. Kori&scaron;tenjem enzo.hr smatra se da&nbsp;</p>

										<p>je korisnik u cijelosti pročitao, razumio i prihvatio navedene Uvjete kori&scaron;tenja i Izjavu o&nbsp;</p>

										<p>privatnosti osobnih podataka.&nbsp;</p>

										<p>&nbsp;</p>

										<p>Naručivanje</p>

										<p>Kupon se naručuje elektronskim putem. Pojedine proizvode ugovarate prema pravilima i&nbsp;</p>

										<p>uvjetima koje je definirao pružaoc usluge.</p>

										<p>&nbsp;</p>

										<p>Plaćanje</p>

										<p>Enzo.hr je u potpunosti besplatan. Odabrana usluga se plaća direktno pružaocu usluge&nbsp;</p>

										<p>prema odredbama ugovora koje korisnik potpisuje sa pružaocem i pravilima pružanja&nbsp;</p>

										<p>odabranih usluga u Republici Hrvatskoj. Enzo.hr i Enzo Capital LTD ne snose odgovornost za&nbsp;</p>

										<p>plaćanje niti naplatu pruženih usluga.w</p>

										<p>&nbsp;</p>

										<p>Reklamacije</p>

										<p>Ukoliko niste zadovoljni uslugom slobodno nas kontaktirajte na info@enzo.hr . Va&scaron;u&nbsp;</p>

										<p>reklamaciju ćemo po primitku proslijediti odgovarajućem resornom ministarstvu o čemu&nbsp;</p>

										<p>ćete biti obavije&scaron;teni.</p>

										<p>&nbsp;</p>

										<p>Dostava</p>

										<p>Nakon &scaron;to se izvr&scaron;i naručivanje kupona za odabranu uslugu primit ćete e-mail s potvrdom&nbsp;</p>

										<p>o provedenoj transakciji., te u rkou od 24h e-mail da li je odabrani pružatelj prihvatio&nbsp;</p>

										<p>naručenu uslugu sa svim potrebnim podacima kao i Uvjetima pružanja iste.</p>

										<p>&nbsp;</p>

										<p>Elektronska komunikacija</p>

										<p>Posjećivanjem stranica enzo.hr komunicirate elektronskim putem. Time prihvaćate da svi&nbsp;</p>

										<p>sporazumi, obavijesti, priopćenja i ostali sadržaji koji su vam dostavljeni elektronskim putem&nbsp;</p>

										<p>zadovoljavaju pravne okvire kao da su ostvareni u pisanom obliku.</p>

										<p>&nbsp;</p>

										<p>Vanjske usluge</p>

										<p>Usluge koje Vam pruža enzo.hr ne uključuje tro&scaron;kove koje snosite koristeći računalnu&nbsp;</p>

										<p>opremu i usluge za pristup na&scaron;im stranicama. Vlasnici enzo.hr i pridružene strane nisu</p>

										<p>odgovorne za tro&scaron;kove telefona ili bilo koje druge tro&scaron;kove do kojih može doći.</p>

										<p>&nbsp;</p>

										<p>Intelektualno vlasni&scaron;tvo</p>

										<p>Sadržaj enzo.hr stranica je za&scaron;tićen i Enzo Capital LTD ostvaruje jedinstveno pravo na&nbsp;</p>

										<p>njegovo kori&scaron;tenje.</p>

										<p>&nbsp;</p>

										<p>Prikupljanje i kori&scaron;tenje osobnih podataka</p>

										<p>Također, kori&scaron;tenjem internetske stranice enzo.hr, korisnici daju svoju suglasnost da im&nbsp;</p>

										<p>Ezno Capital LTD povremeno &scaron;alje informacije o uslugama. Korisnici nas mogu obavijestiti&nbsp;</p>

										<p>ako ne žele primati daljnje informacije na adresu remove@enzo.hr .</p>

										<p>Enzo.hr se obavezuje pružati za&scaron;titu osobnim podacima kupaca, na način da prikuplja&nbsp;</p>

										<p>podatke o korisnicima koji su potrebni za ispunjenje obveza; redovito daje kupcima&nbsp;</p>

										<p>mogućnost izbora o upotrebi njihovih podataka, uključujući mogućnost odluke žele li ili ne&nbsp;</p>

										<p>da se njihovo ime ukloni s lista koje se koriste za osobne ili druge marketin&scaron;ke tj. aktivnosti&nbsp;</p>

										<p>obrade trži&scaron;ta. Podaci o korisnicima koji su za&scaron;tićeni zakonima Republike Hrvatske se strogo&nbsp;</p>

										<p>čuvaju i dostupni su samo djelatnicima kojima su ti podaci nužni za obavljanje posla.</p>

									</div>
								  <div class="modal-footer">
									<button type="button" class="btn btn-default" data-dismiss="modal">U redu</button>
								  </div>
								</div><!-- /.modal-content -->
							  </div><!-- /.modal-dialog -->
							</div><!-- /.modal -->
						</div>
						
						<div class="modal fade" id="ugovor" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						  <div class="modal-dialog" style="width:100%;max-width:1024px;">
							<div class="modal-content">
							  <div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">Ugovor o poslovnoj suradnji ENZO CAPITAL LTD</h4>
							  </div>
							  <div class="modal-body">
								<p>.................................. (naziv tvrtke), ........... (sjedi&scaron;te, adresa).............., koju zastupa direktor __________</p>

								<p>(dalje u tekstu: Tvrtka)</p>

								<p>i</p>

								<p>....................................................... (naziv fizičke osobe ili pravne osobe certifikatora) kojeg zastupa (ako&nbsp;</p>

								<p>je pravna osoba, ili samo podaci o fizičkoj osobi).................................(dalje u tekstu: ...........Certifikator)</p>

								<p>(dalje u tekstu zajedno: Ugovorne strane)</p>

								<p>sklopili su u Zagrebu dana ................2014. godine&nbsp;</p>

								<p>UGOVOR O POSLOVNOJ SURADNJI</p>

								<p>Ugovorne strane sklapaju ovaj ugovor o poslovnoj suradnji (dalje u tekstu: Ugovor), na način kako slijedi:</p>

								<p>Svrha i predmet Ugovora</p>

								<p>Članak 1.</p>

								<p>1.1. Ugovorne strane, sklapaju ovaj Ugovor kojim reguliraju međusobna prava i obveze u odnosu&nbsp;</p>

								<p>na uspostavu poslovne suradnje vezane za Certifikatorovo pružanje usluga energetskog pregleda i&nbsp;</p>

								<p>certificiranja nekretnina u Republici Hrvatskoj putem Interneta (dalje u tekstu: Usluga), i gdje Tvrtka pruža&nbsp;</p>

								<p>usluge on-line prezentacije usluga Certifikatora prema krajnjem korisniku.</p>

								<p>1.2. Ovaj Ugovor uređuje okvirnu međusobnu poslovnu suradnju Ugovornih strana, te naknadno po&nbsp;</p>

								<p>potpisu ovog Ugovora, Ugovorne strane, u svakom trenutku, mogu pristupiti pregovorima koji mogu&nbsp;</p>

								<p>rezultirati sklapanjem aneksa ovom ugovoru ili sklapanjem novog ugovora u kojem će se međusobna&nbsp;</p>

								<p>prava i obveze Ugovornih strana detaljnije urediti.</p>

								<p>1.3. Ovaj Ugovor zamjenjuje sve prethodne usmene ili pisane dogovore između Ugovornih strana u&nbsp;</p>

								<p>pogledu sadržaja koji je uređen ovim Ugovorom.</p>

								<p>Prava, obveze, jamstva i odgovornosti Certifikatora</p>

								<p>Članak 2.</p>

								<p>2.1. Certifikator jamči da je ovla&scaron;teni, registrirani i licencirani fizički ili pravni subjekt koji vr&scaron;i usluge&nbsp;</p>

								<p>energetskog certificiranja nekretnina u Republici Hrvatskoj i koji ima potrebne i važeće dozvole te stručna&nbsp;</p>

								<p>znanja i osoblje za pružanje navedenih usluga. Certifikator se obvezuje i jamči da će pružati Usluge&nbsp;</p>

								<p>sukladno važećim propisima Republike Hrvatske, pravilima i standardima struke i prema odredbama ovog&nbsp;</p>

								<p>Ugovora. Certifikator jamči da ima sva potrebna odobrenja i valjane licence za nuđenje Usluga krajnjim&nbsp;</p>

								<p>korisnicima. Certifikator se u tom smislu obvezuje da će pružati Usluge pravovremeno i kvalitetno u skladu&nbsp;</p>

								<p>sa uvjetima pružanja usluga energetskog pregleda i certificiranja nekretnina u Republici Hrvatskoj, kao i&nbsp;</p>

								<p>cijenom usluga koje je Certifikator odredio i potvrdio na on-line prezentaciji usluga Certifikatora.</p>

								<p>2.2. Certifikator se obvezuje redovito održavati svoj elektronski korisnički račun registriran kod Tvrtke,&nbsp;</p>

								<p>kao i jednom mjesečno dostavljati Tvrtki pisana izvje&scaron;ća o pruženim Uslugama, odnosno po posebnom&nbsp;</p>

								<p>zahtjevu Tvrtke, elektronski dostavljati pisano izvje&scaron;će o pruženim Uslugama. Obračun realiziranih usluga&nbsp;</p>

								<p>Certifikatora vr&scaron;iti će se elektronskim putem i automatski, na temelju čega će se Tvrtki isplaćivati naknada&nbsp;</p>

								<p>za pružene usluge temeljem ovog Ugovora, na način kako je to detaljnije uređeno u stavku 2.4. ovog&nbsp;</p>

								<p>članka.</p>

								<p>2.3. Ugovorne strane su ovdje posebno suglasne da Certifikator nije ekskluzivni pružatelj Usluga te&nbsp;</p>

								<p>da Tvrtka ima svakodobno pravo, pored Certifikatora angažirati i prezentirati on-line usluge i drugog&nbsp;</p>

								<p>pružatelja sličnih usluga..&nbsp;</p>

								<p>2.4. Certifikator se obvezuje platiti Tvrtki naknadu za on-line prezentaciju Usluga putem Interneta. Ova&nbsp;</p>

								<p>naknada (dalje u tekstu: Naknada) se sastoji od dva dijela:</p>

								<p>&bull; prvi dio mjesečne Naknade, = pau&scaron;alna, nepovratna i fiksna mjesečna naknada (bez obzira&nbsp;</p>

								<p>na realizirane Usluge Certifikatora) u iznosu od ____,00 HRK (dalje u tekstu: Fiksna naknada).&nbsp;</p>

								<p>Fiksna naknada se isplaćuje Tvrtki svaki mjesec u navedenom iznosu kao fiksna naknada za on-<br />
								line prezentaciju Usluga Certifikatora prema krajnjem korisniku, bez obzira je li Usluga od strane&nbsp;</p>

								<p>krajnjeg korisnika realizirana prema Certifikatoru ili nije.&nbsp;</p>

								<p>&bull; drugi dio mjesečne Naknade = varijabilna mjesečna naknada kao provizija za realiziranu&nbsp;</p>

								<p>Uslugu prema krajnjem korisniku u iznosu od ____,00 HRK po realiziranoj Usluzi prema krajnjem&nbsp;</p>

								<p>korisniku (dalje u tekstu: Varijabilna naknada)</p>

								<p>2.5. Certifikator je ovdje suglasan da se Varijabilna naknada isplaćuje Tvrtki u dva dijela i to na sljedeći&nbsp;</p>

								<p>način:</p>

								<p>&bull; prvi dio Varijabilne naknade u iznosu od ____,00 HRK po realiziranoj Usluzi prema krajnjem&nbsp;</p>

								<p>korisniku (dalje u tekstu: Prvi dio varijabilne naknade), Certifikator isplaćuje Tvrtki u onom&nbsp;</p>

								<p>trenutku kada krajnji korisnik odabere realizaciju prezentirane Usluge Certifikatora, uvažavajući&nbsp;</p>

								<p>činjenicu da će Tvrtka na svom portalu prezentirati usluge drugih fizičkih i pravnih subjekata koji&nbsp;</p>

								<p>vr&scaron;e iste ili slične usluge energetskog certificiranja nekretnina u Republici Hrvatskoj. Certifikator&nbsp;</p>

								<p>je suglasan da se Prvi dio varijabilne naknade isplaćuje izravno i direktno Tvrtki u trenutku izbora&nbsp;</p>

								<p>prezentirane Usluge od strane krajnjeg korisnika. Isplata se vr&scaron;i automatski putem aktivacije&nbsp;</p>

								<p>iznosa Prvog dijela varijabilne naknade i sa kreditne kartice Certifikatora . Ukoliko Certifikator ne&nbsp;</p>

								<p>posjeduje kreditnu karticu isplata naknade se može vr&scaron;iti naknadno redovnom uplatom od strane&nbsp;</p>

								<p>Certifikatora prema Tvrtki.</p>

								<p>&bull; drugi dio Varijabilne naknade u iznosu od ____,00 HRK po realiziranoj Usluzi prema krajnjem&nbsp;</p>

								<p>korisniku (dalje u tekstu: Drugi dio varijabilne naknade), Certifikator isplaćuje Tvrtki u onom&nbsp;</p>

								<p>trenutku ako i kada Certifikator prema krajnjem korisniku doista i izvr&scaron;i Uslugu.</p>

								<p>2.6. Certifikator se obvezuje dostaviti Tvrtki svoj OIB (bilo da je riječ o fizičkoj ili pravnoj osobi) te je&nbsp;</p>

								<p>Certifikator suglasan da se sama elektronska registracija računa Certifikatora kod Tvrtke vr&scaron;i upravo&nbsp;</p>

								<p>putem dostave navedenog OIB-a. Certifikator se obvezuje dostavljati Tvrtki i sve ostale podatke vezane uz&nbsp;</p>

								<p>njegovo redovno poslovanje i pružanje usluga navedenih certificiranja koje su potrebne Tvrtki i koje Tvrtka&nbsp;</p>

								<p>može zatražiti od Certifikatora, a potrebnih za upotpunjavanje podataka o profilu Certifikatora.</p>

								<p>2.7. Certifikator preuzima svu odgovornost za valjanu prezentaciju, realizaciju i provođenje Usluga prema&nbsp;</p>

								<p>krajnjem korisniku u skladu sa odredbama ovog Ugovora, uvjetima navedenim u prezentaciji Usluga&nbsp;</p>

								<p>izabranih od strane krajnjeg korisnika, kao i uvjetima pružanja usluga energetskog pregleda i certificiranja&nbsp;</p>

								<p>nekretnina u Republici Hrvatskoj. Certifikator preuzima svu odgovornost i za sve osobe koje moguće&nbsp;</p>

								<p>angažira kao podizvođače za pružanje dijela Usluga iz ovog Ugovora. Certifikator se obvezuje Tvrtki&nbsp;</p>

								<p>pravodobno dostaviti podatke o podizvođačima i osobama podizvođača koji će moguće pružati dio Usluga&nbsp;</p>

								<p>iz ovog Ugovora i treba ishoditi prethodnu pisanu suglasnost Tvrtke za angažman bilo kojeg podizvođača&nbsp;</p>

								<p>za moguće izvr&scaron;enje dijela Usluga iz ovog Ugovora.</p>

								<p>2.8. Certifikator se posebno obvezuje na čuvanje bilo koje poslovne tajne Tvrtke do koje je do&scaron;ao kako&nbsp;</p>

								<p>za vrijeme trajanja ovog Ugovora odnosno njegova izvr&scaron;enja, tako i prije njegova potpisivanja, osim&nbsp;</p>

								<p>ako su ove informacije javno publicirane, odnosno javno bile poznate prije njegova potpisivanja. Ovu&nbsp;</p>

								<p>obvezu Certifikator je dužan prenijeti na sve svoje zaposlenike i/ili osobe koji na bilo koji način sudjeluju&nbsp;</p>

								<p>u izvr&scaron;enju ovog Ugovora. Certifikator se u tom smislu posebno obvezuje na čuvanje svih podataka i&nbsp;</p>

								<p>informacija koje predstavljaju poslovnu tajnu Tvrtke, ali i onih informacija koje se odnose i na osobne&nbsp;</p>

								<p>podatke krajnjih korisnika.</p>

								<p>2.9. Certifikator se obvezuje dostavljati Tvrtki sve podatke vezane uz moguću promjenu statusa&nbsp;</p>

								<p>ovla&scaron;tenog i licenciranog subjekta za obavljanje Usluga.</p>

								<p>2.10. Certifikator je potpisom ovog Ugovora suglasan i prihvaća sve uvjete kori&scaron;tenja on-line prezentacije&nbsp;</p>

								<p>Usluga i svih naknadnih izmjena i dopuna istih.&nbsp;</p>

								<p>2.11. Certifikator je potpisom ovog Ugovora suglasan i prihvaća da u slučaju opoziva naloga realizacije&nbsp;</p>

								<p>Usluge ili on-line prezentacije Usluga, Tvrtka ima pravo na naknadu &scaron;tete po općim propisima Republike&nbsp;</p>

								<p>Hrvatske. U slučaju opoziva naloga u kojem je Tvrtka poduzimala radnje i ispunjavala obveze preuzete&nbsp;</p>

								<p>ovim Ugovorom, a Certifikator potajno i mimo Tvrtke i poslovne suradnje koju Ugovorne strane imaju&nbsp;</p>

								<p>temeljem ovog Ugovora, sklopi pravni posao s osobom s kojom ga je Tvrtka dovela u vezu, Tvrtki pripada&nbsp;</p>

								<p>dvostruki iznos ugovorene Naknade koja bi mu pripala temeljem ovog Ugovora.&nbsp;</p>

								<p>Prava, obveze, odgovornosti Tvrtke</p>

								<p>Članak 3.</p>

								<p>3.1. Tvrtka se obvezuje pripremiti i osigurati tehnički ispravanu i funkcionalnu on-line prezentacijuu&nbsp;</p>

								<p>sklopu koje će od strane Tvrke biti predstavljene usluge energetskog pregleda i certificiranja nekretnina u&nbsp;</p>

								<p>Republici Hrvatskoj koje vr&scaron;i Certifikator kao i drugi podaci o Certifikatoru.</p>

								<p>3.2. Tvrtka se obvezuje, da s pozorno&scaron;ću urednog i savjesnog gospodarstvenika, poduzima potrebne&nbsp;</p>

								<p>radnje da putem online prezentacije usluga Certifikatora dovodi u vezu krajnje korisnike sa&nbsp;</p>

								<p>Certifikatorom, gdje će Certifikator izvr&scaron;iti usluge energetskog pregleda i certificiranja nekretnina u&nbsp;</p>

								<p>Republici Hrvatskoj za krajnjeg korisnika.</p>

								<p>3.3. Tvrtka zadržava i ima samostalno i diskreciono pravo, da na temelju vlastite procjene, a ovisno o&nbsp;</p>

								<p>kriterijima kvalitete i ocjene zadovoljstva krajnjih korisnika, periodično revidira status Certifikatora na&nbsp;</p>

								<p>listi ovla&scaron;tenih certifikatora koji su prikazani na on-line prezentaciji te u tom smislu, Tvrtka ima pravo&nbsp;</p>

								<p>jednostrano i bez otkaznog roka raskinuti ovaj Ugovor sa Certifikatorom, u slučaju ako Certifikator ne&nbsp;</p>

								<p>pruža kvalitetnu i profesionalnu Uslugu prema krajnjem korisniku ili ne ispunjava sve uvjete pružanja ovih&nbsp;</p>

								<p>usluga u Republici Hrvatskoj ili ne ispunjava sve obveze propisane ovim Ugovorom.</p>

								<p>3.4. Tvrtka ne preuzima nikakvu odgovornost za valjano ispunjenje prezentiranih Usluga za koje je&nbsp;</p>

								<p>isključivo odgovoran Certifikator, niti preuzima bilo kakvu odgovornost za pregovore koje će Certifikator&nbsp;</p>

								<p>moguće imati i voditi sa krajnjim korisnikom u smislu sklapanja ugovora o pružanju prezentiranih Usluga.&nbsp;</p>

								<p>Tvrtka jednakotako nije odgovorna za plaćanje pružene uluge Certifikatoru od strane klijenta. U tom&nbsp;</p>

								<p>smislu, Tvrtka neće ni na koji način biti odgovorna za materijalni ili nematerijalni gubitak ili &scaron;tetu nastalu&nbsp;</p>

								<p>kori&scaron;tenjem on-line prezentacije i Usluga koje pruža Certifikator. Tvrtka ne odgovara za &scaron;tetu nastalu kao&nbsp;</p>

								<p>razlog &scaron;to se krajnji kupac oslonio na informacije dane u on-line prezentaciji .</p>

								<p>3.5. Tvrtka će ulagati razumne napore da omogući najbolji i siguran način kori&scaron;tenja Interneta, te &scaron;titi&nbsp;</p>

								<p>osobne podatke krajnjih korisnika od neovla&scaron;tenog pristupa, uporabe ili otkrivanja, sa čime je Certifikator&nbsp;</p>

								<p>potpisom ovog Ugovora posebno upoznat i gdje se Certifikator posebno obvezuje da će osobne podatke o&nbsp;</p>

								<p>krajnjim korisnicima čuvati kao poslovnu tajnu i iste neće neovla&scaron;teno otkrivati bilo kojoj trećoj strani.</p>

								<p>3.6. Tvrtka ima pravo u on-line prezentaciji navoditi sve javne informacije Certifikatoru, bez da za to traži&nbsp;</p>

								<p>posebnu suglasnost Certifikatora.</p>

								<p>3.7. Tvrtka u odnosu na Certifikatora i krajnjeg korisnika, te bilo koji treću osobu, zadržava pravo&nbsp;</p>

								<p>promjene, ukidanja (privremenog i trajnog) bilo kojeg sadržaja u on-line prezentaciji, u bilo koje vrijeme,&nbsp;</p>

								<p>bez obaveze prethodne najave. Tvrtka nije odgovorna za bilo kakvu &scaron;tetu nastalu tim promjenama.&nbsp;</p>

								<p>3.8. Tvrtka će poduzeti razumne napore kako bi informacije na portalu bile točne i precizne, ali ne daje&nbsp;</p>

								<p>nikakva jamstva u pogledu njihove točnosti ili potpunosti, te je Certifikator suglasan da Tvrtka prenosi na&nbsp;</p>

								<p>portalu sve podatke o Certifikatoru koje Tvrtka posjeduje.</p>

								<p>Trajanje ugovora</p>

								<p>Članak 4.</p>

								<p>Ovaj Ugovor se sklapa na neodređeno vrijeme.</p>

								<p>Kontakt osobe</p>

								<p>Članak 5.</p>

								<p>5.1. Ugovorne strane su suglasne da će sva otvorena pitanja u pogledu valjanog ispunjenja svih prava i&nbsp;</p>

								<p>obveza iz ovog Ugovora rje&scaron;avati pismenim putem.</p>

								<p>Prestanak Ugovora&nbsp;</p>

								<p>Članak 6.</p>

								<p>6.1. U slučaju kr&scaron;enja, odnosno neispunjenja ili zaka&scaron;njenja u ispunjenju bilo koje obveze iz ovog Ugovora&nbsp;</p>

								<p>od strane Certifikatora, Tvrtka ima, u svakom trenutku uz otkazni rok od 30 dana pravo raskinuti ovaj&nbsp;</p>

								<p>Ugovor uz dostavu pisane obavijesti o raskidu ovog Ugovora Certifikatoru.&nbsp;</p>

								<p>6.2. Prije otkazivanja ovog Ugovora, Tvrtka je dužna prethodno pisanim putem opomenuti Certifikatora&nbsp;</p>

								<p>na ispunjavanje ugovornih obveza preuzetih ovim Ugovorom, te mu ostaviti dodatni primjereni rok za&nbsp;</p>

								<p>otklanjanje nepravilnosti koje su razlogom za otkaz ovog Ugovora.</p>

								<p>6.3. Neovisno o prvom stavku ovog članka, Tvrtka može prijevremeno raskinuti ovaj Ugovor pisanom&nbsp;</p>

								<p>obavije&scaron;ću s trenutnim učinkom, bez obveze po&scaron;tivanja otkaznog roka pod sljedećim uvjetima:</p>

								<p>&bull; u slučaju ako Certifikator prekr&scaron;i bilo koju od svojih obveza utvrđenu ovim Ugovorom, a &scaron;to bi&nbsp;</p>

								<p>moglo imati za posljedicu nastanak materijalne &scaron;tete za Tvrtku;</p>

								<p>&bull; u slučaju da se nad Certifikatorom otvori stečajni, likvidacijski ili bilo koji drugi postupak&nbsp;</p>

								<p>prestanka dru&scaron;tva radi prezaduženosti, nesposobnosti za plaćanje &scaron;to rezultira nemogućno&scaron;ću&nbsp;</p>

								<p>Certifikatora za uredno izvr&scaron;avanje svojih obveza iz ovog Ugovora;&nbsp;</p>

								<p>&bull; u slučaju da Certifikator, nakon opomene upućene od strane Tvrke na ispunjavanje ugovornih&nbsp;</p>

								<p>obveza preuzetih ovim Ugovorom u dodatnom primjerenom roku koji je definiran i omogućen&nbsp;</p>

								<p>Certifikatoru od strane Tvrtke, Certifikator ne otkloni nepravilnosti koje su razlog za raskid ovog&nbsp;</p>

								<p>Ugovora;</p>

								<p>6.4. U slučaju raskida Ugovora sukladno prethodnom stavku ovog članka, Certifikator neće imati pravo&nbsp;</p>

								<p>na bilo kakvu naknadu &scaron;tete nastalu uslijed prijevremenog raskida, osim ako je to drugačije određeno&nbsp;</p>

								<p>važećim prisilnim propisima Republike Hrvatske.</p>

								<p>6.5. Ovaj Ugovor može prestati i sporazumnim putem, na način i pod uvjetima utvrđenim posebnim&nbsp;</p>

								<p>pisanim sporazumom o prestanku ovog Ugovora.</p>

								<p>Izmjene i dopune Ugovora</p>

								<p>Članak 7.</p>

								<p>Sve naknadne izmjene i dopune ovog Ugovora bit će valjane ako su sačinjene u pismenom obliku, uz&nbsp;</p>

								<p>suglasnost i potpis Ugovornih strana.</p>

								<p>Prijenos ovlasti</p>

								<p>Članak 8.</p>

								<p>Certifikator nije ovla&scaron;ten, bez prethodno pribavljene suglasnosti Tvrtke prenijeti svoje obveze iz ovog&nbsp;</p>

								<p>Ugovora na neku drugu pravnu ili fizičku osobu. Tvrtka ima pravo, bez bilo kakve prethodne suglasnosti&nbsp;</p>

								<p>Certifikatora, prenijeti sve ili dio obveza iz ovog Ugovora na bilo koje svoje povezano dru&scaron;tvo.&nbsp;</p>

								<p>Rje&scaron;avanje sporova i mjerodavno pravo</p>

								<p>Članak 9.</p>

								<p>Ugovorne strane će međusobne sporove rje&scaron;avati sporazumno, a ako to nije moguće, nadležan je sud u&nbsp;</p>

								<p>Zagrebu uz primjenu hrvatskog prava kao mjerodavnog prava.</p>

								<p>Djelomična ni&scaron;tavost</p>

								<p>Članak 10.</p>

								<p>10.1. Ako se bilo koja odredba ovog Ugovora dokaže ni&scaron;tavom, ostale odredbe ovog Ugovora će se u&nbsp;</p>

								<p>cijelosti primjenjivati i izvr&scaron;avati.</p>

								<p>10.2. U slučaju da dođe do ni&scaron;tavosti jedne ili vi&scaron;e odredaba ovog Ugovora, Ugovorne strane će&nbsp;</p>

								<p>odmah pristupiti zamjeni ni&scaron;tavih odredaba drugima, vodeći pri tome računa o tom da se izmijenjenim&nbsp;</p>

								<p>odredbama postigne isti stupanj zadovoljenja interesa Ugovornih strana, ali na način koji je dopu&scaron;ten.</p>

								<p>Povjerljivost</p>

								<p>Članak 11.</p>

								<p>11.1. Ugovorne strane se obvezuju ovaj Ugovor i sadržaj ovog Ugovora držati povjerljivim, te se obvezuju&nbsp;</p>

								<p>da neće, bez prethodne pisane suglasnosti druge Ugovorne strane, otkrivati neovla&scaron;tenim osobama ili bilo&nbsp;</p>

								<p>kojoj trećoj strani, informacije koje se odnose ili koje su u vezi s ovim Ugovorom.</p>

								<p>11.2. Niti jedna Ugovorna strana neće biti odgovorna za otkrivanje ili kori&scaron;tenje informacija koje:</p>

								<p>a) već jesu ili postanu poznate javnosti, osim putem povrede odredbi ovog Ugovora; ili</p>

								<p>b) se moraju otkriti na temelju zakona, sukladno zahtjevu nadležnog tijela.</p>

								<p>11.3. Ugovorna strana koja prekr&scaron;i obvezu čuvanja tajnosti podataka iz ovog članka Ugovora, bit će&nbsp;</p>

								<p>odgovorna za svu &scaron;tetu nastalu drugoj Ugovornoj strani, bez ograničenja.</p>

								<p>11.4. Ugovorne strane se obvezuju da će sadržaj ovog Ugovora čuvati povjerljivim bez ikakvog vremenskog&nbsp;</p>

								<p>ograničenja.</p>

								<p>Prava intelektualnog vlasni&scaron;tva</p>

								<p>Članak 12.</p>

								<p>12.1. Ugovorne strane su posebno suglasne da pripadajući know-how uz portal i on line servis &bdquo;enzo.hr&ldquo;&nbsp;</p>

								<p>pripada Tvrtki, te bilo koji podaci i informacije nastali pri izvr&scaron;enju ovog Ugovora pripadaju Tvrtki u mjeri u&nbsp;</p>

								<p>kojoj to nije u suprotnosti sa preuzetim ugovornim obvezama Ugovornih strana.</p>

								<p>12.2. Certifikator se posebno obvezuje da sve žigove, oznake ili ostala prava intelektualnog vlasni&scaron;tva koji&nbsp;</p>

								<p>sadrže u sebi riječ ili oznaku &bdquo;enzo.hr&ldquo;, Tvrtke i slične koje pripadaju Tvrtki, mogu koristiti jedino za svrhu&nbsp;</p>

								<p>ispunjenja obveza iz ovog Ugovora te se u druge svrhe ne smiju koristiti.</p>

								<p>Zavr&scaron;ne odredbe</p>

								<p>Članak 13.</p>

								<p>13.1. Ugovorne strane pročitav&scaron;i ovaj Ugovor suglasno utvrđuju da njegov sadržaj u cijelosti odgovara&nbsp;</p>

								<p>njihovim namjerama i volji, isti potpisuju u znak prihvaćanja međusobnih prava i obveza.</p>

								<p>13.2. Ovaj Ugovor je sastavljen u 2 (slovima: dva) primjerka koje Ugovorne strane u znak suglasnosti&nbsp;</p>

								<p>potpisuju, a od kojih svaka Ugovorna strana zadržava po 1 (slovima: jedan) primjerak.</p>

								<p>*****</p>

								<p>TVRTKA CERTIFIKATOR</p>

								<p>___________ _______________</p>

								<p>Direktor</p>

							  </div>
							  <div class="modal-footer">
								<button type="button" class="btn btn-default" data-dismiss="modal">U redu</button>
							  </div>
							</div>
						  </div>
						</div>

								
				</div>
			</div>
<?php
	include 'footer.php';
?>
