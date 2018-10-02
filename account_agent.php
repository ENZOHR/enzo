<?php
	$title = 'Korisnički račun';
	include 'header.php';
	
	if(!$fgmembersite->CheckLogin()) {
		$fgmembersite->RedirectToURL("index.php");
	}
	else if($fgmembersite->getMembershipType() != 'agent') $fgmembersite->RedirectToURL("index.php");

?>
			<div role="main" class="main">
				<div id="content" class="account_member">

					<div class="home-intro light">
						<div class="container">

							<div class="row">
								<div class="col-md-8">
									<p style="font-family:Calibri,Arial,Helvetica;">
										Ukoliko već nemate svoj <em>korisnički račun</em> ?
										<span>Registirajte se besplatno.</span>
									</p>
								</div>
								<div class="col-md-4">
									<div class="get-started">
										<a href="<?=$site_url;?>register.php" class="btn btn-lg btn-primary">Registracija</a>
									</div>
								</div>
							</div>

						</div>
					</div>
					
					<div class="container">

					<div class="row" style="margin-top:40px;">
						
						<div class="col-md-3">						
							<div class="panel-group" id="accordion">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="accordion-toggle collapsed" href="<?=$site_url;?>account_member.php">
												<i class="icon icon-comment"></i>
												Postavke računa
											</a>
										</h4>
									</div>
								</div>
							</div>						
						</div>
						
						
						<div class="col-md-9 services">
							<div class="featured-box featured-box-secundary default info-content" style="margin-top:0;">
								<div class="box-content">
									<h4>Postavke računa</h4>
									<p>
										<h1>Uskoro dostupno</h1>
										<br />
										<br />
										<br />
										<br />
									</p>
									<a href="http://dev.efortis.net/LN_hr/register.php" class="btn btn-success pull-right push-bottom">Spremi usluge</a>
									<p class="clear"></p>
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
