<?php
	$title = 'Registracija certifikatora';
	include 'header.php';
	if(!$fgmembersite->CheckLogin()) {
		$fgmembersite->RedirectToURL("index.php");
	}
	else if($fgmembersite->getMembershipType() != 'agent') $fgmembersite->RedirectToURL("index.php");
	?>
			<div role="main" class="main">
				<div id="content" class="register_member">

					<div class="home-intro light">
						<div class="container">

							<div class="row">
								<div class="col-md-8">
									<p style="font-family:Calibri,Arial,Helvetica;">
										Želite li više <em>klijenata</em> ?
										<span>Registirajte se.</span>
									</p>
								</div>
								<div class="col-md-4">
									<div class="get-started">
										<a href="#appl" class="btn btn-lg btn-primary disabled">Registracija</a>
									</div>
								</div>
							</div>

						</div>
					</div>
					<div style="position:relative;">
						<div class="container" style="position:relative;margin-top:60px;">
							<h3>Pretraga neregistriranih</h3>
							<div class="row">
								<div class="col-md-6">
									<input type="text" placeholder="Pretražite po imenu, prezimenu ili mail adresi" value=""  class="form-control unRegistered" name="unReg" id="unReg">
								</div>
								<p class="clear"></p>
								<div class="col-md-12">
									<div class="col-md-12 list-group" id="result"></div>
								</div>
							</div>
						</div>
					
						<div class="container regMem" style="position:relative;">
							<h3>Registracija certifikatora</h3>
									<form id="regMemberForm">
										<div class="row">
											<div class="form-group">
												<div class="col-md-4">
													<label>Vaš OIB</label>
													<input type="number" placeholder="12345678901" value="" data-msg-required="Molimo Vas da upišite svoj OIB." class="form-control validate numberO" name="oib" id="oib">
												</div>
												<div class="col-md-8">
													<label>Naziv osobe/tvrtke</label>
													<input type="text" placeholder="Upišite naziv" value="" data-msg-required="Molimo Vas da upišite svoje ime." maxlength="128" class="form-control validate lettO" name="naziv" id="naziv">
												</div>
											</div>
										</div>
										<div class="row">
											<div class="form-group">
												<div class="col-md-6">
													<label>Adresa</label>
													<input type="text" value="" placeholder="Unesite adresu"  maxlength="150" class="form-control validate combO" name="ulica" id="ulica">
												</div>
												<div class="col-md-3">
													<label>Županija</label>
													<select class="form-control validate" id="zupanija" name="zupanija">
														<?
															$fgmembersite->listRegions();	
														?>
													</select>
												</div>
												<div class="col-md-3">
													<label>Grad</label>
													<select class="form-control validate" id="grad" name="grad"><option value="0">Grad</option></select>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="form-group">
												<div class="col-md-3">
													<label>Broj ovlaštenja Ministarstva</label>
													<input type="text" value="" class="form-control validate" maxlength="9" placeholder="X-Y/YYYY" name="licenca" id="licenca">
												</div>
												<div class="col-md-3">
													<label>Vaša e-mail adresa</label>
													<input type="email" value="" class="form-control validate emailO1" placeholder="demo@email.com" name="email1" id="email1">
												</div>
												<div class="col-md-3">
													<label>Ponovite vašu e-mail adresu</label>
													<input type="email" value="" class="form-control validate emailO" placeholder="demo@email.com" name="email" id="email">
												</div>
												<div class="col-md-3">
													<label>Kontakt mob/tel</label>
													<input type="text" value="" maxlength="20" class="form-control validate mobO" placeholder="01 1234 567" name="kontaktm" id="kontaktm">
												</div>									
											</div>
										</div>
										<div class="row">
											<div class="form-group">
												<h3 class="col-md-12" style="margin:40px 0 20px;">Odaberite područje rada</h3>									
												<select class="form-control validate multipleCh" id="zupanija" name="zupanija[]" multiple='multiple'>
														<?
															$fgmembersite->listLocMult();	
														?>
												</select>
											</div>
										</div>
										<div class="row">
											<div class="form-group">
												<h3 class="col-md-12" style="margin:40px 0 20px;">Izaberite usluge/klase</h3>									
												<select id="servicesClass" name="servicesClass[]" multiple='multiple'>
													<? 
														$fgmembersite->listServices();												
													?>
												</select>
											</div>
										</div>
										<hr />
										<div class="modal-footer" style="border-top:0px;">
											<button type="button" id="scrollToTop" class="btn btn-success takeSer scroll-to-top disabled" data-hash >Registrirajte certifikatora <i class="icon icon-angle-double-right"></i></button>
										</div>
										
									</form>									
								</div>
						<div class="over overob" style="display:none;">
							<div class="container">
								<div class="success" style="display:none;">
									<div class="alert alert-success"><strong>Čestitamo!</strong> Uspješno ste registrirali novog certifikatora.</div>
									<div class="col-md-3"></div><a href="#" class="btn btn-success col-md-6 newReg">Shvaćam ! Pripremi novu registraciju</a>
								</div>
								<div class="failed" style="display:none;">
									<div class="alert alert-danger"><strong>Nažalost,</strong> registracija nije uspijela. Molimo provjerite podatke, te pokušajte ponovo.</div>
									<div class="col-md-3"></div><a href="#" class="btn btn-danger col-md-6 newReg">Uredu, vrati me na registraciju</a>
								</div>
							</div>
						</div>
					</div>
						
								
								
								
								

								<link rel="stylesheet" href="css/mselect.css">
								<script src="js/reg_cit.js"></script>
								<script src="js/selectOption.js"></script>
								<script src="vendor/jquery.js"></script>
								<script src="js/regMember.js"></script>
								<script src="js/multiselect.js"></script>
								<script src="js/quickSearch.js"></script>
								<script type="text/javascript">
										selectOption('optgroup');
										$('#servicesClass').multiSelect({ 
											selectableOptgroup: true
											});
										$('.multipleCh').multiSelect({ 													
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
												  },
												  afterSelect: function(){
													this.qs1.cache();
													this.qs2.cache();
												  },
												  afterDeselect: function(){
													this.qs1.cache();
													this.qs2.cache();
												  }

											});
										$('#optgroup').multiSelect({ 
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
										  },
										  afterSelect: function(){
											this.qs1.cache();
											this.qs2.cache();
										  },
										  afterDeselect: function(){
											this.qs1.cache();
											this.qs2.cache();
										  }
										});
								</script>
								
								
								
								
								
				</div>
			</div>
<?php
	include 'footer.php';
?>
